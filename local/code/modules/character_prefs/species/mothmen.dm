/datum/species/moth/prepare_human_for_preview(mob/living/carbon/human/moth)
	moth.dna.features[FEATURE_MOTH_ANTENNAE] = "Firewatch"
	moth.dna.features[FEATURE_MOTH_MARKINGS] = "None"
	moth.dna.features[FEATURE_MOTH_WINGS] = "Firewatch"
	moth.dna.wing_type = "Moth Wings"
	moth.dna.features[FEATURE_FLUFF] = "None"
	moth.dna.features[FEATURE_SNOUT] = "None"
	regenerate_organs(moth)
	moth.update_body(is_creating = TRUE)
