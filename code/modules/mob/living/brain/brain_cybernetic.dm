#define ROBOT_OIL_LOSS_ON_STEP 0.05 // 11,200 steps to lose all your oil
#define ROBOT_OIL_LOSS_ON_INTERACT 0.1 // 5,600 interactions to lose all your oil

/obj/item/organ/brain/cybernetic
	name = "cybernetic brain"
	desc = "A mechanical brain found inside of androids. Not to be confused with a positronic brain."
	icon_state = "brain-c"
	organ_flags = ORGAN_ROBOTIC | ORGAN_VITAL
	failing_desc = "seems to be broken, and will not work without repairs."
	var/power = 100
	var/max_power = 100
	var/atom/movable/screen/power_meter/power_meter
	var/atom/movable/screen/power_meter/oil/oil_meter
	var/list/lubricants = list( // What chemicals will satisfy the oil requirement to up the joints?
		/datum/reagent/fuel/oil = 1,
		/datum/reagent/lube = 2,
		/datum/reagent/lube/superlube = 3,
	)
	var/list/lubricant_types = list(
		/datum/reagent/fuel/oil,
		/datum/reagent/lube,
		/datum/reagent/lube/superlube,
	)
#define POWER_STATE_FULL_CHARGE 4
#define POWER_STATE_CHARGED 3
#define POWER_STATE_HALF_CHARGED 2
#define POWER_STATE_LOW_CHARGE 1
#define POWER_STATE_PLUG_IT_IN 0

/atom/movable/screen/power_meter
	name = "power"
	icon_state = "powerbar"
	screen_loc = "EAST-1:28,CENTER+1:21"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/state
	var/power_left
	var/image/power_source_image
	var/power_icon_state = "power_beer"
	var/power_icon = 'local/icons/hud/screen_gen.dmi'
	var/power_icon_offset = 0
	var/power_bar_type = /atom/movable/screen/robothud_bar
	var/atom/movable/screen/robothud_bar/power_meter_bar

/atom/movable/screen/power_meter/oil
	name = "oil"
	icon_state = "oilbar"
	power_icon_state = "power_oil"
	power_icon_offset = 3
	power_bar_type = /atom/movable/screen/robothud_bar/oil

/atom/movable/screen/power_meter/oil/update_power_state()
	var/mob/living/carbon/human/robot = hud?.mymob
	if(!istype(robot))
		return

	power_left = robot.blood_volume / BLOOD_VOLUME_NORMAL

	switch(power_left)
		if(0.81 to INFINITY)
			state = POWER_STATE_FULL_CHARGE
		if(0.61 to 0.8)
			state = POWER_STATE_CHARGED
		if(0.41 to 0.6)
			state = POWER_STATE_HALF_CHARGED
		if(0.21 to 0.4)
			state = POWER_STATE_PLUG_IT_IN
		if(0 to 0.2)
			state = POWER_STATE_PLUG_IT_IN


/atom/movable/screen/power_meter/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	var/mob/living/robot = hud_owner?.mymob
	if(!istype(robot))
		return
	power_source_image = image(icon = power_icon, icon_state = power_icon_state, pixel_x = power_icon_offset)
	power_source_image.plane = plane
	power_source_image.appearance_flags |= KEEP_APART // To be unaffected by filters applied to src
	power_source_image.add_filter("simple_outline", 2, outline_filter(1, COLOR_BLACK, OUTLINE_SHARP))
	underlays += power_source_image // To be below filters applied to src

	// The actual bar
	power_meter_bar = new power_bar_type(src, null)
	vis_contents += power_meter_bar

	update_power_bar()

/atom/movable/screen/power_meter/proc/update_power_state()
	var/mob/living/hungry = hud?.mymob
	if(!istype(hungry))
		return

	var/obj/item/organ/brain/cybernetic/robot_brain = hungry.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return

	power_left = robot_brain.power / robot_brain.max_power

	switch(power_left)
		if(0.81 to INFINITY)
			state = POWER_STATE_FULL_CHARGE
		if(0.61 to 0.8)
			state = POWER_STATE_CHARGED
		if(0.41 to 0.6)
			state = POWER_STATE_HALF_CHARGED
		if(0.21 to 0.4)
			state = POWER_STATE_LOW_CHARGE
		if(0 to 0.2)
			state = POWER_STATE_PLUG_IT_IN

