/datum/controller/subsystem/title
	var/list/static/fluff_messages
	var/fluff_enabled = FALSE

/datum/controller/subsystem/title/OnConfigLoad()
	. = ..()
	var/fluff_file = CONFIG_GET(string/fluff_status_file)
	if(!isnull(fluff_file))
		fluff_messages = world.file2list(fluff_file)
		if(LAZYLEN(fluff_messages))
			fluff_enabled = TRUE

/datum/controller/subsystem/title/Initialize()
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(send_init_fluff_message))
	for(var/mob/loading_mob as anything in GLOB.new_player_list)
		var/datum/hud/player_hud = loading_mob.hud_used
		for(var/atom/movable/screen/lobby/progress_bar/client_progress in player_hud.static_inventory)
			animate(client_progress, transform = client_progress.transform.Translate(x = 144, y = 0), time = 8 SECONDS)

/datum/controller/subsystem/title/proc/send_init_fluff_message()
	SEND_SIGNAL(src, COMSIG_TITLE_FLUFF_MESSAGE, fluff_enabled ? pick(fluff_messages) : "Initializing server...")
