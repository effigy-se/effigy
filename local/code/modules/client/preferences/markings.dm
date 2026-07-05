/// Zonal markings
/datum/preference/choiced/markings
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MARKINGS
	abstract_type = /datum/preference/choiced/markings
	relevant_organ = null
	var/body_zone
	var/markingval

/datum/preference/choiced/markings/init_possible_values()
	var/datum/bodypart_overlay/simple/body_marking/body_markings/markings = new /datum/bodypart_overlay/simple/body_marking/body_markings()
	var/list/returnval = list()
	var/list/allmarkings = assoc_to_keys_features(SSaccessories.body_markings)
	for(var/i in allmarkings)
		var/datum/sprite_accessory/body_marking/accessory = markings.get_accessory(i)
		if(accessory.body_zones & body_zone)
			returnval += i
	return list("None") + sort_list(returnval)

/datum/preference/choiced/markings/create_default_value()
	return SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.features["markings_list"])
		var/list/markings_listt = list()
		LAZYSETLEN(markings_listt, MARKING_LIST_LEN)
		target.dna.features["markings_list"] = markings_listt

	if(!target.dna.features["markings_list_zones"])
		var/list/markings_listt = list()
		LAZYSETLEN(markings_listt, MARKING_LIST_LEN)
		target.dna.features["markings_list_zones"] = markings_listt

	target.dna.features["markings_list"][markingval] = value == /datum/sprite_accessory/blank::name ? null : value
	target.dna.features["markings_list_zones"][markingval] = value == /datum/sprite_accessory/blank::name ? null : body_zone

/// Zonal marking colors
/datum/preference/color/markings
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MARKINGS
	relevant_head_flag = null
	abstract_type = /datum/preference/color/markings
	var/markingval

/datum/preference/color/markings/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.features["markings_list_colors"])
		var/list/markings_listt = list()
		LAZYSETLEN(markings_listt, MARKING_LIST_LEN)
		target.dna.features["markings_list_colors"] = markings_listt

	target.dna.features["markings_list_colors"][markingval] = value

/datum/species/proc/add_zonal_markings(mob/living/carbon/human/target, value, colorvalue, bodypart)
	var/handlayer = FALSE
	bodypart = marking_zones(bodypart)
	if(bodypart == BODY_ZONE_PRECISE_L_HAND)
		handlayer = EXTERNAL_HAND
		bodypart = BODY_ZONE_L_ARM
	else if(bodypart == BODY_ZONE_PRECISE_R_HAND)
		handlayer = EXTERNAL_HAND
		bodypart = BODY_ZONE_R_ARM
	var/obj/item/bodypart/people_part =  target.get_bodypart(bodypart)
	if(people_part)
		var/datum/bodypart_overlay/simple/body_marking/body_markings/overlay = new /datum/bodypart_overlay/simple/body_marking/body_markings()
		var/datum/sprite_accessory/accessory = overlay.get_accessory(value)

		if(isnull(accessory))
			CRASH("Value: [value] did not have a corresponding sprite accessory!")

		overlay.icon = accessory.icon
		overlay.icon_state = accessory.icon_state
		if(handlayer)
			overlay.ishand = TRUE
			overlay.set_layers(handlayer)
		if(bodypart == BODY_ZONE_HEAD)
			overlay.use_gender = FALSE
		else
			overlay.use_gender = accessory.gender_specific

		overlay.draw_color = colorvalue || accessory.color_src
		people_part.add_bodypart_overlay(overlay)

/datum/species/add_body_markings(mob/living/carbon/human/target)
	. = ..()

	if(target.dna.features["markings_list"])
		if(islist(target.dna.features["markings_list"]) && islist(target.dna.features["markings_list_colors"]) && islist(target.dna.features["markings_list_zones"]))
			var/list/markingslist = target.dna.features["markings_list"]
			for(var/i in 1 to markingslist.len)
				if(markingslist[i] && markingslist[i] != SPRITE_ACCESSORY_NONE)
					add_zonal_markings(target, target.dna.features["markings_list"][i], target.dna.features["markings_list_colors"][i], target.dna.features["markings_list_zones"][i])

/datum/bodypart_overlay/simple/body_marking/body_markings
	blocks_emissive = EMISSIVE_BLOCK_NONE
	var/ishand = FALSE

