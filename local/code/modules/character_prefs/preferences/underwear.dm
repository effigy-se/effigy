/proc/generate_under_icon(datum/sprite_accessory/sprite_accessory, datum/universal_icon/base_icon, color, icon_offset = 0)
	var/static/datum/universal_icon/final_icon
	final_icon = uni_icon('local/icons/mob/mutant/sprite_accessories/fallback.dmi', null)

	if (!isnull(sprite_accessory) && (LOWER_TEXT(sprite_accessory.icon_state) != "nude"))
		var/list/sprite_accessory_layers = SSaccessories.get_sprite_accessory_layers("[sprite_accessory.icon]")
		if(sprite_accessory_layers.Find("[sprite_accessory.icon_state]"))
			var/datum/universal_icon/accessory_icon_1 = uni_icon(sprite_accessory.icon, "[sprite_accessory.icon_state]")
			if (color && !sprite_accessory.use_static)
				accessory_icon_1.blend_color(color, ICON_MULTIPLY)
			final_icon.blend_icon(accessory_icon_1, ICON_OVERLAY)

	final_icon.crop(10, 1 + icon_offset, 22, 13 + icon_offset)
	final_icon.scale(32, 32)

	return final_icon

/// SSAccessories setup
/datum/controller/subsystem/accessories
	var/list/bra_list
	var/list/bra_m
	var/list/bra_f

/datum/controller/subsystem/accessories/setup_lists()
	. = ..()
	var/bra_lists = init_sprite_accessory_subtypes(/datum/sprite_accessory/clothing/bra)
	bra_list = bra_lists["default_sprites"]
	bra_m = bra_lists["male_sprites"]
	bra_f = bra_lists["female_sprites"]

/datum/outfit
	/// Underwear and bras are separated
	var/datum/sprite_accessory/clothing/bra = null

/datum/preference/choiced/socks/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "socks_color"

	return data

/datum/preference/choiced/socks/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/undershirt/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "undershirt_color"

	return data

/datum/preference/choiced/undershirt/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/underwear/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/bra
	savefile_key = "bra"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "Bra"
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE

/datum/preference/choiced/bra/init_possible_values()
	return assoc_to_keys_features(SSaccessories.bra_list)

/datum/preference/choiced/bra/icon_for(value)
	var/static/datum/universal_icon/body
	if (isnull(body))
		body = uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_arm")
		body.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_arm"), ICON_OVERLAY)
		body.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_hand"), ICON_OVERLAY)
		body.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_hand"), ICON_OVERLAY)
		body.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_chest_m"), ICON_OVERLAY)

	var/datum/universal_icon/icon_with_bra = body.copy()

	if (value != "Nude")
		var/datum/sprite_accessory/clothing/bra/accessory = SSaccessories.bra_list[value]
		icon_with_bra.blend_icon(uni_icon(accessory.icon, accessory.icon_state), ICON_OVERLAY)

	icon_with_bra.crop(10, 11, 22, 23)
	icon_with_bra.scale(32, 32)
	return icon_with_bra

/datum/preference/choiced/bra/apply_to_human(mob/living/carbon/human/target, value)
	target.bra = value

/datum/preference/choiced/bra/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "bra_color"

	return data

/datum/preference/choiced/bra/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/bra/create_informed_default_value(datum/preferences/preferences)
	if(preferences.read_preference(/datum/preference/choiced/gender) == FEMALE)
		return /datum/sprite_accessory/clothing/bra/sports_bra::name
	return /datum/sprite_accessory/clothing/bra/nude::name
