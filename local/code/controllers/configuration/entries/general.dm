/// manifest preview in pre-lobby
/datum/config_entry/flag/show_manifest_preview
	default = TRUE

/// File where fluff status messages are stored
/datum/config_entry/string/fluff_status_file
	default = "config/effigy_splash_fluff.txt"

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
