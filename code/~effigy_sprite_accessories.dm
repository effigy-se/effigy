/// We can't reuse the builtin SPRITE_ACCESSORY_BLANK as a bunch of code for CI and consistenthumans are reliant on it to force species parts on in screenshot tests & similar.
/// Thus, we need a custom ID for each part, and to maintain consistency we SHOULD be using /part/none::name but CI alt tests don't like that for some reason.
#define SPRITE_ACCESSORY_NO_TAIL "No Tail"
#define SPRITE_ACCESSORY_NO_EARS "No Ears"
#define SPRITE_ACCESSORY_NO_SNOUT "No Snout"
#define SPRITE_ACCESSORY_NO_WINGS "No Wings"

/// Hi!  This file is here to work around some order-of-operations issues consistent humans & a couple other things have.
/// If our overrides aren't loaded in early enough default TG stuff will end up in the critical [1] slot and break things.

/// Wings
/datum/sprite_accessory/wings_anthro/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_WINGS
	icon_state = "none"

/datum/sprite_accessory/moth_wings/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_WINGS
	icon_state = "none"

/datum/sprite_accessory/moth_antennae/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = "No Antennae"
	icon_state = "none"

/// Ears
/datum/sprite_accessory/ears/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = "none"

/datum/sprite_accessory/ears_anthro/lizard/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_anthro/dog/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_anthro/fox/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_anthro/mammal/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_anthro/monkey/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_anthro/fish/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_anthro/flying/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_anthro/humanoid/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_EARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/// Tail time
/datum/sprite_accessory/tails/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = "none"

/datum/sprite_accessory/tails/lizard/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/felinid/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/monkey/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/dog/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/fox/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/mammal/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/flying/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/fish/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/humanoid/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = SPRITE_ACCESSORY_NO_TAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

// TG sprite accessories
/datum/sprite_accessory/snouts/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = SPRITE_ACCESSORY_NO_SNOUT
	icon_state = "none"

/datum/sprite_accessory/lizard_markings/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = "No Markings"
	icon_state = "none"

/datum/sprite_accessory/frills/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = "No Frills"
	icon_state = "none"

/datum/sprite_accessory/horns/none
	icon = 'local/icons/mob/mutant/sprite_accessories/fallback.dmi'
	name = "No Horns"
	icon_state = "none"

// Linter sacrifice.  We only need this in the one file I suppose.
#undef SPRITE_ACCESSORY_NO_TAIL
#undef SPRITE_ACCESSORY_NO_EARS
#undef SPRITE_ACCESSORY_NO_SNOUT
#undef SPRITE_ACCESSORY_NO_WINGS
