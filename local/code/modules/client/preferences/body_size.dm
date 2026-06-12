/datum/preference/numeric/body_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "body_size"
	minimum = DNA_BODY_UNIT_MIN
	maximum = DNA_BODY_UNIT_MAX
	step = 1

/datum/preference/numeric/body_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	return passed_initial_check

/datum/preference/numeric/body_size/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["body_size"] = value / DNA_BODY_UNIT

/datum/preference/numeric/body_size/create_default_value()
	return DNA_BODY_UNIT_DEFAULT

/datum/preference/choiced/species/apply_to_human(mob/living/carbon/human/target, value)
	. = ..()
	target.dna.update_effigy_body_size()

// Stop All Animations nulls the mob's transform, so we have to call update_body_size to ensure that it gets scaled properly again
/atom/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_STOP_ALL_ANIMATIONS] && check_rights(R_VAREDIT))
		var/mob/living/carbon/human/human_mob = src
		if(!istype(human_mob))
			return

		human_mob.dna.current_body_size = DNA_BODY_SIZE_DEFAULT // because if we don't set this, update_body_size will think that it has no work to do.
		human_mob.dna.update_effigy_body_size()
