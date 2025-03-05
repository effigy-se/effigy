/mob/living/carbon/human/species/tajaran
	race = /datum/species/tajaran

/datum/species/tajaran
	name = "Tajaran"
	plural_form = "Tajara"
	id = SPECIES_TAJARAN
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_CATLIKE_GRACE,
		TRAIT_HATED_BY_DOGS,
		TRAIT_WATER_HATER,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/anthro,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/anthro,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/anthro,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/anthro,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/anthro,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/anthro,
	)
	digi_leg_overrides = list(
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/anthro,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/anthro,
	)

/datum/species/tajaran/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["lizard_markings"] = "No Markings"
	human_for_preview.dna.features["body_markings_color_1"] = "#242424"
	human_for_preview.dna.features["mcolor"] = "#303030"
	human_for_preview.dna.features["snout"] = /datum/sprite_accessory/snouts/mammal_short::name
	human_for_preview.dna.features["snout_color_1"] = "#303030"
	human_for_preview.dna.features["snout_color_2"] = "#242424"
	human_for_preview.dna.ear_type = CAT_TYPE
	human_for_preview.dna.features["ears"] = /datum/sprite_accessory/ears/cat::name
	human_for_preview.dna.features["ears_color_1"] = "#303030"
	human_for_preview.dna.features["ears_color_2"] = "#242424"
	human_for_preview.dna.tail_type = CAT_TYPE
	human_for_preview.dna.features["tail_cat"] = /datum/sprite_accessory/tails/felinid/cat/cat_big::name
	human_for_preview.set_haircolor("#cab7a7", update = FALSE)
	human_for_preview.set_hairstyle(/datum/sprite_accessory/hair/modular/bonnie::name, update = TRUE)
	human_for_preview.eye_color_left = "#ffd000"
	human_for_preview.eye_color_right = "#ffd000"
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/tajaran/get_hiss_sound(mob/living/carbon/human/felinid)
	return 'sound/mobs/humanoids/felinid/felinid_hiss.ogg'

/datum/species/tajaran/get_physical_attributes()
	return "Tajara are natural acrobats that are naturally repelled by water." // Species needs more going on imo

/datum/species/tajaran/get_species_description()
	return "The Tajara are a cat-like humanoid species."

/datum/species/tajaran/get_species_lore()
	return list(
		"This species' history has yet to be written.",
	)
