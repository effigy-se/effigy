/// manifest preview in pre-lobby
/datum/config_entry/flag/show_manifest_preview
	default = TRUE

/// File where fluff status messages are stored
/datum/config_entry/string/fluff_status_file

/// Use the Effigy API
/datum/config_entry/flag/effigy_api_enabled
	default = FALSE

/// API configuration
/datum/config_entry/string/effigy_api_url
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/// API auth method
/datum/config_entry/string/effigy_api_auth
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN
	default = "Bearer"

/// API key
/datum/config_entry/string/effigy_api_key
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/// New account registration URL
/datum/config_entry/string/account_registration_url
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/// Lobby music track ID
/datum/config_entry/string/pregame_lobby_track

/// Lobby music track duration
/datum/config_entry/number/pregame_lobby_duration
	default = -1

/datum/config_entry/number/jungle_budget
	default = 2
	integer = FALSE
	min_val = 0

// Please note the intended jungle caves budget will be ~8 depending on how many ruins there are - this is to avoid issues atm.
/datum/config_entry/number/jungle_cave_budget
	default = 2
	integer = FALSE
	min_val = 0

/datum/config_entry/number/ocean_budget
	default = 6
	integer = FALSE
	min_val = 0

// Please note the intended jungle caves budget will be ~8 depending on how many ruins there are - this is to avoid issues atm.
/datum/config_entry/number/trench_budget
	default = 6
	integer = FALSE
	min_val = 0
