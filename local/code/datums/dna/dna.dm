/datum/dna/initialize_dna(newblood_type, create_mutation_blocks = TRUE, randomize_features = TRUE)
	. = ..()
	/// Weirdness Check Zone
	if(randomize_features)
		if(species.id != /datum/species/human/felinid::id)
			features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			features[FEATURE_EARS_CAT] = /datum/sprite_accessory/blank::name
		if(species.id != /datum/species/monkey::id)
			features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
	update_dna_identity()
