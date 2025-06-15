#define DNA_BODY_SIZE_DEFAULT 1
#define DNA_BODY_UNIT 100
#define DNA_BODY_UNIT_DEFAULT 100
#define DNA_BODY_UNIT_MAX 150
#define DNA_BODY_UNIT_MIN 80

#define DNA_FEATURE_LIST list(\
	"mcolor" = COLOR_WHITE,\
	"body_size" = DNA_BODY_SIZE_DEFAULT,\
)
// Defines for processing reagents, ie: Synths
#define PROCESS_ORGANIC (1<<0)
#define PROCESS_SYNTHETIC (1<<1)

#define REAGENT_ORGANIC (1<<0)
#define REAGENT_SYNTHETIC (1<<1)

DEFINE_BITFIELD(reagent_flags, list(
	"PROCESS_ORGANIC" = PROCESS_ORGANIC,
	"PROCESS_SYNTHETIC" = PROCESS_SYNTHETIC,
))

///From an organ
#define MUTATION_SOURCE_ORGAN "organ"
