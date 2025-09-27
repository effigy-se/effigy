import { CheckboxInput, type FeatureToggle } from '../../base';

export const blooper_send: FeatureToggle = {
  name: 'Enable sending vocal bloopers',
  category: 'SOUND',
  component: CheckboxInput,
};

export const blooper_hear: FeatureToggle = {
  name: 'Enable hearing vocal bloopers',
  category: 'SOUND',
  component: CheckboxInput,
};
