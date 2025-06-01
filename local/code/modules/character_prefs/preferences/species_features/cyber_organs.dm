// What will be supplied to proc/init_possible_values and proc/apply_to_human
GLOBAL_LIST_INIT(organ_types, list(
	"none",
	"cybernetic",
	))

// What will be showed in the drop-down
GLOBAL_LIST_INIT(organ_type_names, list(
	"none" = "Species Default",
	"cybernetic" = "Cybernetic",
	))

/// Heart type
/datum/preference/choiced/heart_type
	main_feature_name = "Heart"
	savefile_key = "heart_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/heart_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		target.dna?.species?.regenerate_organs(target)
		return
	target.dna?.species?.mutantheart = text2path("/obj/item/organ/heart/[value]")
	LAZYADDASSOC(target.dna.features["frame_list"], ORGAN_SLOT_HEART, text2path("/obj/item/organ/heart/[value]"))

/datum/preference/choiced/heart_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.organ_type_names
	return data

/datum/preference/choiced/heart_type/create_default_value()
	return "none"

/datum/preference/choiced/heart_type/init_possible_values()
	return GLOB.organ_types

/datum/preference/choiced/heart_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[CYBER_ORGANS]))
		return FALSE

	return TRUE

/// Lungs type
/datum/preference/choiced/lungs_type
	main_feature_name = "Lungs"
	savefile_key = "lungs_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/lungs_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		target.dna?.species?.regenerate_organs(target)
		return
	target.dna?.species?.mutantlungs = text2path("/obj/item/organ/lungs/[value]")
	LAZYADDASSOC(target.dna.features["frame_list"], ORGAN_SLOT_LUNGS, text2path("/obj/item/organ/lungs/[value]"))

/datum/preference/choiced/lungs_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.organ_type_names
	return data

/datum/preference/choiced/lungs_type/create_default_value()
	return "none"

/datum/preference/choiced/lungs_type/init_possible_values()
	return GLOB.organ_types

/datum/preference/choiced/lungs_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[CYBER_ORGANS]))
		return FALSE

	return TRUE

/// Liver type
/datum/preference/choiced/liver_type
	main_feature_name = "Liver"
	savefile_key = "liver_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/liver_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		target.dna?.species?.regenerate_organs(target)
		return
	target.dna?.species?.mutantliver = text2path("/obj/item/organ/liver/[value]")
	LAZYADDASSOC(target.dna.features["frame_list"], ORGAN_SLOT_LIVER, text2path("/obj/item/organ/liver/[value]"))

/datum/preference/choiced/liver_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.organ_type_names
	return data

/datum/preference/choiced/liver_type/create_default_value()
	return "none"

/datum/preference/choiced/liver_type/init_possible_values()
	return GLOB.organ_types

/datum/preference/choiced/liver_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[CYBER_ORGANS]))
		return FALSE

	return TRUE

/// Stomach type
/datum/preference/choiced/stomach_type
	main_feature_name = "Stomach"
	savefile_key = "stomach_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/stomach_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		target.dna?.species?.regenerate_organs(target)
		return
	target.dna?.species?.mutantstomach = text2path("/obj/item/organ/stomach/[value]")
	LAZYADDASSOC(target.dna.features["frame_list"], ORGAN_SLOT_STOMACH, text2path("/obj/item/organ/stomach/[value]"))

/datum/preference/choiced/stomach_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.organ_type_names
	return data

/datum/preference/choiced/stomach_type/create_default_value()
	return "none"

/datum/preference/choiced/stomach_type/init_possible_values()
	return GLOB.organ_types

/datum/preference/choiced/stomach_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[CYBER_ORGANS]))
		return FALSE

	return TRUE

/// Stomach type
/datum/preference/choiced/eyes_type
	main_feature_name = "Eyes"
	savefile_key = "eyes_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/eyes_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		target.dna?.species?.regenerate_organs(target)
		return
	target.dna?.species?.mutanteyes = text2path("/obj/item/organ/eyes/[value]")
	LAZYADDASSOC(target.dna.features["frame_list"], ORGAN_SLOT_EYES, text2path("/obj/item/organ/eyes/[value]"))

/datum/preference/choiced/eyes_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = list("none" = "Species Default", "cybernetic" = "Cybernetic")
	return data

/datum/preference/choiced/eyes_type/create_default_value()
	return "none"

/datum/preference/choiced/eyes_type/init_possible_values()
	return list("none", "cybernetic")

/datum/preference/choiced/eyes_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[CYBER_ORGANS]))
		return FALSE

	return TRUE

