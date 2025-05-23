/datum/emote/living/carbon/human/scream/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.selected_scream)
		return user.dna.species.get_scream_sound(user)
	return pick(user.selected_scream.scream_sounds)

/datum/emote/living/laugh/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.selected_laugh)
		return user.dna.species.get_laugh_sound(user)
	return pick(user.selected_laugh.laugh_sounds)

/datum/emote/living/carbon/human/dap
	targets_person = TRUE

/datum/emote/living/carbon/human/handshake
	targets_person = TRUE

/datum/emote/living/carbon/human/hug
	targets_person = TRUE

/datum/emote/living/carbon/human/salute
	targets_person = TRUE
