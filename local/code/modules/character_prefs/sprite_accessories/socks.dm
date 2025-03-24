/**
 * Socks
 *
 * Keep these sorted alphabetically and in the SAME ORDER as in the dmi file!
 * Variations stick with their parent object, ie. Emo, Long Emo are a 'group'
 * and should be kept together and sorted as 'Emo'
 */
/datum/sprite_accessory/socks
	//All underwear goes in the same file for the sake of digi variants
	icon = 'local/icons/mob/clothing/underwear.dmi'
	use_static = TRUE

/// GENERAL LEGGINGS ///
/// These aren't actually a code distinction but they were in the .dmi. Additional alphabetically sorted by icon state; not by name

/datum/sprite_accessory/socks/leggings
	name = "Leggings"
	icon_state = "leggings"
	use_static = FALSE

/datum/sprite_accessory/socks/leggings_stirrup
	name = "Stirrup Leggings"
	icon_state = "leggings-stir"
	use_static = FALSE

/datum/sprite_accessory/socks/pantyhose_stirrup
	name = "Stirrup Pantyhose"
	icon_state = "pantyhose-stir"

/datum/sprite_accessory/socks/pantyhose_ripped
	name = "Pantyhose (Ripped)"
	icon_state = "pantyhose_ripped"

/datum/sprite_accessory/socks/pantyhose_stirrup_ripped
	name = "Stirrup Pantyhose (Ripped)"
	icon_state = "pantyhose_ripped-stir"

/datum/sprite_accessory/socks/stockings_ripped
	name = "Stockings (Ripped)"
	icon_state = "stockings_ripped"

/datum/sprite_accessory/socks/thigh_highs_ripped
	name = "Thigh-Highs (Ripped)"
	icon_state = "thigh_high_ripped"

/// SOCKS ///

/datum/sprite_accessory/socks/athletic_thigh
	name = "Thigh-high (Athletic)"
	icon_state = "athletic_thigh"

/datum/sprite_accessory/socks/athletic_stirrup_thigh
	name = "Stirrup Thigh-high (Athletic)"
	icon_state = "athletic_thigh-stir"

/datum/sprite_accessory/socks/bee_knee_legacy
	name = "Knee-high (Bee, Legacy)"
	icon_state = "bee_knee_legacy"

/datum/sprite_accessory/socks/bee_thigh_legacy
	name = "Thigh-high (Bee, Legacy)"
	icon_state = "bee_thigh_legacy"

/datum/sprite_accessory/socks/fishnet_thigh_legacy
	name = "Thigh-high (Fishnet, Legacy)"
	icon_state = "fishnet_thigh_legacy"

/datum/sprite_accessory/socks/fishnet_thigh_greyscale
	name = "Thigh-high (Fishnet, Greyscale)"
	icon_state = "fishnet_greyscale"
	use_static = FALSE

/datum/sprite_accessory/socks/stirrup_thigh_rainbow
	name = "Stirrup Thigh-high (Rainbow)"
	icon_state = "rainbow_thigh-stir"

/datum/sprite_accessory/socks/stirrup_knee_rainbow
	name = "Stirrup Knee-high (Rainbow)"
	icon_state = "rainbow_knee-stir"

/datum/sprite_accessory/socks/knee_stirrup_greyscale
	name = "Stirrup Knee-high (Greyscale)"
	icon_state = "socks_knee-stir"
	use_static = FALSE

/datum/sprite_accessory/socks/knee_greyscale
	name = "Knee-high (Greyscale)"
	icon_state = "socks_knee_m"
	use_static = FALSE

/datum/sprite_accessory/socks/short_stirrup_greyscale
	name = "Stirrup Socks (Greyscale)"
	icon_state = "socks_norm-stir"
	use_static = FALSE

/datum/sprite_accessory/socks/thigh_stirrup_greyscale
	name = "Stirrup Thigh-high (Greyscale)"
	icon_state = "socks_thigh-stir"
	use_static = FALSE

/datum/sprite_accessory/socks/thigh_greyscale
	name = "Thigh-high (Greyscale)"
	icon_state = "socks_thigh-stir"
	use_static = FALSE

/datum/sprite_accessory/socks/thigh_stirrup_striped
	name = "Stirrup Thigh-high (Striped)"
	icon_state = "striped_thigh-stir"
	use_static = FALSE

/// CHRISTMAS //

/datum/sprite_accessory/socks/candycane
	name = "Socks (Candy Cane)"
	icon_state = "candycaner_norm"

/datum/sprite_accessory/socks/knee_candycane
	name = "Knee-high (Candy Cane)"
	icon_state = "candycaner_knee"

/datum/sprite_accessory/socks/thigh_candycane
	name = "Thigh-high (Candy Cane)"
	icon_state = "candycaner_thigh"

/datum/sprite_accessory/socks/candycane_green
	name = "Socks (Green Candy Cane)"
	icon_state = "candycaneg_norm"

/datum/sprite_accessory/socks/knee_candycane_green
	name = "Knee-high (Green Candy Cane)"
	icon_state = "candycaneg_knee"

/datum/sprite_accessory/socks/thigh_candycane_green
	name = "Thigh-high (Green Candy Cane)"
	icon_state = "candycaneg_thigh"

/datum/sprite_accessory/socks/festive
	name = "Socks (Festive)"
	icon_state = "festive_norm"

/datum/sprite_accessory/socks/knee_festive
	name = "Knee-high (Festive)"
	icon_state = "festive_knee"

/datum/sprite_accessory/socks/thigh_festive
	name = "Thigh-high (Festive)"
	icon_state = "festive_thigh"
