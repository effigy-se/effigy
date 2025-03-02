// import { Feature, FeatureNumberInput } from '../base'; // EffigyEdit Change
import { Feature, FeatureSliderInput } from '../base';

export const age: Feature<number> = {
  name: 'Age',
  component: FeatureSliderInput, // EffigyEdit Change - Original: FeatureNumberInput
};
