/mob/living/carbon/human/species/animalid
	race = /datum/species/animalid

/datum/species/animalid
	name = "Animalid"
	plural_form = "Animalids"
	id = SPECIES_ANIMALID
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/animalid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/animalid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/animalid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/animalid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/animalid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/animalid,
	)
	digi_leg_overrides = list(
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/animalid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/animalid,
	)

/datum/species/animalid/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["mcolor"] = "#776155"
	human_for_preview.dna.features["snout"] = "Round"
	human_for_preview.dna.features["snout_color_2"] = "#ffffff"
	human_for_preview.dna.features["snout_color_3"] = "#776155"
	human_for_preview.dna.ear_type = CAT_TYPE
	human_for_preview.dna.features["ears"] = "Big"
	human_for_preview.dna.features["ears_color_1"] = "#776155"
	human_for_preview.dna.features["ears_color_2"] = "#ffffff"
	human_for_preview.dna.tail_type = MAMMAL_TYPE
	human_for_preview.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	human_for_preview.set_haircolor("#574036", update = FALSE)
	human_for_preview.set_hairstyle("Emo Long", update = TRUE)
	human_for_preview.eye_color_left = "#C4F87A"
	human_for_preview.eye_color_right = "#C4F87A"
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/animalid/get_physical_attributes()
	return "Animalids are primarily distinguished by their organs rather than any universal innate trait."

/datum/species/animalid/get_species_description()
	return "Animalids hail from many respects depending on genus; nationality, and history. Some may \
	be former humans, genemodded akin to the more specialized Felinid - some may share no such connection; \
	from some distant system."

/datum/species/animalid/get_species_lore()
	return list(
		"While there is no unified history that connects the tale of all existant animalids; due to the \
			vastly varying methods for contact with human space; if not being part of it - it's yet still \
			easy enough to point fingers to a specific event for their widespread variety and proliferation.",

		"Humanity's first contact with Bluespace in 2026; following Voyager II's mysterious reappearance on Earth, \
			led to rapid development for early studies in relativity; and, ultimately - working teleportation technology.",

		"While other starfaring civilizations had already performed their own studies in the field; the relatively centralized \
			position of the Milky Way galaxy proved a boon for fostering trade, and, ultimately - travel and emigration to \
			a measure prior unheard, which allowed otherwise formerly fringe species to mingle.",
	)
