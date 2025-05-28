/datum/weather/proc/temporary_maint_access()
	if(GLOB.emergency_access)
		return

	maint_access_active = TRUE
	make_maint_all_access(silent = TRUE)
	minor_announce(
		message = "Access restrictions on maintenance corridors have been removed for the duration of the event.",
		title = "Access Announcement",
		alert = TRUE,
		color_override = "orange",
	)
