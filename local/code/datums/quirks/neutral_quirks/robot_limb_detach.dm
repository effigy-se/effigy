/datum/quirk/robot_limb_detach
	name = "Cybernetic Limb Mounts"
	desc = "You are able to detach and reattach any installed robotic limbs with very little effort, as long as they're in good condition."
	gain_text = span_notice("Internal sensors report limb disengagement protocols are ready and waiting.")
	lose_text = span_notice("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE.")
	medical_record_text = "Patient bears quick-attach and release limb joint cybernetics."
	value = 0
	mob_trait = TRAIT_ROBOTIC_LIMBATTACHMENT
	icon = FA_ICON_HANDSHAKE_SIMPLE_SLASH
	quirk_flags = QUIRK_HUMAN_ONLY
	/// The action we add with this quirk in add(), used for easy deletion later
	var/datum/action/cooldown/mob_cooldown/robot_self_amputation/added_action

/datum/quirk/robot_limb_detach/add(client/client_source)
	added_action = new()
	added_action.Grant(quirk_holder)

/datum/quirk/robot_limb_detach/remove()
	QDEL_NULL(added_action)

/datum/action/cooldown/mob_cooldown/robot_self_amputation
	name = "Detach a robotic limb"
	desc = "Disengage one of your robotic limbs from your cybernetic mounts. Requires you to not be restrained or otherwise under duress. Will not function on wounded limbs - tend to them first."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "autotomy"

	click_to_activate = FALSE
	cooldown_time = 30 SECONDS
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_HANDS_BLOCKED | AB_CHECK_INCAPACITATED

/datum/action/cooldown/mob_cooldown/robot_self_amputation/Activate(mob/living/carbon/carbon_target)
	if(!istype(carbon_target))
		return

	if(HAS_TRAIT(carbon_target, TRAIT_NODISMEMBER))
		to_chat(carbon_target, span_warning("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE. Seek out a maintenance technician."))
		return

	var/list/exclusions = list(BODY_ZONE_CHEST)
	if (!issynth(carbon_target))
		exclusions += BODY_ZONE_HEAD // no decapitating yourself unless you're a synthetic, who keep their brains in their chest

	var/list/robot_parts = list()
	for (var/obj/item/bodypart/possible_part as anything in carbon_target.bodyparts)
		if ((possible_part.bodytype & BODYTYPE_ROBOTIC) && !(possible_part.body_zone in exclusions)) //only robot limbs and only if they're not crucial to our like, ongoing life, you know?
			robot_parts += possible_part

	if (!length(robot_parts))
		to_chat(carbon_target, "ERROR: Limb disengagement protocols report no compatible cybernetics currently installed. Seek out a maintenance technician.")
		return

	var/obj/item/bodypart/limb_to_detach = tgui_input_list(carbon_target, "Limb to detach", "Cybernetic Limb Detachment", sort_names(robot_parts))
	if (QDELETED(src) || QDELETED(carbon_target) || QDELETED(limb_to_detach))
		return

	// only trigger the cooldown once the user has selected something
	. = ..()

	if (length(limb_to_detach.wounds))
		carbon_target.balloon_alert(carbon_target, "can't detach wounded limbs!")
		playsound(carbon_target, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	carbon_target.balloon_alert(carbon_target, "detaching limb...")
	playsound(carbon_target, 'sound/items/tools/rped.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	carbon_target.visible_message(span_notice("[carbon_target] shuffles [carbon_target.p_their()] [limb_to_detach.name] forward, actuators hissing and whirring as [carbon_target.p_they()] disengage[carbon_target.p_s()] the limb from its mount..."))

	if(!do_after(carbon_target, 5 SECONDS))
		carbon_target.balloon_alert(carbon_target, "interrupted!")
		playsound(carbon_target, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	carbon_target.visible_message(span_notice("With a gentle twist, [carbon_target] finally pries [carbon_target.p_their()] [limb_to_detach.name] free from its socket."))
	limb_to_detach.drop_limb()
	carbon_target.put_in_hands(limb_to_detach)
	carbon_target.balloon_alert(carbon_target, "limb detached!")
	if(prob(5))
		playsound(carbon_target, 'sound/items/champagne_pop.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	else
		playsound(carbon_target, 'sound/items/deconstruct.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
