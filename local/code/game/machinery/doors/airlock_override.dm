/**
 * This module sets airlocks in certain areas to be able to have an Engineer Override on orange alert.
 * Crew with ID cards with the engineering flag will be able to access these areas during those times.
 */

/area
	/// Is this area eligible for engineer override?
	var/engineering_override_eligible = FALSE
	var/fire_override_eligible = TRUE

/**
 * Set the areas that will receive expanded access for the engineers on an orange alert
 * Maintenance, bridge, departmental lobbies and inner rooms. No access to security.
 * Sensitive areas like the vault, command quarters, heads' offices, etc. are not applicable.
*/

/area/station/ai_monitored/command/storage/eva
	engineering_override_eligible = TRUE

/area/station/cargo
	engineering_override_eligible = TRUE

/area/station/command/bridge
	engineering_override_eligible = TRUE

/area/station/command/teleporter
	engineering_override_eligible = TRUE

/area/station/command/gateway
	engineering_override_eligible = TRUE

/area/station/construction/storage_wing
	engineering_override_eligible = TRUE

/area/station/engineering/atmos
	engineering_override_eligible = TRUE

/area/station/engineering/atmospherics_engine
	engineering_override_eligible = TRUE

/area/station/engineering/storage/tcomms
	engineering_override_eligible = TRUE

/area/station/hallway/secondary/command
	engineering_override_eligible = TRUE

/area/station/hallway/secondary/service
	engineering_override_eligible = TRUE

/area/station/maintenance
	engineering_override_eligible = TRUE

/area/station/medical
	engineering_override_eligible = TRUE

/area/station/security/brig
	engineering_override_eligible = TRUE

/area/station/security/checkpoint
	engineering_override_eligible = TRUE

/area/station/security/execution/transfer
	engineering_override_eligible = TRUE

/area/station/security/prison
	engineering_override_eligible = TRUE

/area/station/service
	engineering_override_eligible = TRUE

/area/station/science
	engineering_override_eligible = TRUE

/obj/machinery/door/airlock
	/// Determines if engineers get access to this door on orange alert
	var/engineering_override = FALSE
	/// If there is an active fire alarm in the door's area
	var/fire_active = FALSE
	/// Area the door is located in
	var/area/door_area

/obj/machinery/door/airlock/Initialize(mapload)
	. = ..()
	door_area = get_area(src)
	RegisterSignal(door_area, COMSIG_AREA_FIRE_CHANGED, PROC_REF(update_fire_status))
	RegisterSignal(SSdcs, COMSIG_GLOB_FORCE_ENG_OVERRIDE, PROC_REF(force_eng_override))

///Check for the three states of open access. Emergency, Unrestricted, and Engineering/Fire Override
/obj/machinery/door/airlock/allowed(mob/user)
	if(emergency)
		rapid_open()
		return TRUE

	if(unrestricted_side(user))
		rapid_open()
		return TRUE

	if(engineering_override || fire_active)
		var/mob/living/carbon/human/interacting_human = user
		if(!istype(interacting_human))
			return ..()

		var/obj/item/card/id/card = interacting_human.get_idcard(TRUE)
		if(ACCESS_ENGINEERING in card?.access)
			return TRUE

	return ..()

///When the signal is received of a changed security level, check if it's orange.
/obj/machinery/door/airlock/check_security_level(datum/source, level)
	. = ..()
	if(!door_area.engineering_override_eligible)
		return

	if(isnull(req_access) && isnull(req_one_access)) // no restrictions, no problem
		return

	if(level != SEC_LEVEL_ORANGE && GLOB.force_eng_override)
		return

	if(level == SEC_LEVEL_ORANGE)
		engineering_override = TRUE
		normalspeed = FALSE
		update_appearance()
		return

	engineering_override = FALSE
	if(!fire_active)
		normalspeed = TRUE

	update_appearance()
	return

///Manual override for when it's not orange alert.
GLOBAL_VAR_INIT(force_eng_override, FALSE)
/proc/toggle_eng_override()
	if(!GLOB.force_eng_override)
		GLOB.force_eng_override = TRUE
		minor_announce("Engineering staff will have expanded access to areas of the station during the emergency.", "Engineering Emergency")
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, TRUE)
		SSblackbox.record_feedback("nested tally", "keycard_auths", 1, list("engineer override access", "enabled"))
	else
		GLOB.force_eng_override = FALSE
		minor_announce("Expanded engineering access has been revoked.", "Engineering Emergency")
		var/level = SSsecurity_level.get_current_level_as_number()
		SSblackbox.record_feedback("nested tally", "keycard_auths", 1, list("engineer override access", "disabled"))
		if(level == SEC_LEVEL_ORANGE)
			return
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, FALSE)

/obj/machinery/door/airlock/proc/force_eng_override(datum/source, status)
	SIGNAL_HANDLER

	if(!door_area.engineering_override_eligible)
		return

	if(isnull(req_access) && isnull(req_one_access)) // no restrictions, no problem
		return

	engineering_override = status
	if(!engineering_override && !fire_active)
		normalspeed = TRUE
		update_appearance()
		return

	normalspeed = FALSE
	update_appearance()

/obj/machinery/door/airlock/proc/update_fire_status(datum/source, fire)
	SIGNAL_HANDLER

	if(!door_area.engineering_override_eligible)
		return

	if(isnull(req_access) && isnull(req_one_access)) // no restrictions, no problem
		return

	fire_active = fire
	if(!fire_active && !engineering_override)
		normalspeed = TRUE
		update_appearance()
		return

	normalspeed = FALSE
	update_appearance()
