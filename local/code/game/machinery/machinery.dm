/obj/machinery/button
	icon = 'local/icons/obj/buttons.dmi'

/obj/machinery/status_display
	icon = 'local/icons/obj/status_display.dmi'

/obj/machinery/status_display/post_machine_initialize()
	. = ..()
	set_picture("ai_off")

/obj/machinery/status_display/syndie
	name = "syndicate status display"

/obj/machinery/status_display/syndie/post_machine_initialize()
	. = ..()
	set_picture("synd")

/obj/machinery/power/emitter
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/field/containment
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/firealarm
	icon = 'local/icons/obj/firealarm.dmi'
