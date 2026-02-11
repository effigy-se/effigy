/// Reboots the server after a TGS deployment. Requires config flag to be enabled. Server will only reboot if it's been idle for 2 hours.
/datum/tgs_event_handler/impl/proc/post_deployment_restart()
	if(!CONFIG_GET(flag/reboot_on_idle_deployment))
		return

	if(SSticker.current_state != GAME_STATE_PREGAME)
		return  // We only care if there's no active round

	if(SSticker.timeLeft != -20)
		return

	if((REALTIMEOFDAY - SSticker.utc_init_time) < 2 HOURS)
		return

	SSticker.Reboot("TGS Deployment: New Game Version", "pregame", 4 SECONDS)
