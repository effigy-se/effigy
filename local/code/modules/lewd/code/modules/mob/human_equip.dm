GLOBAL_LIST_INIT(pref_checked_clothes, list(
	/obj/item/clothing/ears/dorms_headphones,
	/obj/item/clothing/erp_leash,
	/obj/item/clothing/glasses/blindfold/dorms,
	/obj/item/clothing/glasses/hypno,
	/obj/item/clothing/gloves/ball_mittens,
	/obj/item/clothing/gloves/shibari_hands,
	/obj/item/clothing/head/deprivation_helmet,
	/obj/item/clothing/head/domina_cap,
	/obj/item/clothing/mask/ballgag,
	/obj/item/clothing/mask/gas/dorms_mask,
	/obj/item/clothing/neck/collar,
	/obj/item/clothing/shoes/ballet_heels,
	/obj/item/clothing/shoes/latex_socks,
	/obj/item/clothing/shoes/shibari_legs,
	/obj/item/clothing/suit/straight_jacket/shackles,
	/obj/item/clothing/under/shibari,
	/obj/item/clothing/under/tearaway_garments,
))

/obj/item/clothing/mob_can_equip(mob/living/user, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action)
	if((slot_flags & slot) && (src.type in GLOB.pref_checked_clothes))
		if(!(user.client?.prefs?.read_preference(/datum/preference/toggle/erp_item_use)))
			return FALSE
	return ..()
