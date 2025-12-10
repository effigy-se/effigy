/obj/item/clothing/head/small_bow
	name = "small bow"
	desc = "A small compact bow that you can place on the side of your hair."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/small_bow"
	post_init_icon_state = "small_bow"
	greyscale_config = /datum/greyscale_config/small_bow
	greyscale_config_worn = /datum/greyscale_config/small_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/small_bow/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/small_bow, infinite = TRUE)

/datum/atom_skin/small_bow
	abstract_type = /datum/atom_skin/small_bow
	reset_missing = FALSE

/datum/atom_skin/small_bow/right
	preview_name = "Right-Side"
	new_icon_state = "small_bow"

/datum/atom_skin/small_bow/left
	preview_name = "Left-Side"
	new_icon_state = "small_bow_t"

/obj/item/clothing/head/large_bow
	name = "large bow"
	desc = "A large bow that you can place on top of your head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/large_bow"
	post_init_icon_state = "large_bow"
	greyscale_config = /datum/greyscale_config/large_bow
	greyscale_config_worn = /datum/greyscale_config/large_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/back_bow
	name = "back bow"
	desc = "A large bow that you can place on the back of your head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/back_bow"
	post_init_icon_state = "back_bow"
	greyscale_config = /datum/greyscale_config/back_bow
	greyscale_config_worn = /datum/greyscale_config/back_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/sweet_bow
	name = "sweet bow"
	desc = "A sweet bow that you can place on the back of your head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/sweet_bow"
	post_init_icon_state = "sweet_bow"
	greyscale_config = /datum/greyscale_config/sweet_bow
	greyscale_config_worn = /datum/greyscale_config/sweet_bow/worn
	greyscale_colors = "#7b9ab5"
	flags_1 = IS_PLAYER_COLORABLE_1
