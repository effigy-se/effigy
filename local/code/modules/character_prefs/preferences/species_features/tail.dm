/datum/dna
	///	This variable is read by the regenerate_organs() proc to know what organ subtype to give
	var/tail_type = NO_VARIATION

/datum/controller/subsystem/accessories
	var/list/tails_list_dog
	var/list/tails_list_fox
	var/list/tails_list_flying
	var/list/tails_list_mammal
	var/list/tails_list_synth
	var/list/tails_list_humanoid

/datum/controller/subsystem/accessories/setup_lists()
	. = ..()
	tails_list_dog = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/dog)["default_sprites"]
	tails_list_fox = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/fox)["default_sprites"]
	tails_list_flying = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/flying)["default_sprites"]
	tails_list_mammal = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/mammal)["default_sprites"]
	tails_list_synth = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/cybernetic)["default_sprites"]
	tails_list_humanoid = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/humanoid)["default_sprites"]

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()
	if(target == null)
		return
	if(!ishuman(target))
		return

	if(target.dna.features["tail_lizard"] != /datum/sprite_accessory/tails/lizard/none::name  && (type in GLOB.bodypart_allowed_species[TAIL]) && target.dna.features["tail_lizard"] != /datum/sprite_accessory/blank::name)
		var/obj/item/organ/replacement = SSwardrobe.provide_type(/obj/item/organ/tail/lizard)
		replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		return .
	else if(target.dna.features["tail_cat"] != /datum/sprite_accessory/tails/felinid/none::name && (type in GLOB.bodypart_allowed_species[TAIL]) && target.dna.features["tail_cat"] != /datum/sprite_accessory/blank::name)
		var/obj/item/organ/replacement = SSwardrobe.provide_type(/obj/item/organ/tail/cat)
		replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		return .
	else if(target.dna.features["tail_monkey"] != /datum/sprite_accessory/tails/monkey/none::name && (type in GLOB.bodypart_allowed_species[TAIL]) && target.dna.features["tail_monkey"] != /datum/sprite_accessory/blank::name)
		var/obj/item/organ/replacement = SSwardrobe.provide_type(/obj/item/organ/tail/monkey)
		replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		return .
	else if(target.dna.features["fish_tail"] != /datum/sprite_accessory/tails/fish/none::name && (type in GLOB.bodypart_allowed_species[TAIL]) && target.dna.features["fish_tail"] != /datum/sprite_accessory/blank::name)
		var/obj/item/organ/replacement = SSwardrobe.provide_type(/obj/item/organ/tail/fish)
		replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		return .
	else if((target.dna.features["tail_other"] != /datum/sprite_accessory/tails/lizard/none::name && (type in GLOB.bodypart_allowed_species[TAIL]) && target.dna.features["tail_other"] != /datum/sprite_accessory/blank::name) && (target.dna.tail_type != NO_VARIATION))
		var/obj/item/organ/organ_path = text2path("/obj/item/organ/tail/[target.dna.tail_type]")
		var/obj/item/organ/replacement = SSwardrobe.provide_type(organ_path)
		replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		return .

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
	// Read by the regenerate_organs() proc to know what organ subtype to grant
	target.dna.tail_type = chosen_variation
	switch(chosen_variation)
		if(NO_VARIATION)
			target.dna.features["tail_lizard"] = /datum/sprite_accessory/tails/lizard/none::name
			target.dna.features["tail_cat"] = /datum/sprite_accessory/tails/felinid/none::name
			target.dna.features["tail_monkey"] = /datum/sprite_accessory/tails/monkey/none::name
			target.dna.features["fish_tail"] = /datum/sprite_accessory/tails/fish/none::name
			target.dna.features["tail_other"] = /datum/sprite_accessory/tails/none::name
		if(LIZARD_TYPE)
			target.dna.features["tail_cat"] = /datum/sprite_accessory/tails/felinid/none::name
			target.dna.features["tail_monkey"] = /datum/sprite_accessory/tails/monkey/none::name
			target.dna.features["fish_tail"] = /datum/sprite_accessory/tails/fish/none::name
			target.dna.features["tail_other"] = /datum/sprite_accessory/tails/none::name
		if(CAT_TYPE)
			target.dna.features["tail_lizard"] = /datum/sprite_accessory/tails/lizard/none::name
			target.dna.features["tail_monkey"] = /datum/sprite_accessory/tails/monkey/none::name
			target.dna.features["fish_tail"] = /datum/sprite_accessory/tails/fish/none::name
			target.dna.features["tail_other"] = /datum/sprite_accessory/tails/none::name
		if(MONKEY_TYPE)
			target.dna.features["tail_cat"] = /datum/sprite_accessory/tails/felinid/none::name
			target.dna.features["tail_lizard"] = /datum/sprite_accessory/tails/lizard/none::name
			target.dna.features["fish_tail"] = /datum/sprite_accessory/tails/fish/none::name
			target.dna.features["tail_other"] = /datum/sprite_accessory/tails/none::name
		if(AQUATIC_TYPE)
			target.dna.features["tail_cat"] = /datum/sprite_accessory/tails/felinid/none::name
			target.dna.features["tail_lizard"] = /datum/sprite_accessory/tails/lizard/none::name
			target.dna.features["tail_monkey"] = /datum/sprite_accessory/tails/monkey/none::name
			target.dna.features["tail_other"] = /datum/sprite_accessory/tails/none::name
		else
			target.dna.features["tail_lizard"] = /datum/sprite_accessory/tails/lizard/none::name
			target.dna.features["tail_cat"] = /datum/sprite_accessory/tails/felinid/none::name
			target.dna.features["tail_monkey"] = /datum/sprite_accessory/tails/monkey/none::name
			target.dna.features["fish_tail"] = /datum/sprite_accessory/tails/fish/none::name

