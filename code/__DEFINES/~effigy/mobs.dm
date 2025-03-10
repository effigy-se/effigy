#define UNDERWEAR_HIDE_SOCKS (1<<0)
#define UNDERWEAR_HIDE_SHIRT (1<<1)
#define UNDERWEAR_HIDE_UNDIES (1<<2)
#define UNDERWEAR_HIDE_BRA (1<<3)
#define UNDERWEAR_HIDE_ALL (UNDERWEAR_HIDE_SOCKS | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_BRA)

#define ORGAN_SLOT_EXTERNAL_FLUFF "fluff"
#define ORGAN_SLOT_EXTERNAL_CHEST "ext_chest"
#define ORGAN_SLOT_EXTERNAL_GROIN_Y1 "ext_groin_y1"
#define ORGAN_SLOT_EXTERNAL_GROIN_Y2 "ext_groin_y2"

// Used to make it easier
#define ORGAN_VISIBILITY_MODE_ALWAYS_SHOW "Always Show"
#define ORGAN_VISIBILITY_MODE_NORMAL "Normal"
#define ORGAN_VISIBILITY_MODE_ALWAYS_HIDE "Always Hide"

/// Head_flags of android heads that don't feature eyes (monitor heads (IPCs))
#define HEAD_MONITOR_FACE (HEAD_HAIR|HEAD_LIPS|HEAD_DEBRAIN)

GLOBAL_LIST_INIT(monitor_displays, list(
	"Disabled" = "none",
	"Blank" = "blank",
	"Blank (White)" = "blankwhite",
	"Blue" = "blue",
	"Blue Screen of Death" = "bsod",
	"Breakout" = "breakout",
	"Cigarette" = "smoking",
	"Console" = "console",
	"Cubic Wave" = "squarewave",
	"Cyclops" = "eye",
	"Database" = "database",
	"ECG Wave" = "ecgwave",
	"Eight" = "eight",
	"Eyes" = "eyes",
	"Goggles" = "goggles",
	"Gol Glider" = "golglider",
	"Green" = "green",
	"Heart" = "heart",
	"Heartrate Monitor" = "heartrate",
	"Luminous Eyes" = "lumi_eyes",
	"Mono Eye" = "mono_eye",
	"Music" = "music",
	"Nature" = "nature",
	"Pink" = "pink",
	"Purple" = "purple",
	"Rainbow" = "rainbow",
	"Red Text" = "redtext",
	"Red" = "red",
	"RGB" = "rgb",
	"Scroll" = "scroll",
	"Shower" = "shower",
	"Sine Wave" = "sinewave",
	"Smiley" = "yellow",
	"Stars" = "stars",
	"Sunburst" = "sunburst",
	"Test Screen" = "test",
	"Text Drop" = "textdrop",
	"TV Static" = "static",
	"TV Static (Color)" = "static3",
	"TV Static (Slow)" = "static2",
	"Waiting..." = "waiting",
	))

GLOBAL_LIST_INIT(monitor_lizard_displays, list(
	"Disabled" = "none",
	"Eyes" = "liz_eyes",
	"Question" = "liz_question",
	"Exclaim" = "liz_exclaim",
	))

/// Slowdowns
#define PULL_OVERSIZED_SLOWDOWN 2
