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
	/// Keep this alphabetical or I swear to god
	atom_storage.set_holdable(list(
		/obj/item/clothing/ears/dorms_headphones,
		/obj/item/clothing/erp_leash,
		/obj/item/clothing/glasses/blindfold/dorms,
		/obj/item/clothing/glasses/hypno,
		/obj/item/clothing/gloves/ball_mittens,
		/obj/item/clothing/head/deprivation_helmet,
		/obj/item/clothing/head/domina_cap,
		/obj/item/clothing/mask/ballgag,
		/obj/item/clothing/mask/gas/dorms_mask,
		/obj/item/clothing/neck/collar,
		/obj/item/clothing/shoes/ballet_heels,
		/obj/item/clothing/shoes/latex_socks,
		/obj/item/clothing/suit/straight_jacket/shackles,
		/obj/item/stack/shibari_rope,
	))
