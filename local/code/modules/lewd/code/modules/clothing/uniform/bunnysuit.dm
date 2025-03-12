/obj/item/clothing/under/costume/bunnylewd
	name = "bunny suit"
	desc = "A pin-up staple."
	icon = 'local/icons/lewd/obj/clothing/uniform.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/uniform.dmi'
	icon_state = "bunnysuit"
	greyscale_colors = "#383840#FFFFFF"
	greyscale_config = /datum/greyscale_config/bunnysuitlewd
	greyscale_config_worn = /datum/greyscale_config/bunnysuitlewd/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN
	can_adjust = TRUE
	alt_covers_chest = FALSE

/obj/item/clothing/under/costume/bunnylewd/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
