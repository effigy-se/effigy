// What will be supplied to proc/init_possible_values and proc/apply_to_human
GLOBAL_LIST_INIT(frame_types, list(
	"none",
	"bare",
	"synth_lizard",
	"human_like",
	"bs_one",
	"bs_two",
	"classic",
	"e_three_n",
	"hi_one",
	"hi_two",
	"mariinsky",
	"mc",
	"sgm",
	"wtm",
	"xmg_one",
	"xmg_two",
	"zhp",
	"zhenkov",
	"zhenkovdark",
	"shard_alpha",
	))

// What will be showed in the drop-down
GLOBAL_LIST_INIT(frame_type_names, list(
	"none" = "Species Default",
	"bare" = "Bare",
	"synth_lizard" = "Synthetic Lizard",
	"human_like" = "Human-Like",
	"bs_one" = "Bishop Cyberkinetics",
	"bs_two" = "Bishop Cyberkinetics 2.0",
	"classic" = "Android",
	"e_three_n" = "E3N",
	"hi_one" = "Hephaestus Industries",
	"hi_two" = "Hephaestus Industries 2.0",
	"mariinsky" = "Mariinsky Ballet Company",
	"mc" = "Morpheus Cyberkinetics",
	"sgm" = "Shellguard Munitions S-Series",
	"wtm" = "Ward Takahashi Manufacturing",
	"xmg_one" = "Xion Manufacturing Group",
	"xmg_two" = "Xion Manufacturing Group 2.0",
	"zhp" = "Zeng-Hu Pharmaceuticals",
	"zhenkov" = "Zhenkov & Co. Foundries",
	"zhenkovdark" = "Zhenkov & Co. Foundries - At Night",
	"shard_alpha" = "Shard Alpha Raptoral",
	))

/// Head type
/datum/preference/choiced/head_type
	main_feature_name = "Head"
	savefile_key = "head_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/head_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		LAZYREMOVE(target.dna.features["frame_list"], BODY_ZONE_HEAD)
	else
		LAZYSET(target.dna.features["frame_list"], BODY_ZONE_HEAD, text2path("/obj/item/bodypart/head/robot/effigy/[value]"))

/datum/preference/choiced/head_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.frame_type_names
	return data

/datum/preference/choiced/head_type/create_default_value()
	return "none"

/datum/preference/choiced/head_type/init_possible_values()
	return GLOB.frame_types

/datum/preference/choiced/head_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/species = preferences.read_preference(/datum/preference/choiced/species)
	if(species == /datum/species/synth) // lifting this restriction would require code for the head's internal organs to become cybernetic too
		return TRUE
	return FALSE

/// Chest type
/datum/preference/choiced/chest_type
	main_feature_name = "Chest"
	savefile_key = "chest_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/chest_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		LAZYREMOVE(target.dna.features["frame_list"], BODY_ZONE_CHEST)
	else
		LAZYSET(target.dna.features["frame_list"], BODY_ZONE_CHEST, text2path("/obj/item/bodypart/chest/robot/effigy/[value]"))

/datum/preference/choiced/chest_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.frame_type_names
	return data

/datum/preference/choiced/chest_type/create_default_value()
	return "none"

/datum/preference/choiced/chest_type/init_possible_values()
	return GLOB.frame_types

/datum/preference/choiced/chest_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!is_type_in_typecache(species, GLOB.bodypart_allowed_species[FEATURE_CYBER_FRAME]))
		return FALSE

	return TRUE

/// Right arm type
/datum/preference/choiced/arm_r_type
	main_feature_name = "Right Arm"
	savefile_key = "arm_r_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/arm_r_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		LAZYREMOVE(target.dna.features["frame_list"], BODY_ZONE_R_ARM)
	else
		LAZYSET(target.dna.features["frame_list"], BODY_ZONE_R_ARM, text2path("/obj/item/bodypart/arm/right/robot/effigy/[value]"))

/datum/preference/choiced/arm_r_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.frame_type_names
	return data

