
/obj/machinery/door
	///Rapid open for unres/emergency
	var/rapid_open = FALSE

/obj/machinery/door/proc/rapid_open()
	return

/obj/machinery/door/airlock/rapid_open()
	if(airlock_state != AIRLOCK_CLOSED)
		return

	rapid_open = TRUE
	addtimer(CALLBACK(src, PROC_REF(post_rapid_open)), 0.8 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/machinery/door/proc/post_rapid_open()
	rapid_open = FALSE
