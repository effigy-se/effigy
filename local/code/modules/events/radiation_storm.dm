/datum/round_event/radiation_storm/announce(fake)
	priority_announce(
		text = "High levels of radiation detected near the station. Crew are advised to seek shelter for the duration of the anomalous weather event.",
		title = "Radiation Alert",
		sound = ANNOUNCER_RADIATION,
	)
	// we trigger the airlocks for a bit to not immediately give away that it's fake
	if(fake && !GLOB.emergency_access)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(make_maint_all_access), FALSE), 4 SECONDS)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(revoke_maint_all_access), FALSE), 90 SECONDS)
