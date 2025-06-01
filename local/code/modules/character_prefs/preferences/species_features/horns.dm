/datum/preference/choiced/proc/generate_side_icon(datum/sprite_accessory/sprite_accessory, key, include_snout = TRUE)
	var/static/datum/universal_icon/final_icon
	final_icon = uni_icon('local/icons/mob/mutant/sprite_accessories/fallback.dmi', null)

	if (!isnull(sprite_accessory) && (LOWER_TEXT(sprite_accessory.icon_state) != "none"))
		var/list/sprite_accessory_layers = SSaccessories.get_sprite_accessory_layers("[sprite_accessory.icon]")
		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_ADJ"))
			var/datum/universal_icon/accessory_icon_1 = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ", EAST)
			accessory_icon_1.blend_color(COLOR_EFFIGY_SKY_BLUE, ICON_MULTIPLY)
			final_icon.blend_icon(accessory_icon_1, ICON_OVERLAY)
		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_ADJ_2"))
			var/datum/universal_icon/accessory_icon_2 = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ_2", EAST)
			accessory_icon_2.blend_color(COLOR_EFFIGY_PLATINUM, ICON_MULTIPLY)
			final_icon.blend_icon(accessory_icon_2, ICON_OVERLAY)
		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_ADJ_3"))
			var/datum/universal_icon/accessory_icon_3 = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ_3", EAST)
			accessory_icon_3.blend_color(COLOR_EFFIGY_ELECTRIC_BLUE, ICON_MULTIPLY)
			final_icon.blend_icon(accessory_icon_3, ICON_OVERLAY)

	final_icon.crop(11, 20, 23, 32)
	final_icon.scale(32, 32)

	return final_icon

/obj/item/organ/horns
	name = "horns"

/datum/bodypart_overlay/mutant/horns
	layers = EXTERNAL_FRONT | EXTERNAL_FRONT_2 | EXTERNAL_FRONT_3 | EXTERNAL_ADJACENT | EXTERNAL_ADJACENT_2 | EXTERNAL_ADJACENT_3 | EXTERNAL_BEHIND | EXTERNAL_BEHIND_2 | EXTERNAL_BEHIND_3

/datum/bodypart_overlay/mutant/horns/color_image(image/overlay, draw_layer, obj/item/bodypart/limb)
	if(limb == null)
		return ..()
	if(limb.owner == null)
		return ..()
	if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT))
		overlay.color = limb.owner.dna.features["horns_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT))
		overlay.color = limb.owner.dna.features["horns_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_BEHIND))
		overlay.color = limb.owner.dna.features["horns_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT_2))
		overlay.color = limb.owner.dna.features["horns_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT_2))
		overlay.color = limb.owner.dna.features["horns_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_BEHIND_2))
		overlay.color = limb.owner.dna.features["horns_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT_3))
		overlay.color = limb.owner.dna.features["horns_color_3"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT_3))
		overlay.color = limb.owner.dna.features["horns_color_3"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_BEHIND_3))
		overlay.color = limb.owner.dna.features["horns_color_3"]
		return overlay
	return ..()

/// Horns toggle
/datum/preference/toggle/horns
	savefile_key = "horns_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_DEFAULT

/datum/preference/toggle/horns/apply_to_human(mob/living/carbon/human/target, value)
	if(value == FALSE)
		target.dna.features["horns"] = /datum/sprite_accessory/horns/none::name

/datum/preference/toggle/horns/create_default_value()
	return FALSE

/datum/preference/toggle/horns/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[HORNS]))
		return FALSE

	return TRUE

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()
	if(target.dna.features["horns"] && (type in GLOB.bodypart_allowed_species[HORNS]))
		if(target.dna.features["horns"] != /datum/sprite_accessory/horns/none::name && target.dna.features["horns"] != /datum/sprite_accessory/blank::name)
			var/obj/item/organ/replacement = SSwardrobe.provide_type(/obj/item/organ/horns)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
			return .
	var/obj/item/organ/old_part = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_HORNS)
	if(old_part)
		old_part.Remove(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		old_part.moveToNullspace()

/// Horn type
/datum/preference/choiced/lizard_horns
	category = PREFERENCE_CATEGORY_CLOTHING

/datum/preference/choiced/lizard_horns/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/horns_color::savefile_key
	return data

/datum/preference/choiced/lizard_horns/create_default_value()
	return /datum/sprite_accessory/horns/none::name

/datum/preference/choiced/lizard_horns/icon_for(value)
	return generate_side_icon(SSaccessories.horns_list[value], "horns")

/datum/preference/choiced/lizard_horns/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[HORNS]))
		return FALSE

	var/has_horns = preferences.read_preference(/datum/preference/toggle/horns)
	if(has_horns == TRUE)
		return TRUE

	return FALSE

/// Horn colors
/datum/preference/tri_color/horns_color
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "horns_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES

/datum/preference/tri_color/horns_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["horns_color_1"] = value[1]
	target.dna.features["horns_color_2"] = value[2]
	target.dna.features["horns_color_3"] = value[3]

/datum/preference/tri_color/horns_color/create_default_value()
	return list(sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"))

/datum/preference/tri_color/horns_color/is_valid(value)
	if (!..(value))
		return FALSE
	return TRUE
