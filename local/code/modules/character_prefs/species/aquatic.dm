/mob/living/carbon/human/species/aquatic
	race = /datum/species/aquatic

/datum/species/aquatic
	name = "Aquatic"
	plural_form = "Aquatic"
	id = SPECIES_AQUATIC
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_SLIPPERY_WHEN_WET,
		TRAIT_WATER_BREATHING,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_cookie = /obj/item/stack/cable_coil
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

/datum/species/aquatic/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["lizard_markings"] = "No Markings"
	human_for_preview.dna.features["body_markings_color_1"] = "#ddddec"
	human_for_preview.dna.features["mcolor"] = "#3a4552"
	human_for_preview.dna.features["snout"] = "Akula"
	human_for_preview.dna.features["snout_color_1"] = "#3a4552"
	human_for_preview.dna.features["snout_color_2"] = "#ddddec"
	human_for_preview.dna.ear_type = MAMMAL_TYPE
	human_for_preview.dna.features["ears"] = "Sergal"
	human_for_preview.dna.features["ears_color_1"] = "#3a4552"
	human_for_preview.dna.features["ears_color_2"] = "#ddddec"
	human_for_preview.dna.tail_type = MAMMAL_TYPE
	human_for_preview.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	human_for_preview.dna.features["horns"] = "Ram"
	human_for_preview.dna.features["horns_color_1"] = "#3a4552"
	human_for_preview.dna.features["horns_color_2"] = "#3a4552"
	human_for_preview.set_haircolor("#2b6690", update = FALSE)
	human_for_preview.set_hairstyle("Ponytail (Side) 3", update = TRUE)
	human_for_preview.eye_color_left = "#2a6418"
	human_for_preview.eye_color_right = "#2a6418"
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/aquatic/get_physical_attributes()
	return "Aquatics have their fishy nature to thank for their waterbreathing and ability to slip \
		others while wet. They are additionally able to snip wires - with their teeth - on fridays only. The \
		usual insulation restrictions still apply."

/datum/species/aquatic/get_species_description()
	return "Just like the anthromorph, aquatic history is frayed, split down from multiple origins and, now, mingling \
	only relatively recently. Some may have been human gene-modders getting in on the \"animalid\" craze - others can \
	trace history to their own relatively fringe systems."

/datum/species/aquatic/get_species_lore()
	return list(
		"While there is no unified history that connects the tale of all existant aquatics; due to the \
			vastly varying methods for contact with human space; if not being part of it - it's yet still \
			easy enough to point fingers to a specific event for their widespread variety and proliferation.",

		"Humanity's first contact with Bluespace in 2026; following Voyager II's mysterious reappearance on Earth, \
			led to rapid development for early studies in relativity; and, ultimately - working teleportation technology.",

		"While other starfaring civilizations had already performed their own studies in the field; the relatively centralized \
			position of the Milky Way galaxy proved a boon for fostering trade, and, ultimately - travel and emigration to \
			a measure prior unheard, which allowed otherwise formerly fringe species to mingle.",
	)

/datum/species/aquatic/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_WATER,
			SPECIES_PERK_NAME = "Water Breathing",
			SPECIES_PERK_DESC = "Gills or not - you have the innate ability to \
				breathe while submerged in water - or any other liquid!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
			SPECIES_PERK_NAME = "Slippery When Wet",
			SPECIES_PERK_DESC = "Your fishy nature attracts comical hijinx. \
			As a direct result; when doused in water you're super slippery!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_BOLT,
			SPECIES_PERK_NAME = "Fibre Optic Friday",
			SPECIES_PERK_DESC = "One day a week, these majestic, toothy creatures can gnaw \
			through the station’s critical infrastructure. Mind the shock!",
		)
	)

	return to_add
