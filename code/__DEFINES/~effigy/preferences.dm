#define EFFIGY_SAVEFILE_VERSION_LEGACY 3
#define EFFIGY_SAVEFILE_VERSION_CURRENT 4

#define PREVIEW_PREF_JOB "Job"
#define PREVIEW_PREF_LOADOUT "Loadout"
#define PREVIEW_PREF_UNDERWEAR "Underwear"
#define PREVIEW_PREF_NAKED "Naked"

#define READ_PREFS(target, pref) (target.client?.prefs?.read_preference(/datum/preference/pref))

// tgui category
#define PREFERENCE_CATEGORY_AUGMENTS "augments"
#define PREFERENCE_CATEGORY_MARKINGS "markings"
#define PREFERENCE_CATEGORY_PROFILE "profile"

#define MAX_FLAVOR_TEXT_LENGTH 4096
