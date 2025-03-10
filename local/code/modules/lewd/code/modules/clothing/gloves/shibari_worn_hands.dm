/obj/item/clothing/gloves/shibari_hands
	name = "shibari arms bondage"
	desc = "Bondage ropes that cover arms."
	icon_state = "shibari_arms"
	icon = 'local/icons/lewd/obj/clothing/gloves.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/gloves.dmi'
	body_parts_covered = NONE
	//strip_delay = 100
	breakouttime = 5 SECONDS
	item_flags = DROPDEL

	greyscale_config = /datum/greyscale_config/shibari_clothes/hands
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/hands
	greyscale_colors = "#bd8fcf"

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/gloves/shibari_hands/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, src, alpha = 100)

/obj/item/clothing/gloves/shibari_hands/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = 100)

/obj/item/clothing/gloves/shibari_hands/Destroy()
	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	return..()

/obj/item/clothing/gloves/shibari_hands/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
	AddElement(/datum/element/update_icon_updates_onmob)

