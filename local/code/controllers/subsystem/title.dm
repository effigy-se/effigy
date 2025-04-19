/datum/controller/subsystem/title
	var/list/static/fluff_messages
	var/fluff_enabled = FALSE

/datum/controller/subsystem/title/Initialize()
	. = ..()
	var/fluff_file = CONFIG_GET(string/fluff_status_file)
	if(!isnull(fluff_file))
		fluff_messages = world.file2list(fluff_file)
		if(LAZYLEN(fluff_messages))
			fluff_enabled = TRUE

	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(send_init_fluff_message))
	for(var/mob/loading_mob as anything in GLOB.new_player_list)
		var/datum/hud/player_hud = loading_mob.hud_used
		for(var/atom/movable/screen/lobby/progress_bar/client_progress in player_hud.static_inventory)
			animate(client_progress, transform = client_progress.transform.Translate(x = 144, y = 0), time = 8 SECONDS)

/proc/send_init_fluff_message()
	var/fluff_message
	if(!SStitle.fluff_enabled)
		fluff_message = "Initializing server..."
	else
		fluff_message = pick(SStitle.fluff_messages)

	for(var/mob/loading_mob as anything in GLOB.new_player_list)
		var/datum/hud/player_hud = loading_mob.hud_used
		for(var/atom/movable/screen/lobby/fluff_text/client_fluff in player_hud.static_inventory)
			client_fluff.init_progress(fluff_message = fluff_message)
