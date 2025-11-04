// Catnip
/datum/reagent/pax/catnip
	name = "Catnip"
	taste_description = "grass"
	description = "A colourless liquid that makes people more peaceful and felines happier."
	metabolization_rate = 1.75 * REAGENTS_METABOLISM

/datum/reagent/pax/catnip/on_mob_life(mob/living/carbon/carbon_mob)
	if(isfelinid(carbon_mob))
		if(prob(20))
			carbon_mob.emote("nya")
		if(prob(20))
			to_chat(carbon_mob, span_notice("[pick("Headpats feel nice.", "Backrubs would be nice.", "Mew")]"))
	else
		to_chat(carbon_mob, span_notice("[pick("I feel oddly calm.", "I feel relaxed.", "Mew?")]"))
	..()

// Synth Misc Reagents
/datum/reagent/serotrotium/synth
	name = "5HT-EMU.EXE"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/serotrotium/synth)

/datum/reagent/impedrezene/synth
	name = "puppybrain.dll"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/impedrezene/synth)