/// Tongue type
/datum/preference/choiced/tongue_type
	main_feature_name = "Tongue"
	savefile_key = "tongue_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/tongue_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		target.dna?.species?.regenerate_organs(target)
		return
	target.dna?.species?.mutanttongue = text2path("/obj/item/organ/tongue/[value]")
	LAZYADDASSOC(target.dna.features["frame_list"], ORGAN_SLOT_TONGUE, text2path("/obj/item/organ/tongue/[value]"))

/datum/preference/choiced/tongue_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = list("none" = "Species Default", "cybernetic" = "Cybernetic")
	return data

/datum/preference/choiced/tongue_type/create_default_value()
	return "none"

/datum/preference/choiced/tongue_type/init_possible_values()
	return list("none", "cybernetic")

/datum/preference/choiced/tongue_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[CYBER_ORGANS]))
		return FALSE

	return TRUE

/// Breathing Tube
/datum/preference/choiced/breathing_tube
	main_feature_name = "Breathing Tube"
	savefile_key = "breathing_tube"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/breathing_tube/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		target.dna?.species?.regenerate_organs(target)
		return
	LAZYADDASSOC(target.dna.features["frame_list"], ORGAN_SLOT_BREATHING_TUBE, text2path("/obj/item/organ/cyberimp/mouth/[value]"))

/datum/preference/choiced/breathing_tube/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = list("none" = "None", "breathing_tube" = "Breathing Tube")
	return data

/datum/preference/choiced/breathing_tube/create_default_value()
	return "none"

/datum/preference/choiced/breathing_tube/init_possible_values()
	return list("none", "breathing_tube")

/datum/preference/choiced/breathing_tube/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[CYBER_ORGANS]))
		return FALSE

	return TRUE

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()
	if(target.dna.features["frame_list"])
		//liver
		if(target.dna.features["frame_list"][ORGAN_SLOT_HEART])
			var/obj/item/organ/heart/old_organ = target.get_organ_slot(ORGAN_SLOT_HEART)
			var/obj/item/organ/heart/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][ORGAN_SLOT_HEART])
			old_organ.before_organ_replacement(replacement)
			old_organ.Remove(target, special = TRUE)
			QDEL_NULL(old_organ)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		//liver
		if(target.dna.features["frame_list"][ORGAN_SLOT_LUNGS])
			var/obj/item/organ/lungs/old_organ = target.get_organ_slot(ORGAN_SLOT_LUNGS)
			var/obj/item/organ/lungs/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][ORGAN_SLOT_LUNGS])
			old_organ.before_organ_replacement(replacement)
			old_organ.Remove(target, special = TRUE)
			QDEL_NULL(old_organ)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		//liver
		if(target.dna.features["frame_list"][ORGAN_SLOT_LIVER])
			var/obj/item/organ/liver/old_organ = target.get_organ_slot(ORGAN_SLOT_LIVER)
			var/obj/item/organ/liver/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][ORGAN_SLOT_LIVER])
			old_organ.before_organ_replacement(replacement)
			old_organ.Remove(target, special = TRUE)
			QDEL_NULL(old_organ)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		//liver
		if(target.dna.features["frame_list"][ORGAN_SLOT_STOMACH])
			var/obj/item/organ/stomach/old_organ = target.get_organ_slot(ORGAN_SLOT_STOMACH)
			var/obj/item/organ/stomach/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][ORGAN_SLOT_STOMACH])
			old_organ.before_organ_replacement(replacement)
			old_organ.Remove(target, special = TRUE)
			QDEL_NULL(old_organ)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		//eyes
		if(target.dna.features["frame_list"][ORGAN_SLOT_EYES])
			var/obj/item/organ/eyes/old_organ = target.get_organ_slot(ORGAN_SLOT_EYES)
			var/obj/item/organ/eyes/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][ORGAN_SLOT_EYES])
			old_organ.before_organ_replacement(replacement)
			old_organ.Remove(target, special = TRUE)
			QDEL_NULL(old_organ)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		//tongue
		if(target.dna.features["frame_list"][ORGAN_SLOT_TONGUE])
			var/obj/item/organ/tongue/old_organ = target.get_organ_slot(ORGAN_SLOT_TONGUE)
			var/obj/item/organ/tongue/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][ORGAN_SLOT_TONGUE])
			old_organ.before_organ_replacement(replacement)
			old_organ.Remove(target, special = TRUE)
			QDEL_NULL(old_organ)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		//breathing tube
		if(target.dna.features["frame_list"][ORGAN_SLOT_BREATHING_TUBE])
			var/obj/item/organ/cyberimp/mouth/old_organ = target.get_organ_slot(ORGAN_SLOT_BREATHING_TUBE)
			var/obj/item/organ/cyberimp/mouth/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][ORGAN_SLOT_BREATHING_TUBE])
			if(!isnull(old_organ))
				old_organ.before_organ_replacement(replacement)
				old_organ.Remove(target, special = TRUE)
				QDEL_NULL(old_organ)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		return .