/atom/movable/screen/power_meter/update_appearance(updates)
	update_power_bar()
	return ..()

/atom/movable/screen/power_meter/proc/update_power_bar()
	var/old_state = state
	update_power_state()
	if(old_state != state)
		if(state == POWER_STATE_PLUG_IT_IN)
			if(!get_filter("hunger_outline"))
				add_filter("hunger_outline", 1, list("type" = "outline", "color" = "#FF0033", "alpha" = 0, "size" = 2))
				animate(get_filter("hunger_outline"), alpha = 200, time = 1.5 SECONDS, loop = -1)
				animate(alpha = 0, time = 1.5 SECONDS)

		else if(old_state == POWER_STATE_PLUG_IT_IN)
			remove_filter("hunger_outline")

	power_meter_bar.update_fullness(power_left, FALSE)

/atom/movable/screen/robothud_bar
	icon_state = "powerbar_bar"
	screen_loc = "EAST-1:28,CENTER+1:21"
	vis_flags = VIS_INHERIT_ID | VIS_INHERIT_PLANE
	var/mask_icon_state = "powerbar_mask"
	/// Gradient used to color the bar
	var/list/power_gradient = list(
		0.0, "#FF0000",
		0.2, "#FF8000",
		0.4, "#f0f000",
		0.6, "#00FF00",
		0.8, "#46daff",
		1.0, "#2A72AA"
	)
	/// Offset of the mask
	var/bar_offset
	/// Last "fullness" value (rounded) we used to update the bar
	var/last_fullness_band = -1
	/// Mask
	var/icon/bar_mask

/atom/movable/screen/robothud_bar/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	var/atom/movable/movable_loc = ismovable(loc) ? loc : null
	screen_loc = movable_loc?.screen_loc
	bar_mask ||= icon(icon, mask_icon_state)

/atom/movable/screen/robothud_bar/proc/update_fullness(new_fullness, instant)
	if(new_fullness == last_fullness_band)
		return
	last_fullness_band = new_fullness
	var/new_color = gradient(power_gradient, clamp(new_fullness, 0, 1))
	if(instant)
		color = new_color
	else
		animate(src, color = new_color, 0.5 SECONDS)

	var/old_bar_offset = bar_offset
	bar_offset = clamp(-20 + (20 * new_fullness), -20, 0)
	if(old_bar_offset != bar_offset)
		if(instant || isnull(old_bar_offset))
			add_filter(mask_icon_state, 1, alpha_mask_filter(0, bar_offset, bar_mask))
		else
			transition_filter(mask_icon_state, alpha_mask_filter(0, bar_offset), 0.5 SECONDS)

/atom/movable/screen/robothud_bar/oil
	icon_state = "oilbar_bar"
	mask_icon_state = "oilbar_mask"
	power_gradient = list(
		0.0, "#FF0000",
		0.2, "#800000",
		0.4, "#800000",
		0.6, "#2D2D2D",
		0.8, "#2D2D2D",
		1.0, "#2D2D2D"
	)

#undef POWER_STATE_FULL_CHARGE
#undef POWER_STATE_CHARGED
#undef POWER_STATE_HALF_CHARGED
#undef POWER_STATE_LOW_CHARGE
#undef POWER_STATE_PLUG_IT_IN

/datum/status_effect/oil_fast_click
	id = "oil_fast_click"
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

/datum/status_effect/oil_fast_click/nextmove_modifier()
	return 0.5

/datum/status_effect/oil_slow_click
	id = "oil_slow_click"
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/oil_slow_click

/atom/movable/screen/alert/status_effect/oil_slow_click
	name = "Low On Oil"
	desc = "Your joints are getting rusty. Apply some lubrication in the form of oil to get back up to speed, before you lock up entirely!"
	icon = 'local/icons/hud/screen_gen.dmi'
	icon_state = "low_oil_alert"

