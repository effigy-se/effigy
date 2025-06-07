// Ass and face slapping
/mob/living/carbon/disarm(mob/living/target, obj/item/weapon)
	var/mob/living/carbon/carbon_target = target
	if(!istype(carbon_target))
		return ..()

	if(zone_selected == BODY_ZONE_PRECISE_MOUTH)
		var/target_on_help_and_unarmed = !carbon_target.combat_mode && !weapon
		if(!target_on_help_and_unarmed && !HAS_TRAIT(carbon_target, TRAIT_RESTRAINED))
			return ..()
		do_slap_animation(carbon_target)
		playsound(get_turf(carbon_target), 'sound/items/weapons/slap.ogg', 50, TRUE, -1)
		visible_message(span_danger("[src] slaps [carbon_target] in the face!"), \
						span_notice("You slap [carbon_target] in the face!"), \
						span_notice("You hear a slap."), \
						ignored_mobs = list(carbon_target))
		to_chat(carbon_target, span_danger("[src] slaps you in the face!"))
		return

	if(zone_selected == BODY_ZONE_PRECISE_GROIN && carbon_target.dir == src.dir)
		if(HAS_TRAIT(carbon_target, TRAIT_PERSONALSPACE) && !carbon_target.IsUnconscious() && !carbon_target.handcuffed) // You need to be conscious and uncuffed to use personal space
			if(carbon_target.combat_mode && !HAS_TRAIT(carbon_target, TRAIT_PACIFISM)) // Being pacified prevents violent counter
				apply_damage(PERSONAL_SPACE_DAMAGE, BRUTE, get_bodypart(BODY_ZONE_HEAD))
				visible_message(span_danger("[src] tries to slap [carbon_target]'s ass, but gets slapped instead!"), \
								span_danger("You try to slap [carbon_target]'s ass, but [carbon_target.p_they()] hit[carbon_target.p_s()] you back, ouch!"), \
								span_notice("You hear a slap."), \
								ignored_mobs = list(carbon_target))
				playsound(get_turf(carbon_target), 'sound/effects/snap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
				to_chat(carbon_target, span_danger("[src] tries to slap your ass, but you hit [p_them()] back!"))
				return
			else
				visible_message(span_danger("[src] tries to slap [carbon_target]'s ass, but [p_they()] get[p_s()] blocked!"), \
								span_danger("You try to slap [carbon_target]'s ass, but [carbon_target.p_they()] block[carbon_target.p_s()] you!"), \
								span_notice("You hear a slap."), \
								ignored_mobs = list(carbon_target))
				playsound(get_turf(carbon_target), 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
				to_chat(carbon_target, span_danger("[src] tries to slap your ass, but you block [p_them()]!"))
				return
		else
			do_ass_slap_animation(carbon_target)
			playsound(get_turf(carbon_target), 'sound/items/weapons/slap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
			visible_message(span_danger("[src] slaps [carbon_target] right on the ass!"), \
							span_notice("You slap [carbon_target] on the ass, how satisfying."), \
							span_notice("You hear a slap."), \
							ignored_mobs = list(carbon_target))
			to_chat(carbon_target, span_danger("[src] slaps your ass!"))
			return

	return ..()
