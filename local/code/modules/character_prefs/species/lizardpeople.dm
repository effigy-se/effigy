/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard)
	lizard.dna.features[FEATURE_MUTANT_COLOR] = "#099"
	lizard.dna.tail_type = LIZARD_TYPE
	lizard.dna.features[FEATURE_TAIL_LIZARD] = "Light Tiger"
	lizard.dna.features[FEATURE_SNOUT] = "Sharp + Light"
	lizard.dna.features[FEATURE_HORNS] = "Simple"
	lizard.dna.features[FEATURE_FRILLS] = "Aquatic"
	lizard.dna.features[FEATURE_LEGS] = "Normal Legs"
	lizard.dna.features[FEATURE_FLUFF] = "None"
	lizard.dna.features[FEATURE_LIZARD_MARKINGS] = "None"
	lizard.dna.features["snout_color_1"] = "#099"
	lizard.dna.features["snout_color_2"] = "#099"
	lizard.dna.features["tail_color_1"] = "#099"
	lizard.dna.features["horns_color_1"] = "#066"
	lizard.dna.features["frills_color_1"] = "#099"
	lizard.dna.features["frills_color_2"] = "#066"
	regenerate_organs(lizard)
	lizard.update_body(is_creating = TRUE)
