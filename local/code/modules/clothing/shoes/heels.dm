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
	supported_bodyshapes = list(
		BODYSHAPE_HUMANOID,
		BODYSHAPE_DIGITIGRADE
	)
	greyscale_config_worn_bodyshapes = list(
		BODYSHAPE_HUMANOID_T = /datum/greyscale_config/fancyheels/worn,
		BODYSHAPE_DIGITIGRADE_T = /datum/greyscale_config/fancyheels/worn/digi,
	)

/obj/item/clothing/shoes/fancy_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('local/sound/effects/highheel1.ogg' = 1, 'local/sound/effects/highheel2.ogg' = 1), 50)
