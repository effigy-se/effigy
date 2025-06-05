/obj/item/organ/tongue/speaker
	name = "speaker"
	desc = "A speaker. Used for emitting sounds."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/tongue/speaker/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/mob/living/carbon/human/robot = owner
	if(!istype(robot))
		return
	var/obj/item/organ/brain/cybernetic/robot_brain = robot.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	if(robot_brain.power <= 5)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering speaker to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (0.0125 * seconds_per_tick) * robot_brain.temperature_disparity
	robot_brain.run_updates()

/obj/item/organ/tongue/speaker/modify_speech(datum/source, list/speech_args)
	var/chance_of_replacement = ((damage / maxHealth) * 100)
	if(organ_flags & ORGAN_DEPOWERED)
		chance_of_replacement = 100 // can't hear SHIT without power
	if(chance_of_replacement)
		var/message = speech_args[SPEECH_MESSAGE]
		var/list/possible_words_to_replace = splittext_char(message, " ")
		for(var/word in 1 to length(possible_words_to_replace))
			if(prob(chance_of_replacement))
				var/list/new_word = list()
				for(var/i in 1 to length(possible_words_to_replace[word]))
					new_word += "█"
				possible_words_to_replace[word] = jointext(new_word, "")
		message = jointext(possible_words_to_replace, " ")
		speech_args[SPEECH_MESSAGE] = message
