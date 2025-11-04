import { ReactNode, useState } from 'react';
import { Button, ByondUi, Section, Stack } from 'tgui-core/components';

import { resolveAsset } from '../../../assets';
import { useBackend } from '../../../backend';
import { Window } from '../../../layouts';
import { ExaminePanelData } from './data';

function formatURLs(text: string) {
  if (!text) return;
  const parts: ReactNode[] = [];
  let regex = /https?:\/\/[^\s/$.?#].[^\s]*/gi;
  let lastIndex = 0;

  text.replace(regex, (url, index) => {
    parts.push(text.substring(lastIndex, index));
    parts.push(
      <a
        style={{
          color: 'hsl(195, 100%, 59%)',
          textDecoration: 'none',
          borderBottom: 'solid 1.25px',
        }}
        href={url}
      >
        {url}
      </a>,
    );
    lastIndex = index + url.length;
    return url;
  });

  parts.push(text.substring(lastIndex));

  return <div>{parts}</div>;
}

export function ExaminePanel(props) {
  const { data } = useBackend<ExaminePanelData>();
  const {
    character_name,
    assigned_map,
    flavour_text,
    ooc_notes,
    custom_species,
    custom_species_lore,
    headshot,
  } = data;

  // This does not fix the screwy character preview problem,
  // however, it does make it work right now. I am so sorry.
  const [previewKey, setPreviewKey] = useState(0);
  if (previewKey === 0 && assigned_map) {
    setTimeout(() => {
      setPreviewKey(1);
    }, 200);
  }

  return (
    <Window title={character_name} width={900} height={720}>
      <Window.Content>
        <Stack fill>
          <Stack.Item width="30%">
            {!headshot ? (
              <Section
                fill
                title="Character Preview"
                fontSize="13px"
              >
                <ByondUi
                  key={previewKey}
                  height="100%"
                  width="100%"
                  className="ExaminePanel__map"
                  params={{
                    id: assigned_map,
                    type: 'map',
                  }}
                />
              </Section>
            ) : (
              <>
                <Section
                  height="305px"
                  title="Character Preview"
                  fontSize="13px"
                >
                  <ByondUi
                    key={previewKey}
                    height="260px"
                    width="100%"
                    className="ExaminePanel__map"
                    params={{
                      id: assigned_map,
                      type: 'map',
                    }}
                  />
                </Section>
                <Section
                  height="265px"
                  title="Headshot"
                  fontSize="13px"
                >
                  <img
                    src={resolveAsset(headshot)}
                    height="250px"
                    width="250px"
                  />
                </Section>
              </>
            )}
          </Stack.Item>
          <Stack.Item grow>
            <Stack fill vertical>
              <Stack.Item grow>
                <Section
                  height="305px"
                  scrollable
                  fill
                  preserveWhitespace
                  title="Flavour Text"
                  fontSize="13px"
                  lineHeight="1.5"
                  mt="0px"
                >
                {formatURLs(flavour_text)}
                </Section>
              </Stack.Item>
              <Stack.Item grow>
                <Stack fill>
                  <Stack.Item grow basis={0}>
                    <Section
                      scrollable
                      fill
                      preserveWhitespace
                      title="OOC Notes"
                      fontSize="13px"
                      lineHeight="1.5"
                    >
                    {formatURLs(ooc_notes)}
                    </Section>
                  </Stack.Item>
                  <Stack.Item grow basis={0}>
                    <Section
                      scrollable
                      fill
                      preserveWhitespace
                      fontSize="13px"
                      lineHeight="1.5"
                      title={
                        custom_species
                          ? `${custom_species}`
                          : 'No Custom Species!'
                      }
                    >
                      {custom_species
                        ? formatURLs(custom_species_lore)
                        : 'Just a normal space dweller.'}

                    </Section>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}
