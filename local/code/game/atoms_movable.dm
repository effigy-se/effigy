/atom/movable
	// Text-to-blooper sounds
	// yes. all atoms can have a say.
	var/datum/blooper/blooper
	var/blooper_speed = 4 //Lower values are faster, higher values are slower
	var/blooper_pitch = 1
	var/blooper_pitch_range = 0.2 //Actual pitch is (pitch - (blooper_pitch_range*0.5)) to (pitch + (blooper_pitch_range*0.5))
	COOLDOWN_DECLARE(blooper_cooldown)

/atom/movable/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language, list/message_mods = list(), forced = FALSE, tts_message, list/tts_filter)
	. = ..()
	if(!blooper)
		return
	var/list/listeners = get_hearers_in_view(range, source)
	for(var/mob/target_mob in listeners)
		if(!target_mob.client)
			continue
		if(!(target_mob.client?.prefs.read_preference(/datum/preference/toggle/hear_blooper)))
			listeners -= target_mob
	blooper.play_bloop(source, listeners, message, range, BLOOPER_TRANSMIT_VOLUME, blooper_speed, blooper_pitch, blooper_pitch_range)
