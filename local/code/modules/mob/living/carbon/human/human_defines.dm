/mob/living/carbon/human
	/// The Examine Panel datum for the mob
	var/datum/examine_panel/mob_examine_panel
	/// Chance for oversized to wound someone smaller, if they try to piggyback ride them.
	var/oversized_piggywound_chance = 50
	/// Base damage for oversized piggyback riding.
	var/oversized_piggydam = 25
	/// Paralyze time for oversized piggyback riding in deciseconds. (10 deciseconds = 1 second)
	var/oversized_piggyknock = 3 SECONDS
