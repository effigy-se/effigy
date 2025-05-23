/**
 * Character Profile Preferences
 *
 * Used in the Job Application summary.
 * This file contains choiced preference definitions for various character background
 * details such as birthday, origin, education, etc.
 */
/datum/preference/choiced/profile
	category = PREFERENCE_CATEGORY_CV_OPTIONS
	priority = PREFERENCE_PRIORITY_DEFAULT
	savefile_identifier = PREFERENCE_CHARACTER
	abstract_type = /datum/preference/choiced/profile

/datum/preference/choiced/profile/apply_to_human(mob/living/carbon/human/target, value)
	return FALSE

/datum/preference/choiced/profile/create_default_value()
	return "Unspecified"

/datum/preference/choiced/profile/is_accessible(datum/preferences/preferences)
	. = ..()
	return TRUE

/datum/preference/choiced/profile/planet
	savefile_key = "profile_planet"

/datum/preference/choiced/profile/planet/init_possible_values()
	return list(
		"Unspecified",
		"Earth",
		"Mars",
		"Luna (Moon Colony)",
		"Europa (Jovian Moon)",
		"Titan (Saturnian Moon)",
		"Orbital Habitat",
		"Deep Space Colony",
		"Other System/Anomalous Origin",
	)

/datum/preference/choiced/profile/residence
	savefile_key = "profile_residence"

/datum/preference/choiced/profile/residence/init_possible_values()
	return list(
		"Unspecified",
		"Option One",
		"Option Two",
	)

/datum/preference/choiced/profile/nationality
	savefile_key = "profile_nationality"

/datum/preference/choiced/profile/nationality/init_possible_values()
	return list(
		"Unspecified",
		"Option One",
		"Option Two",
	)

/datum/preference/choiced/profile/education
	savefile_key = "profile_education"

/datum/preference/choiced/profile/education/init_possible_values()
	return list(
		"Unspecified",
		"Option One",
		"Option Two",
	)

/datum/preference/choiced/profile/employment_history
	savefile_key = "profile_employment_history"

/datum/preference/choiced/profile/employment_history/init_possible_values()
	return list(
		"Unspecified",
		"Option One",
		"Option Two",
	)

/datum/preference/choiced/profile/religion
	savefile_key = "profile_religion"

/datum/preference/choiced/profile/religion/init_possible_values()
	return list(
		"Unspecified",
		"Option One",
		"Option Two",
	)

/datum/preference/text/medical
	category = PREFERENCE_CATEGORY_CV_OPTIONS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "profile_medical"
	maximum_value_length = MAX_FLAVOUR_TEXT_LENGTH

/datum/preference/text/medical/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/security
	category = PREFERENCE_CATEGORY_CV_OPTIONS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "profile_security"
	maximum_value_length = MAX_FLAVOUR_TEXT_LENGTH

/datum/preference/text/security/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/accomplishments
	category = PREFERENCE_CATEGORY_CV_OPTIONS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "profile_accomplishments"
	maximum_value_length = MAX_FLAVOUR_TEXT_LENGTH

/datum/preference/text/accomplishments/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
