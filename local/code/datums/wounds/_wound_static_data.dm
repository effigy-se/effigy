/datum/wound_pregen_data/blunt_metal
	abstract = TRUE
	required_limb_biostate = BIO_METAL
	wound_series = WOUND_SERIES_METAL_BLUNT_BASIC
	required_wounding_type = WOUND_BLUNT

/datum/wound_pregen_data/blunt_metal/generate_scar_priorities()
	return list("[BIO_METAL]")

/datum/wound_pregen_data/burnt_metal
	abstract = TRUE
	required_limb_biostate = BIO_METAL
	required_wounding_type = WOUND_BURN
	wound_series = WOUND_SERIES_METAL_BURN_OVERHEAT

/datum/wound_pregen_data/burnt_metal/generate_scar_priorities()
	return list("[BIO_METAL]")
