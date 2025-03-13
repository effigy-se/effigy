/obj/item/clothing/under/dress/short_dress
	name = "short dress"
	desc = "An extremely short dress with a lovely sash and flower - only for those with good self-confidence."
	icon_state = "short_dress"
	greyscale_config = /datum/greyscale_config/short_dress
	greyscale_config_worn = /datum/greyscale_config/short_dress/worn
	greyscale_colors = "#ff3636#363030"
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/dress/strapless
	name = "strapless dress"
	desc = "Typical formal wear with no straps, instead opting to be tied at the waist. Most likely will need constant adjustments."
	icon_state = "dress_strapless"
	body_parts_covered = CHEST|GROIN|LEGS
	greyscale_config = /datum/greyscale_config/strapless_dress
	greyscale_config_worn = /datum/greyscale_config/strapless_dress/worn
	greyscale_colors = "#cc0000#5f5f5f"
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/dress/skirt/turtleskirt_knit // Essentially the same as the Turtleneck Skirt but with a knitted texture akin to the skirt
	name = "cableknit skirt"
	desc = "A casual turtleneck skirt, with a cableknit pattern."
	icon_state = "turtleskirt_knit"
	custom_price = PAYCHECK_CREW
	greyscale_config = /datum/greyscale_config/turtleskirt_knit
	greyscale_config_worn = /datum/greyscale_config/turtleskirt_knit/worn
	greyscale_colors = "#cc0000#5f5f5f"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = TRUE
	alt_covers_chest = TRUE


/obj/item/clothing/under/dress/skirt/jean
	name = "jean skirt"
	desc = "Technically, is there much difference between these and jorts? It's just one big hole instead of two. Does that make this a jirt?"
	icon_state = "jean_skirt"
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/jean_skirt
	greyscale_config_worn = /datum/greyscale_config/jean_skirt/worn
	greyscale_colors = "#787878#723E0E#4D7EAC"
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/dress/skirt/lone_skirt
	name = "skirt"
	desc = "A skirt, all on it's lonesome."
	icon_state = "lone_skirt"
	body_parts_covered = GROIN
	greyscale_config = /datum/greyscale_config/lone_skirt
	greyscale_config_worn = /datum/greyscale_config/lone_skirt/worn
	greyscale_colors = "#5f534a"
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/dress/skirt/medium
	name = "medium skirt"
	desc = "An appealing medium-length skirt. Top not included."
	icon_state = "medium_skirt"
	body_parts_covered = GROIN
	greyscale_config = /datum/greyscale_config/medium_skirt
	greyscale_config_worn = /datum/greyscale_config/medium_skirt/worn
	greyscale_colors = "#3a3c45"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/dress/skirt/long
	name = "long skirt"
	desc = "An appealing long skirt. At this point, does it qualify as a dress?"
	icon_state = "long_skirt"
	body_parts_covered = GROIN|LEGS
	greyscale_config = /datum/greyscale_config/long_skirt
	greyscale_config_worn = /datum/greyscale_config/long_skirt/worn
	greyscale_colors = "#3a3c45"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	alternate_worn_layer = ABOVE_SHOES_LAYER
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/under/dress/wedding_dress
	icon_state = "wedding_dress"
	icon = 'local/icons/obj/clothing/under/skirts_dresses.dmi'
	worn_icon = 'local/icons/mob/clothing/under/skirts_dresses.dmi'
	greyscale_config = /datum/greyscale_config/wedding_dress
	greyscale_config_worn = /datum/greyscale_config/wedding_dress/worn
	greyscale_colors = "#FFFFFF"
	body_parts_covered = CHEST|GROIN|LEGS
	flags_inv = HIDESHOES
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


/obj/item/clothing/under/dress/wedding_dress/ribbon
	name = "wedding dress with ribbon"
	desc = "A luxurious gown for once-in-a-lifetime occasions. Now with a cute ribbon, because you deserve it!"
	icon_state = "wedding_dress_with_ribbon"
	greyscale_colors = "#FFFFFF#FF0000"
	greyscale_config = /datum/greyscale_config/wedding_dress_ribbon
	greyscale_config_worn = /datum/greyscale_config/wedding_dress_ribbon/worn
