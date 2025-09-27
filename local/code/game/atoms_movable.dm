/atom/movable
	// Text-to-blooper sounds
	// yes. all atoms can have a say.
	var/datum/blooper/blooper
	var/blooper_id
	var/blooper_pitch = 1
	var/blooper_pitch_range = 0.2 //Actual pitch is (pitch - (blooper_pitch_range*0.5)) to (pitch + (blooper_pitch_range*0.5))
	var/blooper_volume = 70
	var/blooper_speed = 4 //Lower values are faster, higher values are slower
	COOLDOWN_DECLARE(blooper_cooldown)

/atom/movable/Destroy(force)
	blooper = null
	. = ..()
