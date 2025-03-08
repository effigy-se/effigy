/// were it not for connotation this wouldn't even be in with these items tbh
/obj/item/storage/belt/thigh_satchel
	name = "thigh satchel"
	desc = "A little satchel that goes on your thigh! Aesthetically holds a few adult toys."
	icon = 'local/icons/lewd/obj/clothing/belt.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/belt.dmi'
	icon_state = "thighsatchel"
	worn_icon_state = "thighsatchel"
	greyscale_colors = "#383840#383840#d1d3e0"
	greyscale_config = /datum/greyscale_config/thighsatchel
	greyscale_config_worn = /datum/greyscale_config/thighsatchel/worn
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/storage/belt/thigh_satchel/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 21
	atom_storage.set_holdable(list(
		/obj/item/clothing/neck/collar,
		/obj/item/clothing/erp_leash
	))
