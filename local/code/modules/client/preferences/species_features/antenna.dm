/// Synth antenna color
/datum/preference/tri_color/ipc_antenna_color
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "ipc_antenna_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES

/datum/preference/tri_color/ipc_antenna_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ipc_antenna_color_1"] = value[1]
	target.dna.features["ipc_antenna_color_2"] = value[2]
	target.dna.features["ipc_antenna_color_3"] = value[3]

/datum/preference/tri_color/ipc_antenna_color/create_default_value()
	return list(sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"))

/datum/preference/tri_color/ipc_antenna_color/is_valid(value)
	if (!..(value))
		return FALSE

	return TRUE
