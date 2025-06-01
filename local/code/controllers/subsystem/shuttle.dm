/datum/controller/subsystem/shuttle/proc/auto_end()
	if(EMERGENCY_IDLE_OR_RECALLED)
		SSshuttle.emergency.request(silent = TRUE)
		priority_announce("The shift has come to an end and the shuttle called. [SSsecurity_level.get_current_level_as_number() == SEC_LEVEL_RED ? "Red Alert state confirmed: Dispatching priority shuttle. " : "" ]It will arrive in [emergency.timeLeft(600)] minutes.", null, ANNOUNCER_SHUTTLECALLED, "Priority")
	emergency_no_recall = TRUE
