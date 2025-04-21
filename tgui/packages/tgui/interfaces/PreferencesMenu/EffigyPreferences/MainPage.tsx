import { filter, map, sortBy } from 'common/collections';
import { ReactNode, useState } from 'react';
import { sendAct, useBackend } from 'tgui/backend';
import {
  Autofocus,
  Box,
  Button,
  Flex,
  Input,
  LabeledList,
  Popper,
  Stack,
} from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';
import { classes } from 'tgui-core/react';
import { createSearch } from 'tgui-core/string';

import { SideDropdown } from '../../../effigy/SideDropdown';
import { CharacterPreview } from '../../common/CharacterPreview';
import { PageButton } from '../components/PageButton';
import { RandomizationButton } from '../components/RandomizationButton';
import { features } from '../preferences/features';
import {
  FeatureChoicedServerData,
  FeatureValueInput,
} from '../preferences/features/base';
import { Gender, GENDERS } from '../preferences/gender';
import {
  createSetPreference,
  PreferencesMenuData,
  RandomSetting,
  ServerData,
} from '../types';
import { useRandomToggleState } from '../useRandomToggleState';
import { useServerPrefs } from '../useServerPrefs';
import { DeleteCharacterPopup } from './DeleteCharacterPopup';
import { MultiNameInput, NameInput } from './names';

const CLOTHING_CELL_SIZE = 72;
const CLOTHING_SIDEBAR_ROWS = 8.05;

const CLOTHING_SELECTION_CELL_SIZE = 72;
const CLOTHING_SELECTION_WIDTH = 8.3;
const CLOTHING_SELECTION_MULTIPLIER = 4.3;

type CharacterControlsProps = {
  handleRotate: () => void;
  handleOpenSpecies: () => void;
  gender: Gender;
  setGender: (gender: Gender) => void;
  showGender: boolean;
  canDeleteCharacter: boolean;
  handleDeleteCharacter: () => void;
};

function CharacterControls(props: CharacterControlsProps) {
  return (
    <Stack>
      <Stack.Item>
        <Button
          onClick={props.handleRotate}
          fontSize="22px"
          icon="undo"
          tooltip="Rotate"
          tooltipPosition="top"
        />
      </Stack.Item>

      <Stack.Item>
        <Button
          onClick={props.handleRotate}
          fontSize="22px"
          icon="redo"
          tooltip="Rotate"
          tooltipPosition="top"
        />
      </Stack.Item>

      <Stack.Item>
        <Button
          onClick={props.handleOpenSpecies}
          fontSize="22px"
          icon="paw"
          tooltip="Species"
          tooltipPosition="top"
        />
      </Stack.Item>

      {props.showGender && (
        <Stack.Item>
          <GenderButton
            gender={props.gender}
            handleSetGender={props.setGender}
          />
        </Stack.Item>
      )}

      <Stack.Item>
        <Button
          onClick={props.handleDeleteCharacter}
          fontSize="22px"
          icon="trash"
          color="red"
          tooltip="Delete Character"
          tooltipPosition="top"
          disabled={!props.canDeleteCharacter}
        />
      </Stack.Item>
    </Stack>
  );
}

type ChoicedSelectionProps = {
  name: string;
  catalog: FeatureChoicedServerData;
  selected: string;
  supplementalFeature?: string;
  supplementalValue?: unknown;
  onClose: () => void;
  onSelect: (value: string) => void;
};

