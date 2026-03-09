/datum/dna
	///	This variable is read by the regenerate_organs() proc to know what organ subtype to give
	var/tail_type = NO_VARIATION

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE, replace_missing = TRUE)
	. = ..()
	if((type in GLOB.bodypart_allowed_species[FEATURE_TAIL]) && target.dna.tail_type != NO_VARIATION)
		var/obj/item/organ/tail/tail_type = GLOB.tail_variations[target.dna.tail_type]
		var/feature_key = tail_type::bodypart_overlay::feature_key
		if(target.dna.features[feature_key] != /datum/sprite_accessory/blank::name)
			var/obj/item/organ/replacement = SSwardrobe.provide_type(tail_type)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	else
		var/obj/item/organ/tail/old_part = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(istype(old_part))
			old_part.Remove(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
			old_part.moveToNullspace()

/// Tail variation
/datum/preference/choiced/tail_variation
	savefile_key = "tail_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_DEFAULT

/datum/preference/choiced/tail_variation/apply_to_human(mob/living/carbon/human/target, chosen_variation)
	// NIGHTMARE NIGHTMARE
	target.dna.tail_type = chosen_variation
	switch(chosen_variation)
		if(NO_VARIATION)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(AQUATIC_TYPE)
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(CAT_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(DOG_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(FLYING_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(FOX_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(HUMANOID_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(LIZARD_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(MONKEY_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MAMMAL] = /datum/sprite_accessory/blank::name
		if(MAMMAL_TYPE)
			target.dna.features[FEATURE_TAIL_FISH] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_CAT] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_DOG] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FLYING] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_FOX] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_HUMANOID] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_LIZARD] = /datum/sprite_accessory/blank::name
			target.dna.features[FEATURE_TAIL_MONKEY] = /datum/sprite_accessory/blank::name

/datum/preference/choiced/tail_variation/create_default_value()
	return NO_VARIATION

/datum/preference/choiced/tail_variation/init_possible_values()
	return list(NO_VARIATION) + (GLOB.mutant_variations)

/datum/preference/choiced/tail_variation/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	return TRUE

///	Lizard tail type
/datum/preference/choiced/species_feature/lizard_tail // override from TG default
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_LIZARD

/datum/preference/choiced/species_feature/lizard_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/lizard_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/lizard_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/lizard_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == LIZARD_TYPE)
		return TRUE
	return FALSE

///	Cat tail type
/datum/preference/choiced/species_feature/tail_felinid
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_CAT

/datum/preference/choiced/species_feature/tail_felinid/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/tail_felinid/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/tail_felinid/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/tail_felinid/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE
	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == CAT_TYPE)
		return TRUE
	return FALSE

///	Dog tail type
/datum/preference/choiced/species_feature/dog_tail
	savefile_key = "feature_dog_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_DOG
	priority = PREFERENCE_PRIORITY_PRE_SPECIES

/datum/preference/choiced/species_feature/dog_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/dog_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/dog_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/dog_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == DOG_TYPE)
		return TRUE

	return FALSE

///	Fox tail type
/datum/preference/choiced/species_feature/fox_tail
	savefile_key = "feature_fox_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_FOX
	priority = PREFERENCE_PRIORITY_PRE_SPECIES

/datum/preference/choiced/species_feature/fox_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/fox_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/fox_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/fox_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == FOX_TYPE)
		return TRUE

	return FALSE

///	Mammal tail type
/datum/preference/choiced/species_feature/mammal_tail
	savefile_key = "feature_mammal_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_MAMMAL
	priority = PREFERENCE_PRIORITY_PRE_SPECIES

/datum/preference/choiced/species_feature/mammal_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/mammal_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/mammal_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/mammal_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == MAMMAL_TYPE)
		return TRUE

	return FALSE

///	Flying tail type
/datum/preference/choiced/species_feature/flying_tail
	savefile_key = "feature_flying_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_FLYING
	priority = PREFERENCE_PRIORITY_PRE_SPECIES

