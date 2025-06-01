/obj/item/organ/heart/oil_pump
	name = "oil pump"
	desc = "Pumps oil around the chassis. You can't replace the oil in a robot without it!"
	organ_flags = ORGAN_ROBOTIC
	var/list/lubricants = list( // What chemicals will satisfy the oil requirement to lube up the joints?
		/datum/reagent/fuel/oil = 1,
		/datum/reagent/lube = 2,
		/datum/reagent/lube/superlube = 3,
	)
	var/list/lubricant_types = list(
		/datum/reagent/fuel/oil,
		/datum/reagent/lube,
		/datum/reagent/lube/superlube,
	)

/obj/item/organ/heart/oil_pump/on_mob_insert(mob/living/carbon/heart_owner, special, movement_flags)
	. = ..()
	RegisterSignal(heart_owner, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(on_expose))

/obj/item/organ/heart/oil_pump/on_mob_remove(mob/living/carbon/heart_owner, special, movement_flags)
	UnregisterSignal(heart_owner, COMSIG_ATOM_EXPOSE_REAGENTS)
	. = ..()

/obj/item/organ/heart/oil_pump/proc/on_expose(atom/target, list/applied_reagents, datum/reagents/source, methods)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/robot = target
	if(!istype(robot))
		return
	var/obj/item/organ/brain/cybernetic/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	if(!(methods & (TOUCH|VAPOR)))
		return
	var/did_lubrication = FALSE
	for(var/datum/reagent/bit as anything in applied_reagents)
		if(is_type_in_list(bit, lubricant_types))
			robot.blood_volume += lubricants[bit.type] * applied_reagents[bit]
			did_lubrication = TRUE
	if(did_lubrication)
		robot.balloon_alert(robot, "lubricated")
	robot_brain.run_updates()

/obj/item/organ/heart/oil_pump/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/brain/cybernetic/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	if(robot_brain.power <= 20)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= 0.025 * seconds_per_tick
	robot_brain.run_updates()
