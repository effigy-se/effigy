/mob/living/carbon/human/species/insectoid
	race = /datum/species/insectoid

/datum/species/insectoid
	name = "Insectoid"
	plural_form = "Insectoids"
	id = SPECIES_INSECTOID
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/insectoid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/insectoid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/insectoid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/insectoid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/insectoid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/insectoid,
	)
	digi_leg_overrides = list(
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/animalid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/animalid,
	)

/datum/species/insectoid/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["mcolor"] = "#272727"
	human_for_preview.dna.features["snout"] = "None"
	human_for_preview.dna.ear_type = MAMMAL_TYPE
	human_for_preview.dna.features["ears"] = "None"
	human_for_preview.dna.tail_type = MAMMAL_TYPE
	human_for_preview.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	human_for_preview.set_haircolor("#365745", update = FALSE)
	human_for_preview.set_hairstyle("Ziegler", update = TRUE)
	human_for_preview.eye_color_left = "#f8c67a"
	human_for_preview.eye_color_right = "#f8c67a"
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/insectoid/get_physical_attributes()
	return "Insectoids are primarily distinguished by their organs rather than any universal innate trait; though share \
		more general weaknesses with flypeople."

/datum/species/insectoid/get_species_description()
	return "Insectoids; akin to their more generalized Animalid counterparts - hail from many respects depending on genus; \
	nationality, and history. Some may be former humans, genemodded akin to the more specialized Felinid - some may share \
	no such connection; from some distant system."

/datum/species/insectoid/get_species_lore()
	return list(
		"While there is no unified history that connects the tale of all existant Insectoids; due to the \
			vastly varying methods for contact with human space; if not being part of it - it's yet still \
			easy enough to point fingers to a specific event for their widespread variety and proliferation.",

		"Humanity's first contact with Bluespace in 2026; following Voyager II's mysterious reappearance on Earth, \
			led to rapid development for early studies in relativity; and, ultimately - working teleportation technology.",

		"While other starfaring civilizations had already performed their own studies in the field; the relatively centralized \
			position of the Milky Way galaxy proved a boon for fostering trade, and, ultimately - travel and emigration to \
			a measure prior unheard, which allowed otherwise formerly fringe species to mingle. It is, however, theorized a spike \
			in insectoids coincided with first contact with the Mothic Fleet.",
	)
