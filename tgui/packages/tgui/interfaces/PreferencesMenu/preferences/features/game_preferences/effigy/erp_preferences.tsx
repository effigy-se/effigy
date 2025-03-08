import { CheckboxInput, FeatureToggle } from '../../base';

export const erpitem_pref: FeatureToggle = {
  name: 'ERP Item Interaction',
  category: 'ERP',
  description:
    'Toggles whether or not all ERP items can be used, worn, or otherwise apply to you.',
  component: CheckboxInput,
};