/datum/bodypart_overlay/simple/body_marking/body_markings/get_accessory(name)
	return SSaccessories.body_markings[name]

/datum/bodypart_overlay/simple/body_marking/body_markings/get_image(obj/item/bodypart/limb, layer_index, layer_real)
	var/gender_string = ""
	if(use_gender && !(limb.body_zone in GLOB.limb_zones))
		gender_string = (limb.is_dimorphic) ? (limb.limb_gender == "m" ? MALE + "_" : FEMALE + "_") : "male_" // defaults to male so that andros dont get tiddies
	var/zonestring = limb.body_zone
	if(limb.bodyshape & BODYSHAPE_DIGITIGRADE)
		zonestring = "digitigrade_1_" + limb.body_zone
	if(ishand)
		zonestring = limb.aux_zone
	return image(icon, gender_string + icon_state + "_" + zonestring, layer = layer_real)

/datum/preference/color/markings/markings_r_leg3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_leg2) != SPRITE_ACCESSORY_NONE

#undef MARKING_LIST_LEN

/// cover_flags2body_zones is funky with hand bitflags for some reason. this is more efficient for what we want to do anyway
/datum/species/proc/marking_zones(zone)
	if(!zone)
		return
	switch(zone)
		if(HEAD)
			return BODY_ZONE_HEAD
		if(CHEST)
			return BODY_ZONE_CHEST
		if(ARM_LEFT)
			return BODY_ZONE_L_ARM
		if(ARM_RIGHT)
			return BODY_ZONE_R_ARM
		if(HAND_LEFT)
			return BODY_ZONE_PRECISE_L_HAND
		if(HAND_RIGHT)
			return BODY_ZONE_PRECISE_R_HAND
		if(LEG_LEFT)
			return BODY_ZONE_L_LEG
		if(LEG_RIGHT)
			return BODY_ZONE_R_LEG

// Head markings

/datum/preference/choiced/markings/markings_head
	savefile_key = "markings_head"
	main_feature_name = "Bodymarkings Head"
	body_zone = HEAD
	markingval = MARKING_HEAD

/datum/preference/color/markings/markings_head
	savefile_key = "markings_head_color"
	markingval = MARKING_HEAD

/datum/preference/choiced/markings/markings_head2
	savefile_key = "markings_head2"
	main_feature_name = "Bodymarkings Head 2"
	body_zone = HEAD
	markingval = MARKING_HEAD2

/datum/preference/choiced/markings/markings_head2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_head) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_head2
	savefile_key = "markings_head_color2"
	markingval = MARKING_HEAD2

/datum/preference/color/markings/markings_head2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_head) != SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/markings_head3
	savefile_key = "markings_head3"
	main_feature_name = "Bodymarkings Head 2"
	body_zone = HEAD
	markingval = MARKING_HEAD3

/datum/preference/choiced/markings/markings_head3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_head2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_head3
	savefile_key = "markings_head_color3"
	markingval = MARKING_HEAD3

/datum/preference/color/markings/markings_head3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_head2) != SPRITE_ACCESSORY_NONE

// Chest markings

/datum/preference/choiced/markings/markings_chest
	savefile_key = "markings_chest"
	main_feature_name = "Bodymarkings Chest"
	body_zone = CHEST
	markingval = MARKING_CHEST


/datum/preference/color/markings/markings_chest
	savefile_key = "markings_chest_color"
	markingval = MARKING_CHEST

/datum/preference/choiced/markings/markings_chest2
	savefile_key = "markings_chest2"
	main_feature_name = "Bodymarkings Chest 2"
	body_zone = CHEST
	markingval = MARKING_CHEST2

/datum/preference/choiced/markings/markings_chest2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_chest) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_chest2
	savefile_key = "markings_chest_color2"
	markingval = MARKING_CHEST2

/datum/preference/color/markings/markings_chest2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_chest) != SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/markings_chest3
	savefile_key = "markings_chest3"
	main_feature_name = "Bodymarkings Chest"
	body_zone = CHEST
	markingval = MARKING_CHEST3

/datum/preference/choiced/markings/markings_chest3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_chest2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_chest3
	savefile_key = "markings_chest_color3"
	markingval = MARKING_CHEST3