/datum/preference/choiced/species_feature/flying_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/flying_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/flying_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/flying_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == FLYING_TYPE)
		return TRUE

	return FALSE

///	Monkey tail type
/datum/preference/choiced/species_feature/monkey_tail
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_MONKEY

/datum/preference/choiced/species_feature/monkey_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/monkey_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/monkey_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/monkey_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == MONKEY_TYPE)
		return TRUE

	return FALSE

///	Aquatic tail type
/datum/preference/choiced/species_feature/fish_tail
	savefile_key = "feature_fish_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_FISH

/datum/preference/choiced/species_feature/fish_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/fish_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/fish_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/fish_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == AQUATIC_TYPE)
		return TRUE

	return FALSE

/* There's no sprites for this
///	Synth tail type
/datum/preference/choiced/species_feature/synth_tail
	savefile_key = "feature_synth_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = "tail_synthetic"
	priority = PREFERENCE_PRIORITY_PRE_SPECIES

/datum/preference/choiced/species_feature/synth_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/synth_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/synth_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/synth_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == CYBERNETIC_TYPE)
		return TRUE

	return FALSE
*/

///	Humanoid tail type
/datum/preference/choiced/species_feature/humanoid_tail
	savefile_key = "feature_humanoid_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE
	main_feature_name = "Tail"
	feature_key = FEATURE_TAIL_HUMANOID
	priority = PREFERENCE_PRIORITY_PRE_SPECIES

/datum/preference/choiced/species_feature/humanoid_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/species_feature/humanoid_tail/create_default_value()
	return /datum/sprite_accessory/blank::name

/datum/preference/choiced/species_feature/humanoid_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = get_accessory_for_value(value)
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/species_feature/humanoid_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FEATURE_TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == HUMANOID_TYPE)
		return TRUE
	return FALSE

