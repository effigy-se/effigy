/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'local/icons/obj/doors/firedoor_glass.dmi'
	var/water_sensor = FALSE

/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(welded)
		. += mutable_appearance(icon, density ? "welded" : "welded_open")
	if(istype(src, /obj/machinery/door/firedoor/border_only))
		return
	if(animation)
		. += mutable_appearance(icon, "firelock_door_[animation]")
		. += emissive_appearance(icon, "firelock_door_[animation]", src, alpha = src.alpha, apply_bloom = FALSE)
		. += emissive_appearance(icon, "firelock_operating", src, alpha = src.alpha)
		return
	if(!density)
		return
	. += emissive_appearance(icon, "firelock_decal", src, alpha = src.alpha, apply_bloom = FALSE)
	if(powered())
		. += mutable_appearance(icon, "firelock_solid")
		. += emissive_appearance(icon, "firelock_solid", src, alpha = src.alpha)
	if(ignore_alarms)
		return
	if(obj_flags & EMAGGED)
		. += mutable_appearance(icon, "em_firelock_alarm_type_emag")
		. += emissive_appearance(icon, "em_firelock_alarm_type_emag", src, alpha = src.alpha)
	else if(isnull(alarm_type))
		. += mutable_appearance(icon, "em_firelock_no_alarm")
		. += emissive_appearance(icon, "em_firelock_no_alarm", src, alpha = src.alpha)
	else
		. += mutable_appearance(icon, "em_[alarm_type]")
		. += emissive_appearance(icon, "em_[alarm_type]", src, alpha = src.alpha)

/obj/machinery/door/firedoor/proc/check_liquids(turf/checked_turf)
	var/obj/effect/abstract/liquid_turf/liquids = checked_turf.liquids
	if(isnull(liquids))
		return

	if(liquids.height > 1)
		return FIRELOCK_ALARM_TYPE_COLD

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'local/icons/obj/doors/firedoor.dmi'

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)

/obj/machinery/door/firedoor/closed
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

/obj/machinery/door/firedoor/water_sensor
	name = "environmental shutter"
	water_sensor = TRUE

/obj/machinery/door/firedoor/water_sensor/heavy
	name = "heavy environmental shutter"
	desc = /obj/machinery/door/firedoor/heavy::desc
	icon = /obj/machinery/door/firedoor/heavy::icon
	glass = /obj/machinery/door/firedoor/heavy::glass
	explosion_block = /obj/machinery/door/firedoor/heavy::explosion_block
	assemblytype = /obj/machinery/door/firedoor/heavy::assemblytype // This should probably be changed for this and parent; but it's not a big enough issue atm.
	max_integrity = /obj/machinery/door/firedoor/heavy::max_integrity
