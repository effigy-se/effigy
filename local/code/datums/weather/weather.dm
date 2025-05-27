/datum/weather/proc/temporary_maint_access()
	if(GLOB.emergency_access)
		return

	maint_access_active = TRUE
	make_maint_all_access(silent = TRUE)
	priority_announce(
		text = "Access restrictions on maintenance corridors have been removed for the duration of the event.",
		title = "Access Announcement",
		color_override = "orange",
	)