function ChoicedSelection(props: ChoicedSelectionProps) {
  const { catalog, supplementalFeature, supplementalValue } = props;
  const [getSearchText, searchTextSet] = useState('');
  const { act } = useBackend<PreferencesMenuData>();

  if (!catalog.icons) {
    return <Box color="red">Provided catalog had no icons!</Box>;
  }

  return (
    <Box
      className="ChoicedSelection"
      style={{
        padding: '5px',
        background: 'hsl(224, 16%, 12%)',
        height: `${
          CLOTHING_SELECTION_CELL_SIZE * CLOTHING_SELECTION_MULTIPLIER
        }px`,
        width: `${CLOTHING_SELECTION_CELL_SIZE * CLOTHING_SELECTION_WIDTH}px`,
      }}
    >
      <Stack vertical fill>
        <Stack.Item>
          <Stack fill>
            {supplementalFeature && (
              <Stack.Item ml={0.2} mt={0.5}>
                <FeatureValueInput
                  act={act}
                  feature={features[supplementalFeature]}
                  featureId={supplementalFeature}
                  shrink
                  value={supplementalValue}
                />
              </Stack.Item>
            )}

            <Stack.Item grow mr={6}>
              <Box
                style={{
                  fontWeight: 'bold',
                  fontSize: '18px',
                  color: 'hsl(224, 16%, 92%)',
                  textAlign: 'center',
                }}
              >
                {props.name}
              </Box>
            </Stack.Item>

            <Stack.Item>
              <Button
                style={{
                  fontWeight: 'bold',
                  fontSize: '14px',
                  textAlign: 'center',
                }}
                color="#424651"
                onClick={props.onClose}
              >
                x
              </Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>

        <Stack.Item overflowX="hidden" overflowY="scroll">
          <Autofocus>
            <Input
              placeholder=""
              style={{
                margin: '0px 5px',
                width: '83.5%',
              }}
              onInput={(_, value) => searchTextSet(value)}
            />
            <Flex wrap>
              {searchInCatalog(getSearchText, catalog.icons).map(
                ([name, image], index) => {
                  return (
                    <Flex.Item
                      key={index}
                      basis={`${CLOTHING_SELECTION_CELL_SIZE}px`}
                      style={{
                        padding: '5px',
                      }}
                    >
                      <Button
                        onClick={() => {
                          props.onSelect(name);
                        }}
                        selected={name === props.selected}
                        tooltip={name}
                        tooltipPosition="right"
                        style={{
                          height: `${CLOTHING_SELECTION_CELL_SIZE}px`,
                          width: `${CLOTHING_SELECTION_CELL_SIZE}px`,
                        }}
                      >
                        <Box
                          className={classes([
                            'preferences32x32',
                            image,
                            'centered-image',
                          ])}
                          style={{
                            transform:
                              'translateX(-50%) translateY(-50%) scale(2)',
                          }}
                        />
                      </Button>
                      <Box
                        textAlign="center"
                        fontSize="14"
                        width="86%"
                        color="hsl(224, 16%, 92%)"
                      >
                        {name}
                      </Box>
                    </Flex.Item>
                  );
                },
              )}
            </Flex>
          </Autofocus>
        </Stack.Item>
      </Stack>
    </Box>
  );
}

function searchInCatalog(searchText = '', catalog: Record<string, string>) {
  let items = Object.entries(catalog);
  if (searchText) {
    items = filter(
      items,
      createSearch(searchText, ([name, _icon]) => name),
    );
  }
  return items;
}

type GenderButtonProps = {
  handleSetGender: (gender: Gender) => void;
  gender: Gender;
};

function GenderButton(props: GenderButtonProps) {
  const [genderMenuOpen, setGenderMenuOpen] = useState(false);

  return (
    <Popper
      isOpen={genderMenuOpen}
      onClickOutside={() => setGenderMenuOpen(false)}
      placement="right-end"
      content={
        <Stack backgroundColor="white" ml={0.5} p={0.3}>
          {[Gender.Male, Gender.Female, Gender.Other, Gender.Other2].map(
            (gender) => {
              return (
                <Stack.Item key={gender}>
                  <Button
                    selected={gender === props.gender}
                    onClick={() => {
                      props.handleSetGender(gender);
                      setGenderMenuOpen(false);
                    }}
                    fontSize="22px"
                    icon={GENDERS[gender].icon}
                    tooltip={GENDERS[gender].text}
                    tooltipPosition="top"
                  />
                </Stack.Item>
              );
            },
          )}
        </Stack>
      }
    >
      <Button
        onClick={() => {
          setGenderMenuOpen(!genderMenuOpen);
        }}
        fontSize="22px"
        icon={GENDERS[props.gender].icon}
        tooltip="Gender"
        tooltipPosition="top"
      />
    </Popper>
  );
}

type CatalogItem = {
  name: string;
  supplemental_feature?: string;
};

type MainFeatureProps = {
  catalog: FeatureChoicedServerData & CatalogItem;
  currentValue: string;
  isOpen: boolean;
  handleClose: () => void;
  handleOpen: () => void;
  handleSelect: (newClothing: string) => void;
  randomization?: RandomSetting;
  setRandomization: (newSetting: RandomSetting) => void;
};

