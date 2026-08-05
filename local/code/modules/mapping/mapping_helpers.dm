/obj/effect/mapping_helpers/airlock/rapid_open
	name = "airlock rapid open helper"
	icon_state = "access_helper_adm"

/obj/effect/mapping_helpers/airlock/rapid_open/payload(obj/machinery/door/airlock/airlock)
	airlock.rapid_open = TRUE

/obj/effect/mapping_helpers/airlock/rapid_close
	name = "airlock rapid close helper"
	icon_state = "access_helper_adm"

/obj/effect/mapping_helpers/airlock/rapid_close/payload(obj/machinery/door/airlock/airlock)
	airlock.normalspeed = FALSE

/obj/effect/mapping_helpers/airlock/cyclelink_helper/payload(obj/machinery/door/airlock/airlock)
	. = ..()
	airlock.rapid_open = TRUE

/obj/effect/mapping_helpers/airlock/cyclelink_helper_multi/payload(obj/machinery/door/airlock/airlock)
	. = ..()
	airlock.rapid_open = TRUE

/obj/effect/mapping_helpers/airlock/access/all/supply/general/payload(obj/machinery/door/airlock/airlock)
	. = ..()
	if(airlock?.door_area.type == /area/shuttle/supply)
		airlock.rapid_open = TRUE
