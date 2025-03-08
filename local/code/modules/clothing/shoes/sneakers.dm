/obj/item/clothing/shoes/sneakers
	greyscale_config_worn_bodyshapes = list(
		BODYSHAPE_HUMANOID_T = /datum/greyscale_config/sneakers/worn,
		BODYSHAPE_DIGITIGRADE_T = /datum/greyscale_config/digitigrade/sneakers/worn,
	)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'icons/mob/clothing/feet.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/mob/clothing/feet_digi.dmi',
	)

/obj/item/clothing/shoes/sneakers/generate_digitigrade_icons(icon/base_icon, greyscale_colors)
	return icon(SSgreyscale.GetColoredIconByType(/datum/greyscale_config/digitigrade/sneakers/worn, greyscale_colors), "sneakers_worn")