function MainFeature(props: MainFeatureProps) {
  const { data } = useBackend<PreferencesMenuData>();

  const {
    catalog,
    currentValue,
    isOpen,
    handleOpen,
    handleClose,
    handleSelect,
    randomization,
    setRandomization,
  } = props;

  const supplementalFeature = catalog.supplemental_feature;

  return (
    <Popper
      placement="bottom-start"
      isOpen={isOpen}
      onClickOutside={handleClose}
      baseZIndex={1} // Below the default popper at z 2
      content={
        <ChoicedSelection
          name={catalog.name}
          catalog={catalog}
          selected={currentValue}
          supplementalFeature={supplementalFeature}
          supplementalValue={
            supplementalFeature &&
            data.character_preferences.supplemental_features[
              supplementalFeature
            ]
          }
          onClose={handleClose}
          onSelect={handleSelect}
        />
      }
    >
      <Button
        onClick={(event) => {
          event.stopPropagation();
          if (isOpen) {
            handleClose();
          } else {
            handleOpen();
          }
        }}
        style={{
          height: `${CLOTHING_CELL_SIZE}px`,
          width: `${CLOTHING_CELL_SIZE}px`,
        }}
        color="blue"
        position="relative"
        tooltip={catalog.name}
        tooltipPosition="right"
      >
        <Box
          className={classes([
            'preferences32x32',
            catalog.icons![currentValue],
            'centered-image',
          ])}
          style={{
            transform: randomization
              ? 'translateX(-70%) translateY(-70%) scale(2)'
              : 'translateX(-50%) translateY(-50%) scale(2)',
          }}
        />

        {randomization && (
          <RandomizationButton
            dropdownProps={{
              dropdownStyle: {
                bottom: 0,
                position: 'absolute',
                right: '1px',
              },

              onOpen: (event) => {
                // We're a button inside a button.
                // Did you know that's against the W3C standard? :)
                event.cancelBubble = true;
                event.stopPropagation();
              },
            }}
            value={randomization}
            setValue={setRandomization}
          />
        )}
      </Button>
      <Box
        mt="-3px"
        mb="5px"
        style={{
          // Text below feature buttons
          height: `14px`,
          width: `${CLOTHING_CELL_SIZE}px`,
          overflowWrap: 'anywhere',
        }}
        textAlign="center"
        textColor="hsl(224, 16%, 92%)"
      >
        {catalog.name}
      </Box>
    </Popper>
  );
}

const createSetRandomization =
  (act: typeof sendAct, preference: string) => (newSetting: RandomSetting) => {
    act('set_random_preference', {
      preference,
      value: newSetting,
    });
  };

function sortPreferences(array: [string, unknown][]) {
  return sortBy(array, ([featureId, _]) => {
    const feature = features[featureId];
    return feature?.name;
  });
}

type PreferenceListProps = {
  preferences: Record<string, unknown>;
  randomizations: Record<string, RandomSetting>;
  maxHeight: string;
  children?: ReactNode;
};

export function PreferenceList(props: PreferenceListProps) {
  const { act } = useBackend<PreferencesMenuData>();
  const { preferences, randomizations, maxHeight, children } = props;

  return (
    <Stack.Item
      basis="50%"
      grow
      style={{
        padding: '4px',
      }}
      overflowX="hidden"
      overflowY="auto"
      maxHeight={maxHeight}
    >
      <LabeledList>
        {sortPreferences(Object.entries(preferences)).map(
          ([featureId, value]) => {
            const feature = features[featureId];
            const randomSetting = randomizations[featureId];

            if (feature === undefined) {
              return (
                <Stack.Item key={featureId}>
                  <b>Feature {featureId} is not recognized.</b>
                </Stack.Item>
              );
            }

            return (
              <LabeledList.Item
                key={featureId}
                label={feature.name}
                tooltip={feature.description}
                verticalAlign="middle"
              >
                <Stack fill>
                  {randomSetting && (
                    <Stack.Item>
                      <RandomizationButton
                        setValue={createSetRandomization(act, featureId)}
                        value={randomSetting}
                      />
                    </Stack.Item>
                  )}

                  <Stack.Item grow>
                    <FeatureValueInput
                      act={act}
                      feature={feature}
                      featureId={featureId}
                      value={value}
                    />
                  </Stack.Item>
                </Stack>
              </LabeledList.Item>
            );
          },
        )}
      </LabeledList>

      {children}
    </Stack.Item>
  );
}

