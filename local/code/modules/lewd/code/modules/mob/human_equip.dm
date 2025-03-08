GLOBAL_LIST_INIT(pref_checked_clothes, list(
	/obj/item/clothing/neck/collar,
))

/obj/item/clothing/mob_can_equip(mob/living/user, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action)
	if((slot_flags & slot) && (src.type in GLOB.pref_checked_clothes))
		if(!(user.client?.prefs?.read_preference(/datum/preference/toggle/erp_item_use)))
			return FALSE
	return ..()
