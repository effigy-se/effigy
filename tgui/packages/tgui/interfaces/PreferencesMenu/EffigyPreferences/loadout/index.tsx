import { Fragment, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { CharacterPreview } from 'tgui/interfaces/common/CharacterPreview';
import {
  Box,
  Button,
  Dimmer,
  Divider,
  Dropdown,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { SideDropdown } from '../../../../effigy/SideDropdown';
import { removeAllSkiplines } from '../../../TextInputModal';
import { PreferencesMenuData } from '../../types';
import { useServerPrefs } from '../../useServerPrefs';
import type {
  LoadoutCategory,
  LoadoutItem,
  LoadoutManagerData,
  typePath,
} from './base';
import { ItemIcon, LoadoutTabDisplay, SearchDisplay } from './ItemDisplay';
import { LoadoutModifyDimmer } from './ModifyPanel';

export function LoadoutPage(props) {
  const serverData = useServerPrefs();
  const loadout_tabs = serverData?.loadout.loadout_tabs || [];

  const [searchLoadout, setSearchLoadout] = useState('');
  const [selectedTabName, setSelectedTab] = useState(
    loadout_tabs?.[0].name || '',
  );
  const [modifyItemDimmer, setModifyItemDimmer] = useState<LoadoutItem | null>(
    null,
  );
  // Start Custom Loadouts
  const [managingPreset, _setManagingPreset] = useState<string | null>(null);
  const { act, data } = useBackend<PreferencesMenuData>();
  const [input, setInput] = useState('');
  const setManagingPreset = (value) => {
    _setManagingPreset(value);
    setInput('');
  };
  const onType = (value: string) => {
    if (value === input) {
      return;
    }
    setInput(removeAllSkiplines(value));
  };
  // End Custom Loadouts

  if (!serverData) {
    return <NoticeBox>Loading...</NoticeBox>;
  }

  return (
    <Stack vertical fill ml="-4px" mr="10px">
      <Stack.Item>
        {/* Start Custom Loadouts */}
        {!!managingPreset && (
          <Dimmer style={{ zIndex: '100' }}>
            <Stack
              vertical
              width="400px"
              backgroundColor="#101010"
              style={{
                borderRadius: '2px',
                position: 'relative',
                display: 'inline-block',
                padding: '5px',
              }}
            >
              <Stack.Item width="100%" backgroundColor="#454C5F">
                <Stack ml="5px">
                  <Stack.Item>{managingPreset} Loadout Preset</Stack.Item>
                  {managingPreset === 'Add' && (
                    <Stack.Item>
                      (
                      {
                        data.character_preferences.misc.loadout_lists.loadouts
                          .length
                      }{' '}
                      of 7 total)
                    </Stack.Item>
                  )}
                  <Stack.Item ml="auto">
                    <Button
                      icon="times"
                      color="red"
                      onClick={() => {
                        setManagingPreset(null);
                      }}
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item width="100%">
                <Input
                  placeholder="Loadout name"
                  width="100%"
                  maxLength={24}
                  onChange={onType}
                  onEnter={() => {
                    act(`${managingPreset.toLowerCase()}_loadout_preset`, {
                      name: input,
                    });
                    setManagingPreset(null);
                  }}
                  onEscape={() => setManagingPreset(null)}
                />
              </Stack.Item>
              <Stack.Item mt={1}>
                <Stack justify="center">
                  <Button
                    onClick={() => {
                      act(`${managingPreset.toLowerCase()}_loadout_preset`, {
                        name: input,
                      });
                      setManagingPreset(null);
                    }}
                  >
                    Done
                  </Button>
                </Stack>
              </Stack.Item>
            </Stack>
          </Dimmer>
        )}
        {/* End Custom Loadouts */}
        {!!modifyItemDimmer && (
          <LoadoutModifyDimmer
            modifyItemDimmer={modifyItemDimmer}
            setModifyItemDimmer={setModifyItemDimmer}
          />
        )}
        <Section
          ml="-2px"
          pt="4px"
          align="center"
          style={{
            backgroundColor: '#22262F',
          }}
        >
          <Stack>
            <Stack.Item grow>
              <Tabs fluid align="center" m={-1}>
                {loadout_tabs.map((curTab) => (
                  <Tabs.Tab
                    key={curTab.name}
                    selected={
                      searchLoadout.length <= 1 &&
                      curTab.name === selectedTabName
                    }
                    onClick={() => {
                      setSelectedTab(curTab.name);
                      setSearchLoadout('');
                    }}
                  >
                    <Box>
                      {curTab.category_icon && (
                        <Icon name={curTab.category_icon} mr={1} />
                      )}
                      {curTab.name}
                    </Box>
                  </Tabs.Tab>
                ))}
              </Tabs>
            </Stack.Item>
            <Stack.Item align="center" mt="-3px" mr="-6px">
              <Input
                width="150px"
                onChange={setSearchLoadout}
                placeholder="Search for an item..."
                value={searchLoadout}
                minHeight="21px"
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <LoadoutTabs
          loadout_tabs={loadout_tabs}
          currentTab={selectedTabName}
          currentSearch={searchLoadout}
          modifyItemDimmer={modifyItemDimmer}
          setModifyItemDimmer={setModifyItemDimmer}
          setManagingPreset={setManagingPreset}
        />
      </Stack.Item>
    </Stack>
  );
}

type LoadoutTabsProps = {
  loadout_tabs: LoadoutCategory[];
  currentTab: string;
  currentSearch: string;
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
  setManagingPreset: (string) => void;
};

function LoadoutTabs(props: LoadoutTabsProps) {
  const {
    loadout_tabs,
    currentTab,
    currentSearch,
    modifyItemDimmer,
    setModifyItemDimmer,
    setManagingPreset,
  } = props;
  const activeCategory = loadout_tabs.find((curTab) => {
    return curTab.name === currentTab;
  });
  const searching = currentSearch.length > 1;

  const { act, data } = useBackend<PreferencesMenuData>();

  return (
    <Stack fill height="470px">
      <Stack.Item align="center" width="250px" height="100%">
        <Stack vertical fill>
          <Stack.Item height="50%">
            <LoadoutPreviewSection />
          </Stack.Item>
          {/* Start Custom Loadouts */}
          <Stack.Item>
            <Section title="Saved Loadouts" pl={1}>
              <Stack>
                <Stack.Item>
                  <Dropdown
                    width="150px"
                    options={
                      data.character_preferences.misc.loadout_lists.loadouts
                    }
                    selected={data.character_preferences.misc.loadout_index}
                    onSelected={(value) =>
                      act('set_loadout_preset', { name: value })
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button.Confirm
                    mr="5px"
                    pt="2px"
                    icon="times"
                    color="red"
                    align="center"
                    disabled={
                      data.character_preferences.misc.loadout_index ===
                      'Default'
                    }
                    tooltip={
                      data.character_preferences.misc.loadout_index ===
                      'Default'
                        ? "Can't delete the default loadout entry."
                        : 'Delete loadout'
                    }
                    onClick={() => act('remove_loadout_preset')}
                  />
                  <Button
                    mr="5px"
                    pt="2px"
                    icon="plus"
                    color="blue"
                    align="center"
                    tooltip="Add loadout"
                    onClick={() => setManagingPreset('Add')}
                  />
                  <Button
                    pt="2px"
                    icon="pen"
                    align="center"
                    tooltip="Rename loadout"
                    onClick={() => setManagingPreset('Rename')}
                    disabled={
                      data.character_preferences.misc.loadout_index ===
                      'Default'
                    }
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          {/* End Custom Loadouts */}
          <Stack.Item grow>
            <LoadoutSelectedSection
              all_tabs={loadout_tabs}
              modifyItemDimmer={modifyItemDimmer}
              setModifyItemDimmer={setModifyItemDimmer}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        {searching || activeCategory?.contents ? (
          <Section
            title={searching ? 'Search Results' : 'Catalog'}
            fill
            scrollable
            buttons={
              activeCategory?.category_info ? (
                <Box italic mt={0.5}>
                  {activeCategory.category_info}
                </Box>
              ) : null
            }
          >
            <Stack vertical>
              <Stack.Item>
                {searching ? (
                  <SearchDisplay
                    loadout_tabs={loadout_tabs}
                    currentSearch={currentSearch}
                  />
                ) : (
                  <LoadoutTabDisplay category={activeCategory} />
                )}
              </Stack.Item>
            </Stack>
          </Section>
        ) : (
          <Section fill>
            <Box>No contents for selected tab.</Box>
          </Section>
        )}
      </Stack.Item>
    </Stack>
  );
}

function typepathToLoadoutItem(
  typepath: typePath,
  all_tabs: LoadoutCategory[],
) {
  // Maybe a bit inefficient, could be replaced with a hashmap?
  for (const tab of all_tabs) {
    for (const item of tab.contents) {
      if (item.path === typepath) {
        return item;
      }
    }
  }
  return null;
}

type LoadoutSelectedItemProps = {
  path: typePath;
  all_tabs: LoadoutCategory[];
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
};

function LoadoutSelectedItem(props: LoadoutSelectedItemProps) {
  const { all_tabs, path, modifyItemDimmer, setModifyItemDimmer } = props;
  const { act } = useBackend();

  const item = typepathToLoadoutItem(path, all_tabs);
  if (!item) {
    return null;
  }

  return (
    <Stack align={'center'}>
      <Stack.Item>
        <ItemIcon item={item} scale={1} />
      </Stack.Item>
      <Stack.Item width="55%">{item.name}</Stack.Item>
      {item.buttons.length ? (
        <Stack.Item>
          <Button
            color="none"
            width="32px"
            onClick={() => {
              setModifyItemDimmer(item);
            }}
          >
            <Icon size={1.8} name="cogs" color="grey" />
          </Button>
        </Stack.Item>
      ) : (
        <Stack.Item width="32px" /> // empty space
      )}
      <Stack.Item>
        <Button
          color="none"
          width="32px"
          onClick={() => act('select_item', { path: path, deselect: true })}
        >
          <Icon size={2.4} name="times" color="red" />
        </Button>
      </Stack.Item>
    </Stack>
  );
}

type LoadoutSelectedSectionProps = {
  all_tabs: LoadoutCategory[];
  modifyItemDimmer: LoadoutItem | null;
  setModifyItemDimmer: (dimmer: LoadoutItem | null) => void;
};

function LoadoutSelectedSection(props: LoadoutSelectedSectionProps) {
  const { act, data } = useBackend<LoadoutManagerData>();
  const loadout_list = data.character_preferences.misc.loadout_lists.loadout;
  const { all_tabs, modifyItemDimmer, setModifyItemDimmer } = props;

  return (
    <Section
      title="Selected Items"
      scrollable
      fill
      pl={1}
      buttons={
        <Button.Confirm
          icon="times"
          color="red"
          align="center"
          disabled={!loadout_list || Object.keys(loadout_list).length === 0}
          tooltip="Clears ALL selected items from all categories."
          onClick={() => act('clear_all_items')}
        >
          Clear All
        </Button.Confirm>
      }
    >
      {loadout_list &&
        Object.entries(loadout_list).map(([path, item]) => (
          <Fragment key={path}>
            <LoadoutSelectedItem
              path={path}
              all_tabs={all_tabs}
              modifyItemDimmer={modifyItemDimmer}
              setModifyItemDimmer={setModifyItemDimmer}
            />
            <Divider />
          </Fragment>
        ))}
    </Section>
  );
}

function LoadoutPreviewSection() {
  const { act, data } = useBackend<LoadoutManagerData>();

  return (
    <Section fill pl={1} title="Character">
      <Stack vertical fill>
        <Stack.Item grow align="center">
          <CharacterPreview height="100%" id={data.character_preview_view} />
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item align="center">
          <Stack>
            <Stack.Item>
              <Button
                icon="undo"
                onClick={() =>
                  act('rotate_dummy', {
                    dir: 'right',
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="redo"
                onClick={() =>
                  act('rotate_dummy', {
                    dir: 'left',
                  })
                }
              />
            </Stack.Item>
            <Stack.Item>
              <SideDropdown
                width="170px"
                selected={data.character_preview_selection}
                options={data.character_preview_styles}
                onSelected={(value) =>
                  act('update_preview', {
                    updated_preview: value,
                  })
                }
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
