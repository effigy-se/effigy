/datum/preference/toggle/master_erp_preferences
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "master_erp_pref"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/master_erp_preferences/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return TRUE