export function getRandomization(
  preferences: Record<string, unknown>,
  serverData: ServerData | undefined,
  randomBodyEnabled: boolean,
): Record<string, RandomSetting> {
  if (!serverData) {
    return {};
  }

  const { data } = useBackend<PreferencesMenuData>();

  if (!randomBodyEnabled) {
    return {};
  }

  return Object.fromEntries(
    map(
      filter(Object.keys(preferences), (key) =>
        serverData.random.randomizable.includes(key),
      ),
      (key) => [
        key,
        data.character_preferences.randomization[key] || RandomSetting.Disabled,
      ],
    ),
  );
}

type MainPageProps = {
  openSpecies: () => void;
};

export function MainPage(props: MainPageProps) {
  const { act, data } = useBackend<PreferencesMenuData>();
  const [currentClothingMenu, setCurrentClothingMenu] = useState<string | null>(
    null,
  );
  const [deleteCharacterPopupOpen, setDeleteCharacterPopupOpen] =
    useState(false);
  const [multiNameInputOpen, setMultiNameInputOpen] = useState(false);
  const [randomToggleEnabled] = useRandomToggleState();

  const serverData = useServerPrefs();

  const currentSpeciesData =
    serverData && serverData.species[data.character_preferences.misc.species];

  const contextualPreferences =
    data.character_preferences.secondary_features || [];

  const mainFeatures = [
    ...Object.entries(data.character_preferences.clothing),
    ...Object.entries(data.character_preferences.features).filter(
      ([featureName]) => {
        if (!currentSpeciesData) {
          return false;
        }

        return currentSpeciesData.enabled_features.indexOf(featureName) !== -1;
      },
    ),
  ];

  const randomBodyEnabled =
    data.character_preferences.non_contextual.random_body !==
      RandomSetting.Disabled || randomToggleEnabled;

  const randomizationOfMainFeatures = getRandomization(
    Object.fromEntries(mainFeatures),
    serverData,
    randomBodyEnabled,
  );

  const nonContextualPreferences = {
    ...data.character_preferences.non_contextual,
  };

  if (randomBodyEnabled) {
    nonContextualPreferences['random_species'] =
      data.character_preferences.randomization['species'];
  } else {
    // We can't use random_name/is_accessible because the
    // server doesn't know whether the random toggle is on.
    delete nonContextualPreferences['random_name'];
  }

  // EffigyEdit Add - Character Preferences
  enum PrefPage {
    Character,
    Markings,
    Augments,
    NonContextual,
    Profile,
  }

  const [currentPrefPage, setCurrentPrefPage] = useState(PrefPage.Character);

  const markingPreferences = {
    ...data.character_preferences.markings,
  };

  const augmentPreferences = {
    ...data.character_preferences.augments,
  };

  const profilePreferences = {
    ...data.character_preferences.profile,
  };

  let prefPageContents;
  switch (currentPrefPage) {
    case PrefPage.Character:
      prefPageContents = (
        <PreferenceList
          randomizations={getRandomization(
            contextualPreferences,
            serverData,
            randomBodyEnabled,
          )}
          preferences={contextualPreferences}
          maxHeight="auto"
        />
      );
      break;
    case PrefPage.Markings:
      prefPageContents = (
        <PreferenceList
          randomizations={getRandomization(
            contextualPreferences,
            serverData,
            randomBodyEnabled,
          )}
          preferences={markingPreferences}
          maxHeight="auto"
        />
      );
      break;
    case PrefPage.Augments:
      prefPageContents = (
        <PreferenceList
          randomizations={getRandomization(
            contextualPreferences,
            serverData,
            randomBodyEnabled,
          )}
          preferences={augmentPreferences}
          maxHeight="auto"
        />
      );
      break;
    case PrefPage.NonContextual:
      prefPageContents = (
        <PreferenceList
          randomizations={getRandomization(
            contextualPreferences,
            serverData,
            randomBodyEnabled,
          )}
          preferences={nonContextualPreferences}
          maxHeight="auto"
        />
      );
      break;
    case PrefPage.Profile:
      prefPageContents = (
        <PreferenceList
          randomizations={getRandomization(
            contextualPreferences,
            serverData,
            randomBodyEnabled,
          )}
          preferences={profilePreferences}
          maxHeight="auto"
        />
      );
      break;
    default:
      exhaustiveCheck(currentPrefPage);
  }
  // EffigyEdit Add End

  return (
    <>
      {multiNameInputOpen && (
        <MultiNameInput
          handleClose={() => setMultiNameInputOpen(false)}
          handleRandomizeName={(preference) =>
            act('randomize_name', {
              preference,
            })
          }
          handleUpdateName={(nameType, value) =>
            act('set_preference', {
              preference: nameType,
              value,
            })
          }
          names={data.character_preferences.names}
        />
      )}

      {deleteCharacterPopupOpen && (
        <DeleteCharacterPopup
          close={() => setDeleteCharacterPopupOpen(false)}
        />
      )}

      <Stack height="485px" ml="-3px">
        <Stack.Item>
          <Stack vertical height="512px">
            <Stack.Item>
              <CharacterControls
                gender={data.character_preferences.misc.gender}
                handleOpenSpecies={props.openSpecies}
                handleRotate={() => {
                  act('rotate');
                }}
                setGender={createSetPreference(act, 'gender')}
                showGender={
                  currentSpeciesData ? !!currentSpeciesData.sexes : true
                }
                canDeleteCharacter={
                  Object.values(data.character_profiles).filter(
                    (name) => !!name,
                  ).length > 1
                }
                handleDeleteCharacter={() => setDeleteCharacterPopupOpen(true)}
              />
            </Stack.Item>

            <Stack.Item mt="0px">
              <SideDropdown
                width="100%"
                selected={data.character_preview_selection}
                options={data.character_preview_styles}
                onSelected={(value) =>
                  act('update_preview', {
                    updated_preview: value,
                  })
                }
              />
            </Stack.Item>

            <Stack.Item grow mt="2px" mr="-5px">
              <CharacterPreview
                height="100%"
                id={data.character_preview_view}
              />
            </Stack.Item>

            <Stack.Item mr="1px">
              <NameInput
                name={data.character_preferences.names[data.name_to_use]}
                handleUpdateName={createSetPreference(act, data.name_to_use)}
                openMultiNameInput={() => {
                  setMultiNameInputOpen(true);
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>

        <Stack.Item width="490px" ml="8px">
          <Stack>
            <Stack.Item grow>
              <PageButton
                currentPage={currentPrefPage}
                page={PrefPage.Character}
                setPage={setCurrentPrefPage}
              >
                Physical
              </PageButton>
            </Stack.Item>
            <Stack.Item grow ml="5px">
              <PageButton
                currentPage={currentPrefPage}
                page={PrefPage.Markings}
                setPage={setCurrentPrefPage}
              >
                Markings
              </PageButton>
            </Stack.Item>
            <Stack.Item grow ml="5px">
              <PageButton
                currentPage={currentPrefPage}
                page={PrefPage.Augments}
                setPage={setCurrentPrefPage}
              >
                Augments
              </PageButton>
            </Stack.Item>
            <Stack.Item grow ml="5px">
              <PageButton
                currentPage={currentPrefPage}
                page={PrefPage.NonContextual}
                setPage={setCurrentPrefPage}
              >
                Misc
              </PageButton>
            </Stack.Item>
            <Stack.Item grow ml="5px">
              <PageButton
                currentPage={currentPrefPage}
                page={PrefPage.Profile}
                setPage={setCurrentPrefPage}
              >
                Profile
              </PageButton>
            </Stack.Item>
          </Stack>

          <Stack vertical fill>
            <Stack.Divider />
            {prefPageContents}
          </Stack>
        </Stack.Item>

        <Stack.Item width="235px" ml="3px">
          <Stack height="512px" width="0px" vertical wrap>
            {mainFeatures.map(([clothingKey, clothing]) => {
              const catalog = serverData?.[
                clothingKey
              ] as FeatureChoicedServerData & {
                name: string;
              };

              return (
                <Stack.Item key={clothingKey} mt="0" mb="0px" pl="10px">
                  {!catalog ? (
                    // Skeleton button
                    <Button height={4} width={4} disabled />
                  ) : (
                    <MainFeature
                      catalog={catalog}
                      currentValue={clothing}
                      isOpen={currentClothingMenu === clothingKey}
                      handleClose={() => {
                        setCurrentClothingMenu(null);
                      }}
                      handleOpen={() => {
                        setCurrentClothingMenu(clothingKey);
                      }}
                      handleSelect={createSetPreference(act, clothingKey)}
                      randomization={randomizationOfMainFeatures[clothingKey]}
                      setRandomization={createSetRandomization(
                        act,
                        clothingKey,
                      )}
                    />
                  )}
                </Stack.Item>
              );
            })}
          </Stack>
        </Stack.Item>
      </Stack>
    </>
  );
}