/datum/preference/color/markings/markings_chest3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_chest2) != SPRITE_ACCESSORY_NONE

// Right arm markings

/datum/preference/choiced/markings/markings_r_arm
	savefile_key = "markings_r_arm"
	main_feature_name = "Bodymarkings Right Arm"
	body_zone = ARM_RIGHT
	markingval = MARKING_RARM

/datum/preference/color/markings/markings_r_arm
	savefile_key = "markings_r_arm_color"
	markingval = MARKING_RARM

/datum/preference/choiced/markings/markings_r_arm2
	savefile_key = "markings_r_arm2"
	main_feature_name = "Bodymarkings Right Arm 2"
	body_zone = ARM_RIGHT
	markingval = MARKING_RARM2

/datum/preference/choiced/markings/markings_r_arm2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_arm) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_r_arm2
	savefile_key = "markings_r_arm_color2"
	markingval = MARKING_RARM2

/datum/preference/color/markings/markings_r_arm2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_arm) != SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/markings_r_arm3
	savefile_key = "markings_r_arm3"
	main_feature_name = "Bodymarkings Right Arm 3"
	body_zone = ARM_RIGHT
	markingval =  MARKING_RARM3

/datum/preference/choiced/markings/markings_r_arm3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_arm2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_r_arm3
	savefile_key = "markings_r_arm_color3"
	markingval = MARKING_RARM3

/datum/preference/color/markings/markings_r_arm3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_arm2) != SPRITE_ACCESSORY_NONE


// Left arm markings

/datum/preference/choiced/markings/markings_l_arm
	savefile_key = "markings_l_arm"
	main_feature_name = "Bodymarkings Left Arm"
	body_zone = ARM_LEFT
	markingval = MARKING_LARM

/datum/preference/color/markings/markings_l_arm
	savefile_key = "markings_l_arm_color"
	markingval = MARKING_LARM

/datum/preference/choiced/markings/markings_l_arm2
	savefile_key = "markings_l_arm2"
	main_feature_name = "Bodymarkings Left Arm 2"
	body_zone = ARM_LEFT
	markingval = MARKING_LARM2

/datum/preference/choiced/markings/markings_l_arm2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_arm) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_l_arm2
	savefile_key = "markings_l_arm_color2"
	markingval = MARKING_LARM2

/datum/preference/color/markings/markings_l_arm2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_arm) != SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/markings_l_arm3
	savefile_key = "markings_l_arm3"
	main_feature_name = "Bodymarkings Left Arm 3"
	body_zone = ARM_LEFT
	markingval = MARKING_LARM3


/datum/preference/choiced/markings/markings_l_arm3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_arm2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_l_arm3
	savefile_key = "markings_l_arm_color3"
	markingval = MARKING_LARM3

/datum/preference/color/markings/markings_l_arm3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_arm2) != SPRITE_ACCESSORY_NONE

// Left hand markings

/datum/preference/choiced/markings/markings_l_hand
	savefile_key = "markings_l_hand"
	main_feature_name = "Bodymarkings Left Hand"
	body_zone = HAND_LEFT
	markingval = MARKING_LHAND

/datum/preference/color/markings/markings_l_hand
	savefile_key = "markings_l_hand_color"
	markingval = MARKING_LHAND

/datum/preference/choiced/markings/markings_l_hand2
	savefile_key = "markings_l_hand2"
	main_feature_name = "Bodymarkings Left Hand 2"
	body_zone = HAND_LEFT
	markingval = MARKING_LHAND2

/datum/preference/choiced/markings/markings_l_hand2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_hand) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_l_hand2
	savefile_key = "markings_l_hand_color2"
	markingval = MARKING_LHAND2

/datum/preference/color/markings/markings_l_hand2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_hand) != SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/markings_l_hand3
	savefile_key = "markings_l_hand3"
	main_feature_name = "Bodymarkings Left Hand 3"
	body_zone = HAND_LEFT
	markingval = MARKING_LHAND3

/datum/preference/choiced/markings/markings_l_hand3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_hand2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_l_hand3
	savefile_key = "markings_l_hand_color3"
	markingval = MARKING_LHAND3

/datum/preference/color/markings/markings_l_hand3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_hand2) != SPRITE_ACCESSORY_NONE

// Right hand markings

