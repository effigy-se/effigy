/obj/item/organ/liver/cleaning_filter
	name = "cleaning filter"
	desc = "Filters unwanted liquids out of the robot. Doesn't handle toxic material very well. Keep powered to avoid damage to internal components."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/liver/cleaning_filter/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick, times_fired)
	. = ..()
	if(organ_flags & ORGAN_FAILING || organ_flags & ORGAN_DEPOWERED)
		var/obj/item/organ/brain/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(!robot_brain || !istype(robot_brain))
			apply_organ_damage(2)
			organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
			return COMSIG_MOB_STOP_REAGENT_CHECK
		robot_brain.apply_organ_damage(2)
		organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
		return COMSIG_MOB_STOP_REAGENT_CHECK
	var/obj/item/organ/lungs/fans = owner.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!fans || !istype(fans))
		var/obj/item/organ/brain/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(!robot_brain || !istype(robot_brain))
			apply_organ_damage(2)
			organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
			return COMSIG_MOB_STOP_REAGENT_CHECK
		robot_brain.apply_organ_damage(2)
		organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
		return COMSIG_MOB_STOP_REAGENT_CHECK
	if(istype(chem, /datum/reagent/toxin))
		fans.apply_organ_damage(1 + (1 * (damage / maxHealth)))
	organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
	return COMSIG_MOB_STOP_REAGENT_CHECK

/obj/item/organ/liver/cleaning_filter/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/brain/cybernetic/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	if(robot_brain.power <= 25)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering cleaning filter to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (0.0125 * seconds_per_tick) * robot_brain.temperature_disparity
	robot_brain.run_updates()
