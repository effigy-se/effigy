///Does this airlock emit static environmental lighting?
#define ENV_LIGHTS (1<<0)
///Use legacy airlock animation timings
#define LEGACY_ANIMATIONS (1<<1)
///Does this door have access checks?
#define ACCESS_RESTRICTED (1<<2)

#define DOOR_OPENING_RAPID_ANIMATION "opening_rapid"

DEFINE_BITFIELD(airlock_features, list(
	"ENV_LIGHTS" = ENV_LIGHTS,
	"LEGACY_ANIMATIONS" = LEGACY_ANIMATIONS,
	"ACCESS_RESTRICTED" = ACCESS_RESTRICTED,
))
