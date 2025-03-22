/obj/structure/cable/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(isaquatic(user)) // EffigyEdit TODO - convert this to a tongue organ
		var/mob/living/hungry_shark = user
		if(hungry_shark.combat_mode && time2text(world.timeofday, "DDD", TIMEZONE_PST) == FRIDAY)
			if(shock(user, 30)) // While you don't need wirecutters... come on.
				user.visible_message(span_warning("[user] hungrily chomps the cabling - but catches a nasty shock!"), span_notice("You hungrily chomp into the fibre optic cable, only to meet a nasty shock!"))
				return
			user.visible_message(span_warning("[user] hungrily chomps through the fibre optic cable!"), span_notice("You hungrily chomp through the fibre optic cable!"))
			investigate_log("was cut by [key_name(usr)] in [AREACOORD(src)]", INVESTIGATE_WIRES)
			deconstruct()
			return

/obj/item/stack/cable_coil
	/// How long it takes to apply cable to your own robotic limbs to heal their burns.
	var/self_delay = 5 SECONDS
	/// How long it takes to apply cable to someone else's robotic limbs to heal their burns.
	var/other_delay = 1 SECONDS
