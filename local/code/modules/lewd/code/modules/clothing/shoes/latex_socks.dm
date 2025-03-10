/obj/item/clothing/shoes/latex_socks
	name = "latex socks"
	desc = "A pair of shiny, split-toe socks made of some strange material."
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "latex_socks"
	icon = 'local/icons/lewd/obj/clothing/shoes.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/shoes.dmi'
	greyscale_colors = "#383840"
	greyscale_config = /datum/greyscale_config/latex_socks
	greyscale_config_worn = /datum/greyscale_config/latex_socks/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config_worn_bodyshapes = list(
		BODYSHAPE_HUMANOID_T = /datum/greyscale_config/latex_socks/worn,
		BODYSHAPE_DIGITIGRADE_T = /datum/greyscale_config/latex_socks/worn/digi,
	)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'local/icons/lewd/mob/clothing/shoes.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/lewd/mob/clothing/shoes_digi.dmi',
	)

/obj/item/clothing/shoes/latex_socks/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
