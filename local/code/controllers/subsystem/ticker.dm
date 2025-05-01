/datum/controller/subsystem/ticker
	/// Did we broadcast at players to hurry up?
	var/launch_queued = FALSE
	/// Did we broadcast the start time?
	var/hr_announce_fired = FALSE
	/// UTC time of round start
	var/round_utc_start_time = 0
	/// Have we started the lobby music
	var/lobby_track_fired = FALSE
	/// What is the lobby track this round
	var/lobby_track_id
	/// How long is the lobby track
	var/lobby_track_duration

/datum/controller/subsystem/ticker/proc/load_lobby_tracks()
	lobby_track_id = CONFIG_GET(string/pregame_lobby_track)
	if(isnull(lobby_track_id))
		log_game("No lobby music track ID configuration found!")
		lobby_track_fired = TRUE
		lobby_track_duration = -2
	lobby_track_duration = CONFIG_GET(number/pregame_lobby_duration)
	if(isnull(lobby_track_duration))
		log_game("No lobby music track duration configuration found!")
		lobby_track_duration = -3

/datum/controller/subsystem/ticker/proc/queue_game_start(time_override)
	if(isnull(time_override) || !isnum(time_override))
		CRASH("Queue Game Start called without a valid time override")

	timeLeft = time_override
	log_game("Game start queued in [DisplayTimeText(time_override)]")

	if(time_override <= 94 SECONDS)
		hr_announce_fired = TRUE
		lobby_track_fired = FALSE

	queue_game_start_announcement()

/datum/controller/subsystem/ticker/proc/queue_game_start_announcement()
	var/announce_time = round(timeLeft, 10 SECONDS)
	var/list/announcement_strings = list()
	var/header = span_major_announcement_title("Shift Start Update")
	header += span_subheader_announcement_text("Central Command Organic Resources")
	announcement_strings += span_announcement_header(header)
	announcement_strings += span_major_announcement_text("[command_name()] is currently finalizing [GLOB.round_id ? "crew manifest ID [GLOB.round_id]" : "the crew manifest"] for today's shift aboard [station_name()].<br/><br/>In [DisplayTimeText(announce_time)] the crew manifest will be locked and station onboarding at [SSmapping.current_map.map_name] will begin.<br/><br/>All crew are advised to verify their 'Ready' status in your personnel profile before this time. Once the manifest is locked, please consult your assigned Head of Personnel for any further organic resources requests.")
	var/finalized_announcement = create_announcement_div(jointext(announcement_strings, ""), PURPLE)
	to_chat(world, finalized_announcement)
	for(var/mob/player in GLOB.player_list)
		SEND_SOUND(player, sound('sound/announcer/default/attention.ogg'))
