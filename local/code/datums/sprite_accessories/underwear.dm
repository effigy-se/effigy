/**
 * Underwear
 *
 * TODO: This comment currently not applicable, these still need to be sorted.
 *
 * Keep these sorted alphabetically and in the SAME ORDER as in the dmi file!
 * Variations stick with their parent object, ie. Emo, Long Emo are a 'group'
 * and should be kept together and sorted as 'Emo'
 */
/datum/sprite_accessory/clothing/underwear
	icon = 'local/icons/mob/clothing/underwear.dmi'
	/// Whether the underwear uses a special sprite for digitigrade style (i.e. briefs, not panties). Adds a "_d" suffix to the icon state
	var/has_digitigrade = FALSE
	/// Whether this underwear includes a top (Because gender = FEMALE doesn't actually apply here.). Hides breasts, nothing more.
	var/hides_breasts = FALSE

/datum/sprite_accessory/clothing/underwear/make_appearance(color, physique, bodyshape)
	var/underwear_icon_state = icon_state
	var/female_sprite_flags = FEMALE_UNIFORM_FULL
	if(has_digitigrade && (bodyshape & BODYSHAPE_DIGITIGRADE))
		underwear_icon_state += "_d"
		female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY // for digi gender shaping
	var/mutable_appearance/underwear_overlay
	if(physique == FEMALE && gender == MALE)
		underwear_overlay = mutable_appearance(wear_female_version(underwear_icon_state, icon, icon, female_sprite_flags), layer = -EFFIGY_UNDERWEAR_SHIRT_LAYER)
	else
		underwear_overlay = mutable_appearance(icon, underwear_icon_state, -EFFIGY_UNDERWEAR_SHIRT_LAYER)
	underwear_overlay.color = use_static ? null : color
	return underwear_overlay

// Adding has_digitigrade to TG stuff
/datum/sprite_accessory/clothing/underwear/male_briefs
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_boxers
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_stripe
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_midway
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_longjohns
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_hearts
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_commie
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_usastripe
	has_digitigrade = TRUE

/datum/sprite_accessory/clothing/underwear/male_uk
	has_digitigrade = TRUE

// Modular Underwear past here

// Briefs
/datum/sprite_accessory/clothing/underwear/male_bee
	name = "Boxers Bee"
	icon_state = "bee_shorts"
	has_digitigrade = TRUE
	gender = MALE
	use_static = TRUE

/datum/sprite_accessory/clothing/underwear/boyshorts
	name = "Boyshorts"
	icon_state = "boyshorts"
	has_digitigrade = TRUE
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/boyshorts_alt
	name = "Boyshorts Alt"
	icon_state = "boyshorts_alt"
	gender = FEMALE

//Panties
/datum/sprite_accessory/clothing/underwear/panties_basic
	name = "Panties"
	icon_state = "panties"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/panties_slim
	name = "Slim"
	icon_state = "panties_slim"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/panties_thin
	name = "Thin"
	icon_state = "panties_thin"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/thong
	name = "Thong"
	icon_state = "thong"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/thong_babydoll
	name = "Thong Alt"
	icon_state = "thong_babydoll"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/panties_swimsuit
	name = "Swimsuit"
	icon_state = "panties_swimming"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/panties_neko
	name = "Neko"
	icon_state = "panties_neko"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/striped_panties
	name = "Striped"
	icon_state = "striped_panties"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/loincloth
	name = "Loincloth"
	icon_state = "loincloth"

/datum/sprite_accessory/clothing/underwear/loincloth_alt
	name = "Shorter Loincloth"
	icon_state = "loincloth_alt"

//Presets
/datum/sprite_accessory/clothing/underwear/lizared
	name = "LIZARED"
	icon_state = "lizared"
	use_static = TRUE

/datum/sprite_accessory/clothing/underwear/female_kinky
	name = "Lingerie"
	icon_state = "panties_kinky"
	gender = FEMALE

/datum/sprite_accessory/clothing/underwear/female_commie
	name = "Commie"
	icon_state = "panties_commie"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/clothing/underwear/female_usastripe
	name = "Freedom"
	icon_state = "panties_assblastusa"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/clothing/underwear/panties_uk
	name = "UK"
	icon_state = "panties_uk"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/clothing/underwear/female_beekini
	name = "Bee-kini"
	icon_state = "panties_bee-kini"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/clothing/underwear/cow
	name = "Cow"
	icon_state = "panties_cow"
	gender = FEMALE
	use_static = TRUE

// Full-Body Underwear, i.e. swimsuits (Including re-enabling 3 from TG)
// These likely require hides_breasts = TRUE
/datum/sprite_accessory/clothing/underwear/swimsuit_onepiece // TG
	name = "One-Piece Swimsuit"
	icon_state = "swim_onepiece"
	gender = FEMALE
	hides_breasts = TRUE

/datum/sprite_accessory/clothing/underwear/swimsuit_strapless_onepiece // TG
	name = "Strapless One-Piece Swimsuit"
	icon_state = "swim_strapless_onepiece"
	gender = FEMALE
	hides_breasts = TRUE

/datum/sprite_accessory/clothing/underwear/swimsuit_stripe // TG
	name = "Strapless Striped Swimsuit"
	icon_state = "swim_stripe"
	gender = FEMALE
	hides_breasts = TRUE

/datum/sprite_accessory/clothing/underwear/swimsuit_red
	name = "One-Piece Swimsuit Red"
	icon_state = "swimming_red"
	gender = FEMALE
	use_static = TRUE
	hides_breasts = TRUE

/datum/sprite_accessory/clothing/underwear/swimsuit
	name = "One-Piece Swimsuit Black"
	icon_state = "swimming_black"
	gender = FEMALE
	use_static = TRUE
	hides_breasts = TRUE

// Fishnets
/datum/sprite_accessory/clothing/underwear/fishnet_lower
	name = "Fishnet"
	icon_state = "fishnet_lower"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/clothing/underwear/fishnet_lower/alt
	name = "Fishnet Alt"
	icon_state = "fishnet_lower_alt"
