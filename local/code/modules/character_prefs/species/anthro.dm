/mob/living/carbon/human/species/anthro
	race = /datum/species/anthro

/datum/species/anthro
	name = "Anthromorph"
	plural_form = "Anthromorphic"
	id = SPECIES_ANTHRO
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_EXPANDED_FOV,
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

/datum/species/anthro/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
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

/datum/species/anthro/get_physical_attributes()
	return "Anthromorphs; though physically distinguished in numerous minuet details - still ultimately \
	conform to a generalized \"average\" akin to other forms of sapient life, with no major \
	outlying traits to distinguish them."

/datum/species/anthro/get_species_description()
	return "Anthromorphs hail from many respects depending on genus; nationality, and history. Some may \
	be former humans, genemodded akin to the more specialized Felinid - some may share no such connection; \
	from some distant system."

/datum/species/anthro/get_species_lore()
	return list(
		"While there is no unified history that connects the tale of all existant anthromorphs; due to the \
			vastly varying methods for contact with human space; if not being part of it - it's yet still \
			easy enough to point fingers to a specific event for their widespread variety and proliferation.",

		"Humanity's first contact with Bluespace in 2026; following Voyager II's mysterious reappearance on Earth, \
			led to rapid development for early studies in relativity; and, ultimately - working teleportation technology.",

		"While other starfaring civilizations had already performed their own studies in the field; the relatively centralized \
			position of the Milky Way galaxy proved a boon for fostering trade, and, ultimately - travel and emigration to \
			a measure prior unheard, which allowed otherwise formerly fringe species to mingle.",
	)
