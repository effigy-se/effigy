import { Suspense, useEffect, useState } from 'react';
import { exhaustiveCheck } from 'tgui-core/exhaustive';
import { fetchRetry } from 'tgui-core/http';

import { resolveAsset } from '../../assets';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { logger } from '../../logging';
import { LoadingScreen } from '../common/LoadingScreen';
import { CharacterPreferenceWindow } from './EffigyPreferences'; // EffigyEdit Change - Character Preferences - Original: './CharacterPreferences';
import { GamePreferenceWindow } from './GamePreferences';
import {
  GamePreferencesSelectedPage,
  type PreferencesMenuData,
  PrefsWindow,
  type ServerData,
} from './types';
import { RandomToggleState } from './useRandomToggleState';
import { ServerPrefs } from './useServerPrefs';

export function PreferencesMenu(props) {
  return (
    /* EffigyEdit Change - Character Preferences - Original 920x770 */
    <Window width={1159} height={700}>
      <Window.Content>
        <Suspense fallback={<LoadingScreen />}>
          <PrefsWindowInner />
        </Suspense>
      </Window.Content>
    </Window>
  );
}

/** We're abstracting this by one level to use Suspense */
function PrefsWindowInner(props) {
  const { data } = useBackend<PreferencesMenuData>();
  const { window } = data;

  const [serverData, setServerData] = useState<ServerData>();
  const randomization = useState(false);

  let content;
  let title;
  switch (window) {
    case PrefsWindow.Character:
      content = <CharacterPreferenceWindow />;
      title = 'Character Preferences';
      break;
    case PrefsWindow.Game:
      content = <GamePreferenceWindow />;
      title = 'Game Preferences';
      break;
    case PrefsWindow.Keybindings:
      content = (
        <GamePreferenceWindow
          startingPage={GamePreferencesSelectedPage.Keybindings}
        />
      );
      title = 'Keybindings';
      break;
    default:
      exhaustiveCheck(window);
  }

  useEffect(() => {
    fetchRetry(resolveAsset('preferences.json'))
      .then((response) => response.json())
      .then((data) => {
        setServerData(data);
      })
      .catch((error) => {
        logger.log('Failed to fetch preferences.json', error);
      });
  }, []);

  return (
    <ServerPrefs.Provider value={serverData}>
      <RandomToggleState.Provider value={randomization}>
        {content}
      </RandomToggleState.Provider>
    </ServerPrefs.Provider>
  );
}
