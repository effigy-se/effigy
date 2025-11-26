/datum/quirk/excitable
	name = "Excitable!"
	desc = "Head patting makes your tail wag! You're very excitable! WAG WAG."
	gain_text = span_notice("You crave for some headpats!")
	lose_text = span_notice("You no longer care for headpats all that much.")
	medical_record_text = "Patient seems to get excited easily."
	value = 0
	//mob_trait = TRAIT_EXCITABLE
	icon = FA_ICON_LAUGH_BEAM

/datum/quirk/excitable/is_species_appropriate(datum/species/mob_species)
	if(ispath(mob_species, /datum/species/animalid))
		return TRUE

	if(ispath(mob_species, /datum/species/lizard))
		return TRUE

	if(ispath(mob_species, /datum/species/insectoid))
		return TRUE

	if(ispath(mob_species, /datum/species/synth))
		return TRUE

	return FALSE
