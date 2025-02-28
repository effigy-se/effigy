/**
 * For those 'FUCK IT, WE'LL DO IT LIVE!' kind of moments
 */

#define NO_UPDATE_REQUIRED -1
#define SAVEFILE_ERROR -2

/**
 * Checks if the version of the savefile is up to date.
 * If the return value is >= 0, update_effigy_savefile() will be called later.
 */
/datum/preferences/proc/effigy_savefile_needs_update(list/save_data)
	#ifndef UNIT_TESTS
	var/savefile_version = save_data["effigy_ext_version"]

	if(isnull(savefile_version)) // We must be a legacy Effigy save, or from another modular codebase
		var/list/legacy_data = savefile.get_entry("character1")
		var/legacy_version = legacy_data["modular_version"]
		if(legacy_version != EFFIGY_SAVEFILE_VERSION_LEGACY)
			stack_trace("Attempted to load the preferences of [parent] but could not find a valid version entry!")
			logger.Log(LOG_CATEGORY_DEBUG, "Loading preferences for [parent]. Current Effigy version: ERROR")
			return SAVEFILE_ERROR

		logger.Log(LOG_CATEGORY_DEBUG, "Loading preferences for [parent]. Current Effigy version: 3 (Legacy)")
		return EFFIGY_SAVEFILE_VERSION_LEGACY

	logger.Log(LOG_CATEGORY_DEBUG, "Loading preferences for [parent]. Current Effigy version: [savefile_version]")
	if(savefile_version < EFFIGY_SAVEFILE_VERSION_CURRENT)
		return savefile_version
	#endif

	return NO_UPDATE_REQUIRED
