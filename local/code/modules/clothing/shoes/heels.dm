/obj/item/clothing/shoes/fancy_heels
	name = "high heels"
	desc = "A pair of fancy high heels that are much smaller on your feet."
	icon_state = "fancyheels"
	icon = 'local/icons/obj/clothing/shoes.dmi'
	worn_icon = 'local/icons/mob/clothing/feet.dmi'
	greyscale_colors = "#FFFFFF"
	greyscale_config = /datum/greyscale_config/fancyheels
	greyscale_config_worn = /datum/greyscale_config/fancyheels/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config_worn_bodyshapes = list(
		BODYSHAPE_HUMANOID_T = /datum/greyscale_config/fancyheels/worn,
		BODYSHAPE_DIGITIGRADE_T = /datum/greyscale_config/fancyheels/worn/digi,
	)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'local/icons/mob/clothing/feet.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/mob/clothing/feet_digi.dmi',
	)

/obj/item/clothing/shoes/fancy_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('local/sound/effects/highheel1.ogg' = 1, 'local/sound/effects/highheel2.ogg' = 1), 50)