/datum/preference/choiced/markings/markings_r_hand
	savefile_key = "markings_r_hand"
	main_feature_name = "Bodymarkings Right Hand"
	body_zone = HAND_RIGHT
	markingval = MARKING_RHAND

/datum/preference/color/markings/markings_r_hand
	savefile_key = "markings_r_hand_color"
	markingval = MARKING_RHAND

/datum/preference/choiced/markings/markings_r_hand2
	savefile_key = "markings_r_hand2"
	main_feature_name = "Bodymarkings Right Hand 2"
	body_zone = HAND_RIGHT
	markingval = MARKING_RHAND2

/datum/preference/choiced/markings/markings_r_hand2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_hand) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_r_hand2
	savefile_key = "markings_r_hand_color2"
	markingval = MARKING_RHAND2

/datum/preference/color/markings/markings_r_hand2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_hand) != SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/markings_r_hand3
	savefile_key = "markings_r_hand3"
	main_feature_name = "Bodymarkings Right Hand 3"
	body_zone = HAND_RIGHT
	markingval = MARKING_RHAND3

/datum/preference/choiced/markings/markings_r_hand3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_hand2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_r_hand3
	savefile_key = "markings_r_hand_color3"
	markingval = MARKING_RHAND3

/datum/preference/color/markings/markings_r_hand3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_hand2) != SPRITE_ACCESSORY_NONE

// Left leg markings

/datum/preference/choiced/markings/markings_l_leg
	savefile_key = "markings_l_leg"
	main_feature_name = "Bodymarkings Left Leg"
	body_zone = LEG_LEFT
	markingval = MARKING_LLEG

/datum/preference/color/markings/markings_l_leg
	savefile_key = "markings_l_leg_color"
	markingval = MARKING_LLEG

/datum/preference/choiced/markings/markings_l_leg2
	savefile_key = "markings_l_leg2"
	main_feature_name = "Bodymarkings Left Leg 2"
	body_zone = LEG_LEFT
	markingval = MARKING_LLEG2

/datum/preference/choiced/markings/markings_l_leg2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_leg) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_l_leg2
	savefile_key = "markings_l_leg_color2"
	markingval = MARKING_LLEG2

/datum/preference/color/markings/markings_l_leg2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_leg) != SPRITE_ACCESSORY_NONE


/datum/preference/choiced/markings/markings_l_leg3
	savefile_key = "markings_l_leg3"
	main_feature_name = "Bodymarkings Left Leg 3"
	body_zone = LEG_LEFT
	markingval = MARKING_LLEG3

/datum/preference/choiced/markings/markings_l_leg3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_leg2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_l_leg3
	savefile_key = "markings_l_leg_color3"
	markingval = MARKING_LLEG3

/datum/preference/color/markings/markings_l_leg3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_l_leg2) != SPRITE_ACCESSORY_NONE

// Right leg markings

/datum/preference/choiced/markings/markings_r_leg
	savefile_key = "markings_r_leg"
	main_feature_name = "Bodymarkings Right Leg"
	body_zone = LEG_RIGHT
	markingval = MARKING_RLEG

/datum/preference/color/markings/markings_r_leg
	savefile_key = "markings_r_leg_color"
	markingval = MARKING_RLEG

/datum/preference/choiced/markings/markings_r_leg2
	savefile_key = "markings_r_leg2"
	main_feature_name = "Bodymarkings Right Leg 2"
	body_zone = LEG_RIGHT
	markingval = MARKING_RLEG2

/datum/preference/choiced/markings/markings_r_leg2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_leg) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_r_leg2
	savefile_key = "markings_r_leg_color2"
	markingval = MARKING_RLEG2

/datum/preference/color/markings/markings_r_leg2/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_leg) != SPRITE_ACCESSORY_NONE

/datum/preference/choiced/markings/markings_r_leg3
	savefile_key = "markings_r_leg3"
	main_feature_name = "Bodymarkings Right Leg 3"
	body_zone = LEG_RIGHT
	markingval = MARKING_RLEG3

/datum/preference/choiced/markings/markings_r_leg3/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/choiced/markings/markings_r_leg2) != SPRITE_ACCESSORY_NONE

/datum/preference/color/markings/markings_r_leg3
	savefile_key = "markings_r_leg_color3"
	markingval = MARKING_RLEG3
