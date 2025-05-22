/datum/emote/living/carbon/human/scream/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.selected_scream)
		return user.dna.species.get_scream_sound(user)
	return pick(user.selected_scream.scream_sounds)
