/obj/item/clothing/suit/straight_jacket/shackles
	name = "shackles"
	desc = "A set of shackles designed for intimate encounters. There's a release switch just under the wrist."
	body_parts_covered = NONE
	flags_inv = NONE
	icon = 'local/icons/lewd/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/suits.dmi'
	icon_state = "shackles"
	greyscale_colors = "#dc7ef4#383840"
	greyscale_config = /datum/greyscale_config/dorms_shackles
	greyscale_config_worn = /datum/greyscale_config/dorms_shackles/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	greyscale_config_worn_bodyshapes = list(
		BODYSHAPE_HUMANOID_T = /datum/greyscale_config/dorms_shackles/worn,
		BODYSHAPE_DIGITIGRADE_T = /datum/greyscale_config/dorms_shackles/worn/digi,
	)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'local/icons/lewd/mob/clothing/suits.dmi',
		BODYSHAPE_DIGITIGRADE_T = 'local/icons/lewd/mob/clothing/suits_digi.dmi',
	)
	equip_delay_self = 1 SECONDS
	strip_delay = 2 SECONDS
	breakouttime = 1 SECONDS
	slowdown = 1
	pickup_sound = 'sound/items/handling/handcuffs/handcuffs_pick_up.ogg'
	drop_sound = 'sound/items/handling/handcuffs/handcuffs_drop.ogg'
	sound_vary = TRUE
	gender = PLURAL // "That's some shackles."

/obj/item/clothing/suit/straight_jacket/shackles/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL


/obj/item/clothing/suit/straight_jacket/shackles/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	if(src == affected_mob.wear_suit)
		play_lewd_sound(src, 'sound/items/handcuff_finish.ogg', 70, TRUE)


//reinforcing normal version by using handcuffs on it.
/obj/item/clothing/suit/straight_jacket/shackles/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/restraints/handcuffs) && !istype(src, /obj/item/clothing/suit/straight_jacket/shackles/reinforced))
		var/obj/item/clothing/suit/straight_jacket/shackles/reinforced/shackles = new()
		remove_item_from_storage(user)
		user.put_in_hands(shackles)
		to_chat(user, span_notice("You reinforce the locks on [src] with [tool]."))
		qdel(tool)
		qdel(src)
		return TRUE

	return ..()

/// Reinforced Version
/obj/item/clothing/suit/straight_jacket/shackles/reinforced
	name = "reinforced shackles"
	desc = "A set of sturdy shackles, with a heavy lock."
	clothing_flags = DANGEROUS_OBJECT
	equip_delay_self = 10 SECONDS
	strip_delay = 12 SECONDS
	breakouttime = 3 MINUTES // It's an ERP tool anyways.
	slowdown = 2
