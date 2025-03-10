/// Sprite doesn't visually represent the verticality correctly but the description at time of port implied this was the 'intended' item?? idk. just going with it
/obj/item/clothing/shoes/ballet_heels
	name = "ballet heels"
	desc = "Restrictive, knee-high heels. Unfathomably difficult to walk in."
	icon_state = "balletheels"
	icon = 'local/icons/lewd/obj/clothing/shoes.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/shoes.dmi'
	greyscale_colors = "#383840"
	greyscale_config = /datum/greyscale_config/ballet_heel
	greyscale_config_worn = /datum/greyscale_config/ballet_heel/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config_worn_bodyshapes = list(
		BODYSHAPE_HUMANOID_T = /datum/greyscale_config/ballet_heel/worn,
		BODYSHAPE_DIGITIGRADE_T = /datum/greyscale_config/ballet_heel/worn/digi,
	)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'local/icons/lewd/mob/clothing/shoes.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/lewd/mob/clothing/shoes_digi.dmi',
	)

/obj/item/clothing/shoes/ballet_heels/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
	AddComponent(/datum/component/squeak, list('local/sound/effects/highheel1.ogg' = 1, 'local/sound/effects/highheel2.ogg' = 1), 70)