/datum/preference/choiced/arm_r_type/create_default_value()
	return "none"

/datum/preference/choiced/arm_r_type/init_possible_values()
	return GLOB.frame_types

/datum/preference/choiced/arm_r_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!is_type_in_typecache(species, GLOB.bodypart_allowed_species[FEATURE_CYBER_FRAME]))
		return FALSE

	return TRUE

/// Left arm type
/datum/preference/choiced/arm_l_type
	main_feature_name = "Left Arm"
	savefile_key = "arm_l_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/arm_l_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		LAZYREMOVE(target.dna.features["frame_list"], BODY_ZONE_L_ARM)
	else
		LAZYSET(target.dna.features["frame_list"], BODY_ZONE_L_ARM, text2path("/obj/item/bodypart/arm/left/robot/effigy/[value]"))

/datum/preference/choiced/arm_l_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.frame_type_names
	return data

/datum/preference/choiced/arm_l_type/create_default_value()
	return "none"

/datum/preference/choiced/arm_l_type/init_possible_values()
	return GLOB.frame_types

/datum/preference/choiced/arm_l_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!is_type_in_typecache(species, GLOB.bodypart_allowed_species[FEATURE_CYBER_FRAME]))
		return FALSE

	return TRUE

/// Right leg type
/datum/preference/choiced/leg_r_type
	main_feature_name = "Right Leg"
	savefile_key = "leg_r_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/leg_r_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		LAZYREMOVE(target.dna.features["frame_list"], BODY_ZONE_R_LEG)
	else
		LAZYSET(target.dna.features["frame_list"], BODY_ZONE_R_LEG, text2path("/obj/item/bodypart/leg/right/robot/effigy/[value]"))

/datum/preference/choiced/leg_r_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.frame_type_names
	return data

/datum/preference/choiced/leg_r_type/create_default_value()
	return "none"

/datum/preference/choiced/leg_r_type/init_possible_values()
	return GLOB.frame_types

/datum/preference/choiced/leg_r_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!is_type_in_typecache(species, GLOB.bodypart_allowed_species[FEATURE_CYBER_FRAME]))
		return FALSE

	return TRUE

/// Left leg type
/datum/preference/choiced/leg_l_type
	main_feature_name = "Left Leg"
	savefile_key = "leg_l_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_AUGMENTS

/datum/preference/choiced/leg_l_type/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "none")
		LAZYREMOVE(target.dna.features["frame_list"], BODY_ZONE_L_LEG)
	else
		LAZYSET(target.dna.features["frame_list"], BODY_ZONE_L_LEG, text2path("/obj/item/bodypart/leg/left/robot/effigy/[value]"))

/datum/preference/choiced/leg_l_type/compile_constant_data()
	var/list/data = ..()
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.frame_type_names
	return data

/datum/preference/choiced/leg_l_type/create_default_value()
	return "none"

/datum/preference/choiced/leg_l_type/init_possible_values()
	return GLOB.frame_types

/datum/preference/choiced/leg_l_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!is_type_in_typecache(species, GLOB.bodypart_allowed_species[FEATURE_CYBER_FRAME]))
		return FALSE

	return TRUE

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE, replace_missing = TRUE)
	. = ..()
	if(!is_type_in_typecache(src, GLOB.bodypart_allowed_species[FEATURE_CYBER_FRAME]))
		return

	for(var/body_zone in GLOB.all_body_zones)
		if(!LAZYACCESS(target.dna.features["frame_list"], body_zone))
			continue
		if(body_zone == BODY_ZONE_HEAD && type != /datum/species/synth)
			continue
		var/obj/item/bodypart/old_limb = target.get_bodypart(body_zone)
		old_limb.drop_limb(special = TRUE, dismembered = FALSE, move_to_floor = FALSE)
		old_limb.moveToNullspace()
		var/obj/item/bodypart/replacement = SSwardrobe.provide_type(target.dna.features["frame_list"][body_zone])
		replacement.try_attach_limb(target, special = TRUE)
