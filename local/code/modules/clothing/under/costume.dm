/obj/item/clothing/under/costume/draculass
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	supported_bodyshapes = list(
		BODYSHAPE_HUMANOID,
		BODYSHAPE_DIGITIGRADE
		)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'icons/mob/clothing/under/costume.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/mob/clothing/under/costume_digi.dmi',
	)

/obj/item/clothing/under/maid_costume
	name = "maid costume"
	desc = "Maid in China."
	icon_state = "maid_costume"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_config = /datum/greyscale_config/maid_costume
	greyscale_config_worn = /datum/greyscale_config/maid_costume/worn
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1
