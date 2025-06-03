SUBSYSTEM_DEF(local_government)
	name = "Local Government"
	flags = SS_NO_FIRE
	var/list/current_laws = list()

/datum/controller/subsystem/local_government/Initialize()
	DecideLaws()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/local_government/proc/DecideLaws()
	return
