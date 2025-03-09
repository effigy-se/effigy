/obj/item/clothing/mask/gas/dorms_mask
	desc = "A strict-tensity gas mask that hugs to the face and completely muffles the wearer."
	icon = 'local/icons/lewd/obj/clothing/masks.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/masks.dmi'
	icon_state = "mask"
	greyscale_colors = "#383840#dc7ef4"
	greyscale_config = /datum/greyscale_config/dorms_mask
	greyscale_config_worn = /datum/greyscale_config/dorms_mask/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSMOUTH
	flags_inv = HIDEFACIALHAIR|HIDESNOUT

NO_DIGI_OR_SNOUT_VARIANT_HELPER(/obj/item/clothing/mask/gas/dorms_mask)

/obj/item/clothing/mask/gas/dorms_mask/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
	AddElement(/datum/element/muffles_speech)
