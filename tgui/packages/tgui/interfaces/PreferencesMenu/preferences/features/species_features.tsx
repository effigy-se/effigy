import {
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureColorInput,
  FeatureValueProps,
} from './base';
import { FeatureDropdownInput } from './dropdowns';

export const eye_color: Feature<string> = {
  name: 'Eye Colour', // EffigyEdit Change - TGUI
  component: FeatureColorInput,
};

export const facial_hair_color: Feature<string> = {
  name: 'Facial hair color',
  component: FeatureColorInput,
};

export const facial_hair_gradient: FeatureChoiced = {
  name: 'Hair Effect (Facial)', // EffigyEdit Change - TGUI
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const facial_hair_gradient_color: Feature<string> = {
  name: 'Facial Hair Effect Colour', // EffigyEdit Change - TGUI
  component: FeatureColorInput,
};

export const hair_color: Feature<string> = {
  name: 'Hair Colour', // EffigyEdit Change - TGUI
  component: FeatureColorInput,
};

export const hair_gradient: FeatureChoiced = {
  name: 'Hair Effect', // EffigyEdit Change - TGUI
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const hair_gradient_color: Feature<string> = {
  name: 'Hair Effect Colour', // EffigyEdit Change - TGUI
  component: FeatureColorInput,
};

export const feature_human_ears: FeatureChoiced = {
  name: 'Ears',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_human_tail: FeatureChoiced = {
  name: 'Tail',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_monkey_tail: FeatureChoiced = {
  name: 'Tail',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_legs: FeatureChoiced = {
  name: '+ Legs',
  description: `
    Choose leg type for your character.
  `,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_spines: FeatureChoiced = {
  name: 'Spines',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_tail: FeatureChoiced = {
  name: 'Tail',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_mcolor: Feature<string> = {
  name: 'Body Colour', // EffigyEdit Change - TGUI
  component: FeatureColorInput,
};

export const underwear_color: Feature<string> = {
  name: 'Underwear Colour', // EffigyEdit Change - TGUI
  component: FeatureColorInput,
};

// EffigyEdit Add - Character Preferences
export const bra_color: Feature<string> = {
  name: 'Bra Colour',
  component: FeatureColorInput,
};

export const undershirt_color: Feature<string> = {
  name: 'Undershirt Colour',
  component: FeatureColorInput,
};

export const socks_color: Feature<string> = {
  name: 'Socks Colour',
  component: FeatureColorInput,
};
// EffigyEdit Add End

export const feature_vampire_status: Feature<string> = {
  name: 'Vampire status',
  component: FeatureDropdownInput,
};

export const heterochromatic: Feature<string> = {
  name: 'Heterochromatic (Right Eye) color',
  component: FeatureColorInput,
};
