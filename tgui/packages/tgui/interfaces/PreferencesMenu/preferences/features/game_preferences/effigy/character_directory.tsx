import { CheckboxInput, FeatureChoiced, FeatureToggle } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const master_erp_pref: FeatureToggle = {
  name: 'Show/Hide ERP Preferences',
  category: 'GAMEPLAY',
  component: CheckboxInput,
};

export const show_in_directory: FeatureToggle = {
  name: 'Visible in Character Directory',
  category: 'DIRECTORY',
  description: 'When enabled, character will be shown in Character Directory.',
  component: CheckboxInput,
};

export const emote_length: FeatureChoiced = {
  name: 'Preferred Emote Length',
  category: 'DIRECTORY',
  description:
    'What length of emote your prefer during an RP scene, if you have one. Shows on your Character Advert.',
  component: FeatureDropdownInput,
};

export const approach_pref: FeatureChoiced = {
  name: 'Preferred Approach Method',
  category: 'DIRECTORY',
  description:
    'How you would like to be approached for RP scenes, if at all. Shows on your Character Advert.',
  component: FeatureDropdownInput,
};

export const furry_pref: FeatureChoiced = {
  name: 'Attraction: Furries?',
  category: 'DIRECTORY',
  description:
    'How, and if, you would like to engage in RP with furry characters, such as Anthromorphs, Birdfolk or Insectoids.',
  component: FeatureDropdownInput,
};

export const scalie_pref: FeatureChoiced = {
  name: 'Attraction: Scalies?',
  category: 'DIRECTORY',
  description:
    'How, and if, you would like to engage in RP with scalie characters, such as Lizards, Fish, or Dragons.',
  component: FeatureDropdownInput,
};

export const other_pref: FeatureChoiced = {
  name: 'Attraction: Others?',
  category: 'DIRECTORY',
  description:
    'How, and if, you would like to engage in RP with outlandish characters, such as Silicons, Taurs, Megafauna and Xenos.',
  component: FeatureDropdownInput,
};

export const demihuman_pref: FeatureChoiced = {
  name: 'Attraction: Demihumans?',
  category: 'DIRECTORY',
  description:
    'How, and if, you would like to engage in RP with demihuman characters, such as cat or dog humans, monsterfolk or demons.',
  component: FeatureDropdownInput,
};

export const human_pref: FeatureChoiced = {
  name: 'Attraction: Humans?',
  category: 'DIRECTORY',
  description:
    'How, and if, you would like to engage in RP wih human characters. You know what a human is.',
  component: FeatureDropdownInput,
};
