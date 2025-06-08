// Face slapping
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
	return ..()