/// Generate selection preview
/datum/preference/choiced/proc/generate_back_icon(chosen_tail, key)
	var/datum/sprite_accessory/sprite_accessory = chosen_tail
	var/datum/universal_icon/final_icon = uni_icon('local/icons/mob/mutant/sprite_accessories/fallback.dmi', null)

	if (LOWER_TEXT(sprite_accessory.icon_state) != "none")
		var/list/sprite_accessory_layers = SSaccessories.get_sprite_accessory_layers("[sprite_accessory.icon]")
		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_BEHIND"))
			var/datum/universal_icon/markings_icon_1 = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_BEHIND", NORTH)
			markings_icon_1.blend_color(COLOR_EFFIGY_SKY_BLUE, ICON_MULTIPLY)
			if(markings_icon_1.icon_file == EFFIGY_WINGS_ICON_FILE)
				markings_icon_1.crop(8, 2, 39, 33)
			else if(markings_icon_1.icon_file == EFFIGY_BIG_TAILS_ICON_FILE)
				markings_icon_1.crop(17, 1, 48, 32)
			final_icon.blend_icon(markings_icon_1, ICON_OVERLAY)

		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_BEHIND_2"))
			var/datum/universal_icon/markings_icon_2 = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_BEHIND_2", NORTH)
			markings_icon_2.blend_color(COLOR_EFFIGY_PLATINUM, ICON_MULTIPLY)
			if(markings_icon_2.icon_file == EFFIGY_WINGS_ICON_FILE)
				markings_icon_2.crop(8, 2, 39, 33)
			else if(markings_icon_2.icon_file == EFFIGY_BIG_TAILS_ICON_FILE)
				markings_icon_2.crop(17, 1, 48, 32)
			final_icon.blend_icon(markings_icon_2, ICON_OVERLAY)

		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_BEHIND_3"))
			var/datum/universal_icon/markings_icon_3 = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_BEHIND_3", NORTH)
			markings_icon_3.blend_color(COLOR_EFFIGY_ELECTRIC_BLUE, ICON_MULTIPLY)
			if(markings_icon_3.icon_file == EFFIGY_WINGS_ICON_FILE)
				markings_icon_3.crop(8, 2, 39, 33)
			else if(markings_icon_3.icon_file == EFFIGY_BIG_TAILS_ICON_FILE)
				markings_icon_3.crop(17, 1, 48, 32)
			final_icon.blend_icon(markings_icon_3, ICON_OVERLAY)

		/// == front breaker ==
		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_FRONT"))
			var/datum/universal_icon/markings_icon_1_f = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_FRONT", NORTH)
			markings_icon_1_f.blend_color(COLOR_EFFIGY_SKY_BLUE, ICON_MULTIPLY)
			if(markings_icon_1_f.icon_file == EFFIGY_WINGS_ICON_FILE)
				markings_icon_1_f.crop(8, 2, 39, 33)
			else if(markings_icon_1_f.icon_file == EFFIGY_BIG_TAILS_ICON_FILE)
				markings_icon_1_f.crop(17, 1, 48, 32)
			final_icon.blend_icon(markings_icon_1_f, ICON_OVERLAY)

		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_FRONT_2"))
			var/datum/universal_icon/markings_icon_2_f = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_FRONT_2", NORTH)
			markings_icon_2_f.blend_color(COLOR_EFFIGY_PLATINUM, ICON_MULTIPLY)
			if(markings_icon_2_f.icon_file == EFFIGY_WINGS_ICON_FILE)
				markings_icon_2_f.crop(8, 2, 39, 33)
			else if(markings_icon_2_f.icon_file == EFFIGY_BIG_TAILS_ICON_FILE)
				markings_icon_2_f.crop(17, 1, 48, 32)
			final_icon.blend_icon(markings_icon_2_f, ICON_OVERLAY)

		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_FRONT_3"))
			var/datum/universal_icon/markings_icon_3_f = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_FRONT_3", NORTH)
			markings_icon_3_f.blend_color(COLOR_EFFIGY_ELECTRIC_BLUE, ICON_MULTIPLY)
			if(markings_icon_3_f.icon_file == EFFIGY_WINGS_ICON_FILE)
				markings_icon_3_f.crop(8, 2, 39, 33)
			else if(markings_icon_3_f.icon_file == EFFIGY_BIG_TAILS_ICON_FILE)
				markings_icon_3_f.crop(17, 1, 48, 32)
			final_icon.blend_icon(markings_icon_3_f, ICON_OVERLAY)

	//final_icon.Crop(4, 12, 28, 32)
	//final_icon.Scale(32, 26)
	//final_icon.Crop(-2, 1, 29, 32)

	return final_icon

/// Tail colors
/datum/preference/tri_color/tail_color
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "tail_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES

/datum/preference/tri_color/tail_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_color_1"] = value[1]
	target.dna.features["tail_color_2"] = value[2]
	target.dna.features["tail_color_3"] = value[3]

/datum/preference/tri_color/tail_color/create_default_value()
	return list(sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"))

/datum/preference/tri_color/tail_color/is_valid(value)
	if (!..(value))
		return FALSE
	return TRUE

/datum/bodypart_overlay/mutant/tail
	layers = EXTERNAL_FRONT | EXTERNAL_FRONT_2 | EXTERNAL_FRONT_3 | EXTERNAL_BEHIND | EXTERNAL_BEHIND_2 | EXTERNAL_BEHIND_3
	feature_key_sprite = "tail"

/datum/bodypart_overlay/mutant/tail/color_image(image/overlay, draw_layer, obj/item/bodypart/limb)
	if(limb == null)
		return ..()
	if(limb.owner == null)
		return ..()
	if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT))
		overlay.color = limb.owner.dna.features["tail_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_BEHIND))
		overlay.color = limb.owner.dna.features["tail_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT_2))
		overlay.color = limb.owner.dna.features["tail_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_BEHIND_2))
		overlay.color = limb.owner.dna.features["tail_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT_3))
		overlay.color = limb.owner.dna.features["tail_color_3"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_BEHIND_3))
		overlay.color = limb.owner.dna.features["tail_color_3"]
		return overlay
	return ..()