/datum/preference/choiced/tail_variation/create_default_value()
	return NO_VARIATION

/datum/preference/choiced/tail_variation/init_possible_values()
	return list(NO_VARIATION) + (GLOB.mutant_variations)

/datum/preference/choiced/tail_variation/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	return TRUE

///	Lizard tail type
/datum/preference/choiced/lizard_tail // override from TG default
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/lizard_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_lizard"] = value

/datum/preference/choiced/lizard_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/lizard_tail/create_default_value()
	return /datum/sprite_accessory/tails/lizard/none::name

/datum/preference/choiced/lizard_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_lizard[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/lizard_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == LIZARD_TYPE)
		return TRUE
	return FALSE

///	Cat tail type
/datum/preference/choiced/tail_felinid
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/tail_felinid/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_cat"] = value

/datum/preference/choiced/tail_felinid/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/tail_felinid/create_default_value()
	return /datum/sprite_accessory/tails/felinid/none::name

/datum/preference/choiced/tail_felinid/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_felinid[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/tail_felinid/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(species.type in GLOB.bodypart_allowed_species[TAIL])
		return FALSE
	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == CAT_TYPE)
		return TRUE
	return FALSE

///	Dog tail type
/datum/preference/choiced/dog_tail
	savefile_key = "feature_dog_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/dog_tail/apply_to_human(mob/living/carbon/human/target, value)
	if(target.dna.tail_type == DOG_TYPE)	// we will be sharing the 'tail_other' slot with multiple tail types
		target.dna.features["tail_other"] = value

/datum/preference/choiced/dog_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/dog_tail/create_default_value()
	return /datum/sprite_accessory/tails/dog/none::name

/datum/preference/choiced/dog_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_dog[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/dog_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_dog)

/datum/preference/choiced/dog_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == DOG_TYPE)
		return TRUE

	return FALSE

///	Fox tail type
/datum/preference/choiced/fox_tail
	savefile_key = "feature_fox_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/fox_tail/apply_to_human(mob/living/carbon/human/target, value)
	if(target.dna.tail_type == FOX_TYPE)
		target.dna.features["tail_other"] = value

/datum/preference/choiced/fox_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/fox_tail/create_default_value()
	return /datum/sprite_accessory/tails/fox/none::name

