/obj/item/clothing/shoes/shibari_legs
	name = "shibari legs bondage"
	desc = "Bondage ropes that cover legs."
	icon_state = "shibari_legs"
	icon = 'local/icons/lewd/obj/clothing/shoes.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/shoes.dmi'
	body_parts_covered = NONE
	strip_delay = 100
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	slowdown = 4
	item_flags = DROPDEL|IGNORE_DIGITIGRADE

	greyscale_config = /datum/greyscale_config/shibari_clothes/legs
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/legs
	greyscale_colors = "#bd8fcf"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	supported_bodyshapes = list(
		BODYSHAPE_HUMANOID,
		BODYSHAPE_DIGITIGRADE
	)
	greyscale_config_worn_bodyshapes = list(
		BODYSHAPE_HUMANOID_T = /datum/greyscale_config/shibari_worn/legs,
		BODYSHAPE_DIGITIGRADE_T = /datum/greyscale_config/shibari_worn_digi_legs,
	)

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/shoes/shibari_legs/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, src, alpha = 100)

/obj/item/clothing/shoes/shibari_legs/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = 100)


/obj/item/clothing/shoes/shibari_legs/Destroy()
	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	return..()

/obj/item/clothing/shoes/shibari_legs/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/shoes/shibari_legs/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, PROC_REF(handle_take_off), user)


/obj/item/clothing/shoes/shibari_legs/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_take_off_async), user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/shoes/shibari_legs/proc/handle_take_off_async(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(do_after(hooman, 10 SECONDS, target = src))
		dropped(user)
