/obj/item/clothing/shoes/sandal
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	supported_bodyshapes = list(
		BODYSHAPE_HUMANOID,
		BODYSHAPE_DIGITIGRADE
	)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'icons/mob/clothing/feet.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/mob/clothing/feet_digi.dmi',
	)

/// No icon state in worn_icons for this; generate an approximation
/obj/item/clothing/shoes/sandal/alt
	supports_variations_flags = CLOTHING_DIGITIGRADE_MASK

/obj/item/clothing/shoes/sandal/alt/generate_digitigrade_icons(icon/base_icon, greyscale_colors)
	return icon(SSgreyscale.GetColoredIconByType(/datum/greyscale_config/digitigrade/sandals/worn, greyscale_colors), "sneakers_worn")
