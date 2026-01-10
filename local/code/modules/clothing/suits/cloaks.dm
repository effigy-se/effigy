/obj/item/clothing/neck/cloak/skill_reward/salvaging
	name = "legendary scrapper's cloak"
	desc = "Worn by the most skilled scrappers, this legendary cloak is only attainable by achieving \"salvage ascension\". This status symbol represents one who knows the value of even the most subtle treasures."
	icon = 'local/icons/obj/clothing/cloaks.dmi'
	icon_state = "scrappercloak"
	worn_icon = 'local/icons/mob/clothing/neck.dmi'
	associated_skill_path = /datum/skill/salvaging

/obj/item/clothing/neck/robe_cape
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape
	name = "long cape"
	desc = "A graceful cloak that carefully surrounds your body."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/long_cape"
	post_init_icon_state = "long_cape"
	greyscale_config = /datum/greyscale_config/long_cape
	greyscale_config_worn = /datum/greyscale_config/long_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/long_cape, infinite = TRUE)

/datum/atom_skin/long_cape
	abstract_type = /datum/atom_skin/long_cape
	greyscale_item_path = /obj/item/clothing/neck/long_cape
	reset_missing = FALSE

/datum/atom_skin/long_cape/default
	preview_name = "Default"
	new_icon_state = "long_cape"

/datum/atom_skin/long_cape/adjusted
	preview_name = "Adjusted"
	new_icon_state = "long_cape_t"

/obj/item/clothing/neck/wide_cape
	name = "wide cape"
	desc = "A proud, broad-shouldered cloak with which you can protect the honor of your back."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/wide_cape"
	post_init_icon_state = "wide_cape"
	greyscale_config = /datum/greyscale_config/wide_cape
	greyscale_config_worn = /datum/greyscale_config/wide_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS
