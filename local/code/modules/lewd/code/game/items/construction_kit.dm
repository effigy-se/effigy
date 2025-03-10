/// SHOG NOTE: This can probably be genericized and moved out of this module if we find the behavior THAT useful, ig
/obj/item/construction_kit
	name = "construction kit"
	desc = "Used for constructing various things."
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CAN_BE_HIT
	throwforce = 0
	///What is the path for the resulting structure generating by using this item?
	var/obj/structure/resulting_structure = /obj/structure/chair
	///How much time does it take to construct an item using this?
	var/construction_time = 8 SECONDS
	///What color is the item using? If none, leave this blank.
	var/current_color = ""

/obj/item/construction_kit/examine(mob/user)
	. = ..()
	. += span_purple("[src] can be assembled by using <b>Ctrl+Shift+Click</b> while [src] is on the floor.")

/obj/item/construction_kit/click_ctrl_shift(mob/user)
	if((item_flags & IN_INVENTORY) || (item_flags & IN_STORAGE))
		return

	to_chat(user, span_notice("You begin to assemble [src]..."))
	if(!do_after(user, construction_time, src))
		to_chat(user, span_warning("You fail to assemble [src]!"))
		return
	new resulting_structure (get_turf(src))

	qdel(src)
	to_chat(user, span_notice("You assemble [src]."))

/// KIT TYPES ///

/obj/item/construction_kit/pole
	name = "stripper pole construction kit"
	icon = 'local/icons/lewd/obj/structures/dancing_pole.dmi'
	icon_state = "pole_base"
	resulting_structure = /obj/structure/stripper_pole

/obj/item/construction_kit/pole/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
