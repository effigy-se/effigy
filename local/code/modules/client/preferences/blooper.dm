/datum/preference/choiced/blooper
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_choice"

/datum/preference/choiced/blooper/init_possible_values()
	return assoc_to_keys(GLOB.blooper_list)

/datum/preference/choiced/blooper/apply_to_human(mob/living/carbon/human/target, value)
	target.blooper = GLOB.blooper_list[value]

/datum/preference/numeric/blooper_speed
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_speed"
	minimum = BLOOPER_DEFAULT_MINSPEED
	maximum = BLOOPER_DEFAULT_MAXSPEED
	step = 0.5

/datum/preference/numeric/blooper_speed/apply_to_human(mob/living/carbon/human/target, value)
	target.blooper_speed = value

/datum/preference/numeric/blooper_speed/create_default_value()
	return round((BLOOPER_DEFAULT_MINSPEED + BLOOPER_DEFAULT_MAXSPEED) / 2, 0.1)

/datum/preference/numeric/blooper_pitch
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_pitch"
	minimum = BLOOPER_DEFAULT_MINPITCH
	maximum = BLOOPER_DEFAULT_MAXPITCH
	step = 0.05

/datum/preference/numeric/blooper_pitch/apply_to_human(mob/living/carbon/human/target, value)
	target.blooper_pitch = value

/datum/preference/numeric/blooper_pitch/create_default_value()
	return round((BLOOPER_DEFAULT_MINPITCH + BLOOPER_DEFAULT_MAXPITCH) / 2, 0.1)

/datum/preference/numeric/blooper_pitch_range
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_pitch_range"
	minimum = BLOOPER_DEFAULT_MINVARY
	maximum = BLOOPER_DEFAULT_MAXVARY
	step = 0.05

/datum/preference/numeric/blooper_pitch_range/apply_to_human(mob/living/carbon/human/target, value)
	target.blooper_pitch_range = value

/datum/preference/numeric/blooper_pitch_range/create_default_value()
	return 0.2

// Send vocal bloopers
/datum/preference/toggle/send_blooper
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "blooper_send"
	default_value = TRUE

// Hear vocal bloopers
/datum/preference/toggle/hear_blooper
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "blooper_hear"
	default_value = TRUE