/datum/preference/choiced/fox_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_fox[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/fox_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_fox)

/datum/preference/choiced/fox_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == FOX_TYPE)
		return TRUE

	return FALSE

///	Mammal tail type
/datum/preference/choiced/mammal_tail
	savefile_key = "feature_mammal_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/mammal_tail/apply_to_human(mob/living/carbon/human/target, value)
	if(target.dna.tail_type == MAMMAL_TYPE)
		target.dna.features["tail_other"] = value

/datum/preference/choiced/mammal_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/mammal_tail/create_default_value()
	return /datum/sprite_accessory/tails/mammal/none::name

/datum/preference/choiced/mammal_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_mammal[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/mammal_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_mammal)

/datum/preference/choiced/mammal_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == MAMMAL_TYPE)
		return TRUE

	return FALSE

///	Flying tail type
/datum/preference/choiced/flying_tail
	savefile_key = "feature_flying_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/flying_tail/apply_to_human(mob/living/carbon/human/target, value)
	if(target.dna.tail_type == FLYING_TYPE)
		target.dna.features["tail_other"] = value

/datum/preference/choiced/flying_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/flying_tail/create_default_value()
	return /datum/sprite_accessory/tails/flying/none::name

/datum/preference/choiced/flying_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_flying[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/flying_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_flying)

/datum/preference/choiced/flying_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == FLYING_TYPE)
		return TRUE

	return FALSE

///	Monkey tail type
/datum/preference/choiced/monkey_tail
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/monkey_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_monkey"] = value

/datum/preference/choiced/monkey_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/monkey_tail/create_default_value()
	return /datum/sprite_accessory/tails/monkey/none::name

/datum/preference/choiced/monkey_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_monkey[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/monkey_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == MONKEY_TYPE)
		return TRUE

	return FALSE

///	Aquatic tail type
/datum/preference/choiced/fish_tail
	savefile_key = "feature_fish_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/fish_tail/apply_to_human(mob/living/carbon/human/target, value)
	if(target.dna.tail_type == AQUATIC_TYPE)
		target.dna.features["fish_tail"] = value

/datum/preference/choiced/fish_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/fish_tail/create_default_value()
	return /datum/sprite_accessory/tails/fish/none::name

/datum/preference/choiced/fish_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_fish[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/fish_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_fish)

/datum/preference/choiced/fish_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == AQUATIC_TYPE)
		return TRUE

	return FALSE

///	Synth tail type
/datum/preference/choiced/synth_tail
	savefile_key = "feature_synth_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/synth_tail/apply_to_human(mob/living/carbon/human/target, value)
	if(target.dna.tail_type == CYBERNETIC_TYPE)
		target.dna.features["tail_other"] = value

/datum/preference/choiced/synth_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/synth_tail/create_default_value()
	return /datum/sprite_accessory/tails/cybernetic/none::name

/datum/preference/choiced/synth_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_synth[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/synth_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_synth)

/datum/preference/choiced/synth_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
		return FALSE

	var/chosen_variation = preferences.read_preference(/datum/preference/choiced/tail_variation)
	if(chosen_variation == CYBERNETIC_TYPE)
		return TRUE

	return FALSE

///	Humanoid tail type
/datum/preference/choiced/humanoid_tail
	savefile_key = "feature_humanoid_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Tail"

/datum/preference/choiced/humanoid_tail/apply_to_human(mob/living/carbon/human/target, value)
	if(target.dna.tail_type == HUMANOID_TYPE)
		target.dna.features["tail_other"] = value

/datum/preference/choiced/humanoid_tail/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/tail_color::savefile_key
	return data

/datum/preference/choiced/humanoid_tail/create_default_value()
	return /datum/sprite_accessory/tails/humanoid/none::name

/datum/preference/choiced/humanoid_tail/icon_for(value)
	var/datum/sprite_accessory/chosen_tail = SSaccessories.tails_list_humanoid[value]
	return generate_back_icon(chosen_tail, "tail")

/datum/preference/choiced/humanoid_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_humanoid)

/datum/preference/choiced/humanoid_tail/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[TAIL]))
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
