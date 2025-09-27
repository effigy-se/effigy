import { CheckboxInput, type FeatureToggle } from '../../base';

export const blooper_send: FeatureToggle = {
  name: 'Toggle Sending Vocal Bloopers',
  category: 'SOUND',
  component: CheckboxInput,
};

export const blooper_hear: FeatureToggle = {
  name: 'Toggle Hearing Vocal Bloopers',
  category: 'SOUND',
  component: CheckboxInput,
};
