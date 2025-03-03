/obj/item/clothing/head/helmet/space
	supported_bodyshapes = list(
		BODYSHAPE_HUMANOID,
		BODYSHAPE_SNOUTED
		)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'icons/mob/clothing/head/spacehelm.dmi',
		BODYSHAPE_SNOUTED_T = 'local/icons/mob/clothing/head/spacehelm_snout.dmi',
	)

/obj/item/clothing/suit/space
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	supported_bodyshapes = list(
		BODYSHAPE_HUMANOID,
		BODYSHAPE_DIGITIGRADE
		)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'icons/mob/clothing/suits/spacesuit.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/mob/clothing/suits/spacesuit_digi.dmi',
	)

NO_DIGI_OR_SNOUT_VARIANT_HELPER(/obj/item/clothing/suit/space/hunter)

NO_DIGI_OR_SNOUT_VARIANT_HELPER(/obj/item/clothing/suit/space/pirate/silverscale)

/obj/item/clothing/suit/space/santa
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'icons/mob/clothing/suits/spacesuit.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/mob/clothing/suits/wizard_digi.dmi',
	)

NO_DIGI_OR_SNOUT_VARIANT_HELPER(/obj/item/clothing/suit/space/officer)

NO_DIGI_OR_SNOUT_VARIANT_HELPER(/obj/item/clothing/suit/space/syndicate/black/white)

NO_DIGI_OR_SNOUT_VARIANT_HELPER(/obj/item/clothing/suit/space/syndicate/black/med)
