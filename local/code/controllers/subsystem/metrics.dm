SUBSYSTEM_DEF(metrics)
	name = "Metrics"
	wait = 24 SECONDS
	runlevels = ALL
	flags = SS_NO_INIT
	dependencies = list(
		/datum/controller/subsystem/statpanels,
	)
	// Things we track
	var/active_players = 0
	var/observing_players = 0

/datum/controller/subsystem/metrics/fire(resumed = FALSE)
	// Player Count
	active_players = get_active_player_count(alive_check = FALSE, afk_check = TRUE, human_check = FALSE) // All active players, including players who are dead
	observing_players = length(GLOB.current_observers_list) // All players that started as an observer. Dead and lobby players are not included.
