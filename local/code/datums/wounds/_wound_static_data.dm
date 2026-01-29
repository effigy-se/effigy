/datum/wound_pregen_data/blunt_metal
	abstract = TRUE
	required_limb_biostate = BIO_METAL
	wound_series = WOUND_SERIES_METAL_BLUNT_BASIC
	required_wounding_type = WOUND_BLUNT

/datum/wound_pregen_data/blunt_metal/generate_scar_priorities()
	return list("[BIO_METAL]")

/datum/wound_pregen_data/blunt_metal/loose_screws
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/moderate
	viable_zones = list(BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	threshold_minimum = 30

/datum/wound_pregen_data/blunt_metal/fastenings
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/severe
	threshold_minimum = 65

/datum/wound_pregen_data/blunt_metal/superstructure
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/critical
	threshold_minimum = 125

/datum/wound_pregen_data/burnt_metal
	abstract = TRUE
	required_limb_biostate = BIO_METAL
	required_wounding_type = WOUND_BURN
	wound_series = WOUND_SERIES_METAL_BURN_OVERHEAT

/datum/wound_pregen_data/burnt_metal/generate_scar_priorities()
	return list("[BIO_METAL]")

/datum/wound_pregen_data/electrical_damage
	abstract = TRUE
	required_limb_biostate = (BIO_WIRED)
	required_wounding_type = WOUND_SLASH
	wound_series = WOUND_SERIES_WIRE_SLASH_ELECTRICAL_DAMAGE

/datum/wound_pregen_data/electrical_damage/generate_scar_priorities()
	return list("[BIO_METAL]") // wire scars dont exist so we can just use metal

/datum/wound_pregen_data/electrical_damage/slash/moderate
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/slash/moderate
	threshold_minimum = 35

/datum/wound_pregen_data/electrical_damage/slash/severe
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/slash/severe
	threshold_minimum = 60

/datum/wound_pregen_data/electrical_damage/slash/critical
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/slash/critical
	threshold_minimum = 100

/datum/wound_pregen_data/electrical_damage/pierce
	abstract = TRUE
	wound_series = WOUND_SERIES_WIRE_PIERCE_ELECTRICAL_DAMAGE
	required_wounding_type = WOUND_PIERCE

/datum/wound_pregen_data/electrical_damage/pierce/moderate
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/moderate
	threshold_minimum = 40

/datum/wound_pregen_data/electrical_damage/pierce/severe
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/severe
	threshold_minimum = 60

/datum/wound_pregen_data/electrical_damage/pierce/critical
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/critical
	threshold_minimum = 110