/datum/status_effect/oil_slow_click/nextmove_modifier()
	return 1.5

/datum/status_effect/no_oil
	id = "no_oil"
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/no_oil

/datum/status_effect/no_oil/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/no_oil/on_remove()
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))
	return ..()

/atom/movable/screen/alert/status_effect/no_oil
	name = "No Oil"
	desc = "Your joints are rusted shut! Apply some lubrication in the form of oil to get moving again!"
	icon = 'local/icons/hud/screen_gen.dmi'
	icon_state = "no_oil_alert"

/obj/item/organ/brain/cybernetic/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()
	RegisterSignal(brain_owner, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(oil_handling))
	RegisterSignal(brain_owner, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(on_expose))
	RegisterSignal(brain_owner, COMSIG_MOVABLE_MOVED, PROC_REF(drain_oil_movement))
	RegisterSignal(brain_owner, COMSIG_USER_ITEM_INTERACTION, PROC_REF(drain_oil_interact))
	RegisterSignal(brain_owner, COMSIG_USER_ITEM_INTERACTION_SECONDARY, PROC_REF(drain_oil_interact))
	RegisterSignal(brain_owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(drain_oil_hand_interact))

/obj/item/organ/brain/cybernetic/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	UnregisterSignal(organ_owner, COMSIG_HUMAN_ON_HANDLE_BLOOD)
	UnregisterSignal(organ_owner, COMSIG_ATOM_EXPOSE_REAGENTS)
	UnregisterSignal(organ_owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(organ_owner, COMSIG_USER_ITEM_INTERACTION)
	UnregisterSignal(organ_owner, COMSIG_USER_ITEM_INTERACTION_SECONDARY)
	. = ..()

/obj/item/organ/brain/cybernetic/proc/oil_handling(mob/living/carbon/human/robot, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	if(robot.stat == DEAD)
		return HANDLE_BLOOD_HANDLED

	var/blood_ratio = robot.blood_volume / BLOOD_VOLUME_NORMAL
	if(robot.blood_volume < 0)
		robot.blood_volume = 0
	if(robot.blood_volume > BLOOD_VOLUME_NORMAL)
		robot.blood_volume = BLOOD_VOLUME_NORMAL
	switch(blood_ratio)
		if(0.81 to INFINITY) // Give them a bonus for keeping up on their oil!
			robot.apply_status_effect(/datum/status_effect/oil_fast_click)
			robot.remove_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/no_oil)
		if(0.41 to 0.8) // Take away any bonuses.
			robot.remove_status_effect(/datum/status_effect/oil_fast_click)
			robot.remove_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/no_oil)
		if(0.001 to 0.4) // Start slowing their clicking down.
			robot.apply_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/oil_fast_click)
			robot.remove_status_effect(/datum/status_effect/no_oil)
		if(-INFINITY to 0)
			robot.apply_status_effect(/datum/status_effect/no_oil)
			robot.apply_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/oil_fast_click)

	return HANDLE_BLOOD_HANDLED

/obj/item/organ/brain/cybernetic/proc/on_expose(atom/target, list/applied_reagents, datum/reagents/source, methods)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/robot = target
	if(!istype(robot))
		return
	if(!(methods & (TOUCH|VAPOR)))
		return
	var/did_lubrication = FALSE
	for(var/datum/reagent/bit as anything in applied_reagents)
		if(is_type_in_list(bit, lubricant_types))
			robot.blood_volume += lubricants[bit.type] * applied_reagents[bit]
			did_lubrication = TRUE
	if(did_lubrication)
		robot.balloon_alert(robot, "lubricated")

