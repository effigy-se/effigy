/mob/living/carbon/human/species/slugcat
	race = /datum/species/slugcat

/datum/species/slugcat
	name = "Slugcat Morph"
	plural_form = "Slugcats"
	id = SPECIES_SLUGCAT
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_CATLIKE_GRACE,
		TRAIT_HATED_BY_DOGS,
		TRAIT_WET_FOR_LONGER,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/slugcat,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/slugcat,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/slugcat,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/slugcat,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/slugcat,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/slugcat,
	)
	digi_leg_overrides = list(
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/slugcat,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/slugcat,
	)

/datum/species/slugcat/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["lizard_markings"] = "No Markings"
	human_for_preview.dna.features["body_markings_color_1"] = "#ddddec"
	human_for_preview.dna.features["mcolor"] = "#a3a3a3"
	human_for_preview.dna.features["snout"] = /datum/sprite_accessory/snouts/mammal_short::name
	human_for_preview.dna.features["snout_color_1"] = "#a3a3a3"
	human_for_preview.dna.features["snout_color_2"] = "#ddddec"
	human_for_preview.dna.ear_type = CAT_TYPE
	human_for_preview.dna.features["ears"] = /datum/sprite_accessory/ears/cat::name
	human_for_preview.dna.features["ears_color_1"] = "#a3a3a3"
	human_for_preview.dna.features["ears_color_2"] = "#ddddec"
	human_for_preview.dna.tail_type = MAMMAL_TYPE
	human_for_preview.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	human_for_preview.set_haircolor("#4e4257", update = FALSE)
	human_for_preview.set_hairstyle(/datum/sprite_accessory/hair/modular/bedhead_long::name, update = TRUE)
	human_for_preview.eye_color_left = "#ffffff"
	human_for_preview.eye_color_right = "#ffffff"
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/slugcat/get_physical_attributes()
	return "Slugcats are naturally moist and retain extinguisher sprays and other sources of \"wetness\" \
		for longer." // Species needs more going on imo

/datum/species/slugcat/get_species_description()
	return "Slugcats are a slimy cat-like humanoid species."

/datum/species/slugcat/get_species_lore()
	return list(
		"This species' history has yet to be written.",
	)
