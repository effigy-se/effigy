import { CheckboxInput, type FeatureToggle } from '../../base';

export const autopunctuation: FeatureToggle = {
  name: 'Enable Auto-punctuation',
  category: 'CHAT',
  description: 'Adds punctuation to the end of your messages.',
  component: CheckboxInput,
};
