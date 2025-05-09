#define EFFIGY_SAVEFILE_VERSION_LEGACY 3
#define EFFIGY_SAVEFILE_VERSION_CURRENT 4

#define PREVIEW_STYLE_JOB "Preview: Job"
#define PREVIEW_STYLE_LOADOUT "Preview: Loadout"
#define PREVIEW_STYLE_UNDERWEAR "Preview: Underwear"
#define PREVIEW_STYLE_NAKED "Preview: Naked"

#define LOADOUT_OVERRIDE_JOB "Delete job items"
#define LOADOUT_OVERRIDE_BACKPACK "Move job to backpack"
#define LOADOUT_OVERRIDE_CASE "Place all in case"

// NOTE TO FUTURE CODERS: If you increase this to a huge number, please restrict the overall **amount** of items players can take,
// if item count restrictions have been significantly increased. You will end up with massively bloated save sizes otherwise.
#define LOADOUT_MAX_PRESETS 7
#define LOADOUT_MAX_NAME_LENGTH 24

#define READ_PREFS(target, pref) (target.client?.prefs?.read_preference(/datum/preference/pref))

// tgui category
#define PREFERENCE_CATEGORY_AUGMENTS "augments"
#define PREFERENCE_CATEGORY_MARKINGS "markings"
#define PREFERENCE_CATEGORY_PROFILE "profile"

#define MAX_FLAVOUR_TEXT_LENGTH 4096
#define FLAVOUR_TEXT_PREVIEW_LIMIT 128
