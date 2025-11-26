
/datum/quirk/felinid_traits
	name = "Felinid Traits"
	desc = "Nya! For whatever reason, you seem to act like a felinid - you must mggaow."
	gain_text = span_notice("Nya could go for some catnip right about now...")
	lose_text = span_notice("You feel less attracted to lasers.")
	medical_record_text = "Patient seems to be easily distracted by laser pointers."
	mob_trait = TRAIT_FELINID
	icon = FA_ICON_CAT

/datum/quirk/felinid_traits/is_species_appropriate(datum/species/mob_species)
	if(ispath(mob_species, /datum/species/animalid))
		return TRUE

	if(ispath(mob_species, /datum/species/synth))
		return TRUE

	return FALSE
