import { Button, Section } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';
import { capitalizeFirst } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';

type InteractionMenuProps = {
  emotes: Record<string, BooleanLike>;
};

export const InteractionMenu = (props) => {
  const { act, data } = useBackend<InteractionMenuProps>();
  const { emotes } = data;

  return (
    <Window width={500} height={600}>
      <Window.Content scrollable>
        <Section>
          {Object.keys(emotes)
            .sort()
            .map((emote) => {
              return (
                <Button
                  width="150.5px"
                  key={emote}
                  // lineHeight={1.75}
                  icon="exclamation-circle"
                  disabled={!emotes[emote]}
                  onClick={() =>
                    act('run_emote', {
                      emote: emote,
                    })
                  }
                >
                  {capitalizeFirst(emote)}
                </Button>
              );
            })}
        </Section>
      </Window.Content>
    </Window>
  );
};