/obj/item/organ/brain/cybernetic/proc/drain_oil_movement(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/robot = mover
	if(!istype(robot))
		return
	if(CHECK_MOVE_LOOP_FLAGS(robot, MOVEMENT_LOOP_OUTSIDE_CONTROL))
		return // NOT INTENTIONAL MOVEMENT, DON'T DRAIN OIL
	robot.blood_volume -= ROBOT_OIL_LOSS_ON_STEP

/obj/item/organ/brain/cybernetic/proc/drain_oil_hand_interact(mob/living/carbon/human/source, atom/target, proximity_flag, modifiers)
	SIGNAL_HANDLER
	if(proximity_flag)
		source.blood_volume -= ROBOT_OIL_LOSS_ON_INTERACT
	return NONE

/obj/item/organ/brain/cybernetic/proc/drain_oil_interact(mob/living/source, atom/target, obj/item/weapon, list/modifiers)
	SIGNAL_HANDLER
	source.blood_volume -= ROBOT_OIL_LOSS_ON_INTERACT
	return NONE

/obj/item/organ/brain/cybernetic/on_life(seconds_per_tick, times_fired)
	. = ..()
	power -= 0.025 * seconds_per_tick
	handle_hud(owner)

/obj/item/organ/brain/cybernetic/proc/handle_hud(mob/living/carbon/target)
	// update it
	if(power_meter && oil_meter)
		power_meter.update_power_bar()
		oil_meter.update_power_bar()
	// initialize it
	else if(target.hud_used)
		var/datum/hud/hud_used = target.hud_used
		power_meter = new(null, hud_used)
		oil_meter = new(null, hud_used)
		hud_used.infodisplay += power_meter
		hud_used.infodisplay += oil_meter
		target.hud_used.show_hud(target.hud_used.hud_version)
		power_meter.update_power_bar()
		oil_meter.update_power_bar()

/obj/item/organ/brain/cybernetic/Destroy()
	if(power_meter)
		if(owner?.hud_used)
			owner?.hud_used.infodisplay -= power_meter
		qdel(power_meter)
	if(oil_meter)
		if(owner?.hud_used)
			owner?.hud_used.infodisplay -= oil_meter
		qdel(oil_meter)
	. = ..()

/obj/item/organ/brain/cybernetic/brain_damage_examine()
	if(suicided)
		return span_info("Its circuitry is smoking slightly. They must not have been able to handle the stress of it all.")
	if(brainmob && (decoy_override || brainmob.client || brainmob.get_ghost()))
		if(organ_flags & ORGAN_FAILING)
			return span_info("It seems to still have a bit of energy within it, but it's rather damaged... You may be able to repair it with a <b>multitool</b>.")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			return span_info("You can feel the small spark of life still left in this one, but it's got some dents. You may be able to restore it with a <b>multitool</b>.")
		else
			return span_info("You can feel the small spark of life still left in this one.")
	else
		return span_info("This one is completely devoid of life.")

/obj/item/organ/brain/cybernetic/check_for_repair(obj/item/item, mob/user)
	if (item.tool_behaviour == TOOL_MULTITOOL) //attempt to repair the brain
		if (brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] is far too damaged, there's nothing else we can do for it!"))
			return TRUE

		if (DOING_INTERACTION(user, src))
			to_chat(user, span_warning("you're already repairing [src]!"))
			return TRUE

		user.visible_message(span_notice("[user] slowly starts to repair [src] with [item]."), span_notice("You slowly start to repair [src] with [item]."))
		var/did_repair = FALSE
		while(damage > 0)
			if(item.use_tool(src, user, 3 SECONDS, volume = 50))
				did_repair = TRUE
				set_organ_damage(max(0, damage - 20))
			else
				break

		if (did_repair)
			if (damage > 0)
				user.visible_message(span_notice("[user] partially repairs [src] with [item]."), span_notice("You partially repair [src] with [item]."))
			else
				user.visible_message(span_notice("[user] fully repairs [src] with [item], causing its warning light to stop flashing."), span_notice("You fully repair [src] with [item], causing its warning light to stop flashing."))
		else
			to_chat(user, span_warning("You failed to repair [src] with [item]!"))

		return TRUE
	return FALSE

/obj/item/organ/brain/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity) // Hard cap on brain damage from EMP
		if (EMP_HEAVY)
			apply_organ_damage(20, BRAIN_DAMAGE_SEVERE)
		if (EMP_LIGHT)
			apply_organ_damage(10, BRAIN_DAMAGE_MILD)
