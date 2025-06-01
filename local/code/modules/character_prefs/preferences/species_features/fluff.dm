/datum/preference/choiced/proc/generate_neck_icon(datum/sprite_accessory/sprite_accessory, key)
	var/static/datum/universal_icon/final_icon
	final_icon = uni_icon('local/icons/mob/mutant/sprite_accessories/fallback.dmi', null)

	if (!isnull(sprite_accessory) && (LOWER_TEXT(sprite_accessory.icon_state) != "none"))
		var/list/sprite_accessory_layers = SSaccessories.get_sprite_accessory_layers("[sprite_accessory.icon]")
		if(sprite_accessory_layers.Find("m_[key]_[sprite_accessory.icon_state]_ADJ"))
			var/datum/universal_icon/accessory_icon_1 = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ", EAST)
			accessory_icon_1.blend_color(COLOR_EFFIGY_SKY_BLUE, ICON_MULTIPLY)
			final_icon.blend_icon(accessory_icon_1, ICON_OVERLAY)

	return final_icon

/// Fluff toggle
/datum/preference/toggle/fluff
	savefile_key = "fluff_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_DEFAULT

/datum/preference/toggle/fluff/apply_to_human(mob/living/carbon/human/target, value)
	if(value == FALSE)
		target.dna.features["fluff"] = /datum/sprite_accessory/fluff/none::name

/datum/preference/toggle/fluff/create_default_value()
	return FALSE

/datum/preference/toggle/fluff/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FLUFF]))
		return FALSE

	return TRUE

/// Fluff type
/datum/preference/choiced/fluff
	savefile_key = "fluff"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_CLOTHING
	relevant_external_organ = null
	should_generate_icons = TRUE
	main_feature_name = "Fluff"

/datum/preference/choiced/fluff/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["fluff"] = value

/datum/preference/choiced/fluff/create_default_value()
	return /datum/sprite_accessory/fluff/none::name

/datum/preference/choiced/fluff/icon_for(value)
	return generate_neck_icon(SSaccessories.horns_list[value], "fluff")

/datum/preference/choiced/fluff/init_possible_values()
	return assoc_to_keys_features(SSaccessories.fluff_list)

/datum/preference/choiced/fluff/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!(species.type in GLOB.bodypart_allowed_species[FLUFF]))
		return FALSE

	var/has_fluff = preferences.read_preference(/datum/preference/toggle/fluff)
	if(has_fluff)
		return TRUE

	return FALSE

/datum/controller/subsystem/accessories
	var/list/fluff_list

/datum/controller/subsystem/accessories/setup_lists()
	. = ..()
	fluff_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/fluff)["default_sprites"] // FLAKY DEFINE: this should be using DEFAULT_SPRITE_LIST

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()
	if(target.dna.features["fluff"] && (type in GLOB.bodypart_allowed_species[FLUFF]))
		if(target.dna.features["fluff"] != /datum/sprite_accessory/fluff/none::name && target.dna.features["fluff"] != /datum/sprite_accessory/blank::name)
			var/obj/item/organ/replacement = SSwardrobe.provide_type(/obj/item/organ/fluff)
			replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
			return .
	var/obj/item/organ/old_part = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_FLUFF)
	if(old_part)
		old_part.Remove(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		old_part.moveToNullspace()

/datum/bodypart_overlay/mutant/fluff
	layers = EXTERNAL_FRONT | EXTERNAL_FRONT_2 | EXTERNAL_FRONT_3 | EXTERNAL_ADJACENT | EXTERNAL_ADJACENT_2 | EXTERNAL_ADJACENT_3
	feature_key_sprite = "fluff"

/datum/bodypart_overlay/mutant/fluff/color_image(image/overlay, draw_layer, obj/item/bodypart/limb)
	if(limb == null)
		return ..()
	if(limb.owner == null)
		return ..()
	if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT))
		overlay.color = limb.owner.dna.features["fluff_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT))
		overlay.color = limb.owner.dna.features["fluff_color_1"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT_2))
		overlay.color = limb.owner.dna.features["fluff_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT_2))
		overlay.color = limb.owner.dna.features["fluff_color_2"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_FRONT_3))
		overlay.color = limb.owner.dna.features["fluff_color_3"]
		return overlay
	else if(draw_layer == bitflag_to_layer(EXTERNAL_ADJACENT_3))
		overlay.color = limb.owner.dna.features["fluff_color_3"]
		return overlay
	return ..()

/// Fluff colors
/datum/preference/tri_color/fluff_color
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "fluff_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES

/datum/preference/tri_color/fluff_color/create_default_value()
	return list(sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"),
	sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"))

/datum/preference/tri_color/fluff_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["fluff_color_1"] = value[1]
	target.dna.features["fluff_color_2"] = value[2]
	target.dna.features["fluff_color_3"] = value[3]

/datum/preference/tri_color/fluff_color/is_valid(value)
	if (!..(value))
		return FALSE

	return TRUE

/datum/preference/choiced/fluff/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = /datum/preference/tri_color/fluff_color::savefile_key
	return data
