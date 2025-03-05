/mob/living/carbon/human/species/vulpkanin
	race = /datum/species/vulpkanin

/datum/species/vulpkanin
	name = "Vulpkanin"
	plural_form = "Vulpkane"
	id = SPECIES_VULP
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
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

/datum/species/vulpkanin/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["lizard_markings"] = "No Markings"
	human_for_preview.dna.features["body_markings_color_1"] = "#ad9c88"
	human_for_preview.dna.features["mcolor"] = "#995a1e"
	human_for_preview.dna.features["snout"] = /datum/sprite_accessory/snouts/mammal_short::name
	human_for_preview.dna.features["snout_color_1"] = "#995a1e"
	human_for_preview.dna.features["snout_color_2"] = "#ad9c88"
	human_for_preview.dna.ear_type = FOX_TYPE
	human_for_preview.dna.features["ears"] = /datum/sprite_accessory/ears_anthro/fox/default::name
	human_for_preview.dna.features["ears_color_1"] = "#995a1e"
	human_for_preview.dna.features["ears_color_2"] = "#ad9c88"
	human_for_preview.dna.tail_type = MAMMAL_TYPE
	human_for_preview.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	human_for_preview.set_haircolor("#904b2b", update = FALSE)
	human_for_preview.set_hairstyle(/datum/sprite_accessory/hair/antenna::name, update = TRUE)
	human_for_preview.eye_color_left = "#8b8d2a"
	human_for_preview.eye_color_right = "#8b8d2a"
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/vulpkanin/get_physical_attributes()
	return "Vulpkane have no special attributes." // Species needs unique traits to themselves

/datum/species/vulpkanin/get_species_description()
	return "The vulpkane are a fox-like humanoid species."

/datum/species/vulpkanin/get_species_lore()
	return list(
		"This species' history has yet to be written.",
	)
