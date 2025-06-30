/obj/item/organ/appendix/random_number_database
	name = "random number database"
	desc = "The work is mysterious and important."
	organ_flags = ORGAN_ROBOTIC
	var/random_number = 69
	var/max_number = 10000

/obj/item/organ/appendix/random_number_database/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/brain/cybernetic/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	if(robot_brain.power <= 50)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering random number database to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (0.0125 * seconds_per_tick) * robot_brain.temperature_disparity
	var/chosen_number = rand(1, max_number)
	if(chosen_number == random_number)
		say("Account complete! Thank you for contributing to the work. Complimentary power will now be distributed.")
		robot_brain.power += 25
		random_number = rand(1, max_number)
	robot_brain.run_updates()
