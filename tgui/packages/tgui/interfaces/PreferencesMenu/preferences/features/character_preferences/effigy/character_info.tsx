import {
  Feature,
  FeatureShortTextInput,
  FeatureTextAreaInput,
} from '../../base';
import { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const flavour_text: Feature<string> = {
  name: 'Flavor Text',
  description: 'Describe your character!',
  component: FeatureTextAreaInput,
};

export const silicon_flavour_text: Feature<string> = {
  name: 'Flavor Text (Silicon)',
  description: 'Describe your cyborg/AI shell!',
  component: FeatureTextAreaInput,
};

export const ooc_notes: Feature<string> = {
  name: 'OOC Notes',
  description: 'Talk about your character OOCly!',
  component: FeatureTextAreaInput,
};

export const ooc_notes_silicon: Feature<string> = {
  name: 'OOC Notes (Silicon)',
  description: 'Same as OOC notes, but for your silicon character!',
  component: FeatureTextAreaInput,
};

export const custom_species: Feature<string> = {
  name: 'Custom Species',
  description:
    "Want to have a fancy species name? Put it here, or leave it blank if you want to use your species' default name.",
  component: FeatureShortTextInput,
};

export const custom_species_silicon: Feature<string> = {
  name: 'Silicon Model',
  description:
    'The name of the module for your Silicon company, such as "NTHI-E1 Construct"',
  component: FeatureShortTextInput,
};

export const custom_species_lore: Feature<string> = {
  name: 'Custom Species Lore',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: FeatureTextAreaInput,
};

export const custom_species_lore_silicon: Feature<string> = {
  name: 'Silicon Model Lore',
  description:
    'Lore for your silicon, typically its company, make, model, and details regarding its creation.',
  component: FeatureTextAreaInput,
};

export const exploitable_info: Feature<string> = {
  name: 'Records - Exploitable',
  description:
    "This section is for information antagonists can use, IN CHARACTER AND OUT. If you are willing to be disrupted by antagonists MORE than the average player (this is usually a very fun experience, if you're into that kind of roleplay), put it here! Also for things antagonists can use against your character.",
  component: FeatureTextAreaInput,
};

export const pda_ringer: Feature<string> = {
  name: 'PDA Ringer Message',
  description:
    'Want your PDA to say something other than "beep"? Accepts the first 20 characters.',
  component: FeatureShortTextInput,
};

export const pda_writing: Feature<string> = {
  name: 'Default Notepad Text',
  description:
    "What's written down on your character's PDA. This can be anything they'll have written down for later - from shopping lists all the way to saucy fanfiction. Anyone with your PDA can read these with the notepad app, so keep it close!",
  component: FeatureTextAreaInput,
};

export const headshot: Feature<string> = {
  name: 'Headshot',
  description:
    'Add an image to your character, visible on close examination. Requires it be formatted properly. \
    Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
    Renders the image underneath your character preview in the examine more window. \
    Image larger than 250x250 will be resized to 250x250. \
    Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const headshot_silicon: Feature<string> = {
  name: 'Headshot (Silicon)',
  description:
    'Requires a link ending with .png, .jpeg, or .jpg, starting with \
  https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
  Renders the image underneath your character preview in the examine more window. \
  Image larger than 250x250 will be resized to 250x250. \
  Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const profile_planet: FeatureChoiced = {
  name: 'Origin Planet',
  component: FeatureDropdownInput,
};

export const profile_residence: FeatureChoiced = {
  name: 'Current Residence',
  component: FeatureDropdownInput,
};

export const profile_nationality: FeatureChoiced = {
  name: 'Current Residence',
  component: FeatureDropdownInput,
};

export const profile_education: FeatureChoiced = {
  name: 'Current Residence',
  component: FeatureDropdownInput,
};

export const profile_employment_history: FeatureChoiced = {
  name: 'Current Residence',
  component: FeatureDropdownInput,
};

export const profile_religion: FeatureChoiced = {
  name: 'Current Residence',
  component: FeatureDropdownInput,
};

export const profile_accomplishments: Feature<string> = {
  name: 'Accomplishments',
  description:
    'Your general records! These are records that are for general viewing-things like employment, qualifications, etc. By default, anyone with a HUD/records access can view these.',
  component: FeatureTextAreaInput,
};

export const profile_security: Feature<string> = {
  name: 'Security Record',
  description:
    'Your security records! These are records for criminal records, arrest history, things like that. Security officers can view these.',
  component: FeatureTextAreaInput,
};

export const profile_medical: Feature<string> = {
  name: 'Medical Record',
  description:
    'Your medical records! These are records for things like medical history, prescriptions, DNR orders, etc. Medical staff can view these.',
  component: FeatureTextAreaInput,
};
