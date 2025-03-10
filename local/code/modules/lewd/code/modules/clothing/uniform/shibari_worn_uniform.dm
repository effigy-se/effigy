/obj/item/clothing/under/shibari
	strip_delay = 100
	can_adjust = FALSE
	body_parts_covered = NONE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	item_flags = DROPDEL
	greyscale_colors = "#bd8fcf"
	has_sensor = NO_SENSORS

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/under/shibari/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, src, alpha = alpha)

/obj/item/clothing/under/shibari/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = standing.alpha)

/obj/item/clothing/under/shibari/Destroy(force)
	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	return ..()

/obj/item/clothing/under/shibari/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, PROC_REF(handle_take_off), user)


/obj/item/clothing/under/shibari/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_take_off_async), user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/under/shibari/proc/handle_take_off_async(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(do_after(hooman, 10 SECONDS, target = src))
		dropped(user)

/obj/item/clothing/under/shibari/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/under/shibari/torso
	name = "shibari ropes"
	desc = "Nice looking rope bondage."
	icon_state = "shibari_body"

	greyscale_config = /datum/greyscale_config/shibari_clothes/body
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/body
	greyscale_colors = "#bd8fcf"

/obj/item/clothing/under/shibari/groin
	name = "crotch rope shibari"
	desc = "A rope that teases the wearer's genitals."
	icon_state = "shibari_groin"

	greyscale_config = /datum/greyscale_config/shibari_clothes/groin
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/groin
	greyscale_colors = "#bd8fcf"

/obj/item/clothing/under/shibari/full
	name = "shibari fullbody ropes"
	desc = "Bondage ropes that cover the whole body."
	icon_state = "shibari_fullbody"

	greyscale_config = /datum/greyscale_config/shibari_clothes/fullbody
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/fullbody
	greyscale_colors = "#bd8fcf#bd8fcf"
