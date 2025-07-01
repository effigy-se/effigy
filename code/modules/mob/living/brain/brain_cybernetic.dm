#define ROBOT_OIL_LOSS_ON_STEP 0.05 // 11,200 steps to lose all your oil
#define ROBOT_OIL_LOSS_ON_INTERACT 0.1 // 5,600 interactions to lose all your oil

/obj/item/organ/brain/cybernetic
	name = "cybernetic brain"
	desc = "A mechanical brain found inside of androids. Not to be confused with a positronic brain."
	icon_state = "brain-c"
	organ_flags = ORGAN_ROBOTIC | ORGAN_VITAL
	failing_desc = "seems to be broken, and will not work without repairs."
	organ_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_LITERATE,
		TRAIT_CAN_STRIP,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_RADIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_STABLELIVER,
		TRAIT_NO_DAMAGE_OVERLAY,
		TRAIT_NOCRITOVERLAY,
		TRAIT_NOHARDCRIT,
		TRAIT_NOSOFTCRIT,
		TRAIT_NOSTAMCRIT,
	)
	var/power = 100
	var/max_power = 100
	var/distress_beacon_active = FALSE
	var/beacon_light_timer
	var/atom/movable/screen/power_meter/power_meter
	var/atom/movable/screen/power_meter/oil/oil_meter
	var/temperature_disparity = 1

#define POWER_STATE_FULL_CHARGE 4
#define POWER_STATE_CHARGED 3
#define POWER_STATE_HALF_CHARGED 2
#define POWER_STATE_LOW_CHARGE 1
#define POWER_STATE_PLUG_IT_IN 0

/atom/movable/screen/power_meter
	name = "power"
	icon_state = "powerbar"
	screen_loc = ui_health
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
	screen_loc = ui_mood
	power_icon_state = "power_oil"
	power_icon_offset = 0
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
		if(-INFINITY to 0.4)
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

/atom/movable/screen/power_meter/proc/update_power_bar(instant = FALSE)
	var/old_state = state
	var/old_power_left = power_left
	update_power_state()
	if(old_state != state)
		if(state == POWER_STATE_PLUG_IT_IN)
			if(!get_filter("hunger_outline"))
				add_filter("hunger_outline", 1, list("type" = "outline", "color" = "#FF0033", "alpha" = 0, "size" = 2))
				animate(get_filter("hunger_outline"), alpha = 200, time = 1.5 SECONDS, loop = -1)
				animate(alpha = 0, time = 1.5 SECONDS)

		else if(old_state == POWER_STATE_PLUG_IT_IN)
			remove_filter("hunger_outline")
	if(old_power_left != power_left)
		if(instant)
			Shake(3, 0, 0.3 SECONDS)
		power_meter_bar.update_fullness(power_left, instant)

/atom/movable/screen/robothud_bar
	icon_state = "powerbar_bar"
	screen_loc = ui_health
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
	screen_loc = ui_mood
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

/obj/item/organ/brain/cybernetic/proc/activate_distress_beacon()
	distress_beacon_active = TRUE
	pulse_beacon_light()
	beacon_light_timer = addtimer(CALLBACK(src, PROC_REF(pulse_beacon_light)), 2 SECONDS, TIMER_STOPPABLE | TIMER_LOOP | TIMER_DELETE_ME)

/obj/item/organ/brain/cybernetic/proc/pulse_beacon_light()
	owner.mob_light(range = 1.5, power = 2, color = LIGHT_COLOR_INTENSE_RED, duration = 1 SECONDS)

/obj/item/organ/brain/cybernetic/proc/deactivate_distress_beacon()
	distress_beacon_active = FALSE
	deltimer(beacon_light_timer)

/obj/item/organ/brain/cybernetic/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()
	RegisterSignal(brain_owner, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(oil_handling))
	RegisterSignal(brain_owner, COMSIG_MOVABLE_MOVED, PROC_REF(drain_oil_movement))
	RegisterSignal(brain_owner, COMSIG_USER_ITEM_INTERACTION, PROC_REF(drain_oil_interact))
	RegisterSignal(brain_owner, COMSIG_USER_ITEM_INTERACTION_SECONDARY, PROC_REF(drain_oil_interact))
	RegisterSignal(brain_owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(drain_oil_hand_interact))
	RegisterSignal(brain_owner, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(drain_power_on_damage))
	RegisterSignal(brain_owner, COMSIG_CARBON_UPDATE_STAT, PROC_REF(block_stat_update))
	RegisterSignal(brain_owner, COMSIG_LIVING_MED_HUD_SET_HEALTH, PROC_REF(medhud_health))
	RegisterSignal(brain_owner, COMSIG_LIVING_MED_HUD_SET_STATUS, PROC_REF(medhud_status))
	RegisterSignal(brain_owner, COMSIG_LIVING_CAN_REVIVE, PROC_REF(allow_revives))
	RegisterSignal(brain_owner, COMSIG_LIVING_DEATH, PROC_REF(activate_distress_beacon_death))
	RegisterSignal(brain_owner, COMSIG_ATOM_EMP_ACT, PROC_REF(emp_effect))
	RegisterSignal(brain_owner, COMSIG_MOB_CLIENT_LOGIN, PROC_REF(on_login))
	RegisterSignal(brain_owner, COMSIG_SPECIES_HANDLE_TEMPERATURE, PROC_REF(temperature_overrides))
	qdel(brain_owner.mob_mood)
	brain_owner.med_hud_set_health() // fix the health bar sprite
	brain_owner.med_hud_set_status()
	brain_owner.add_movespeed_mod_immunities("robot_brain", /datum/movespeed_modifier/damage_slowdown)
	brain_owner.add_movespeed_mod_immunities("robot_brain", /datum/movespeed_modifier/damage_slowdown_flying)

/obj/item/organ/brain/cybernetic/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	UnregisterSignal(organ_owner, COMSIG_HUMAN_ON_HANDLE_BLOOD)
	UnregisterSignal(organ_owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(organ_owner, COMSIG_USER_ITEM_INTERACTION)
	UnregisterSignal(organ_owner, COMSIG_USER_ITEM_INTERACTION_SECONDARY)
	UnregisterSignal(organ_owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK)
	UnregisterSignal(organ_owner, COMSIG_MOB_APPLY_DAMAGE)
	UnregisterSignal(organ_owner, COMSIG_CARBON_UPDATE_STAT)
	UnregisterSignal(organ_owner, COMSIG_HUMAN_HEALTH_PRE_UPDATE)
	UnregisterSignal(organ_owner, COMSIG_LIVING_MED_HUD_SET_HEALTH)
	UnregisterSignal(organ_owner, COMSIG_LIVING_MED_HUD_SET_STATUS)
	UnregisterSignal(organ_owner, COMSIG_LIVING_CAN_REVIVE)
	UnregisterSignal(organ_owner, COMSIG_LIVING_DEATH)
	UnregisterSignal(organ_owner, COMSIG_ATOM_EMP_ACT)
	UnregisterSignal(organ_owner, COMSIG_MOB_CLIENT_LOGIN)
	UnregisterSignal(organ_owner, COMSIG_SPECIES_HANDLE_TEMPERATURE)
	organ_owner.mob_mood = new /datum/mood(organ_owner)
	organ_owner.remove_movespeed_mod_immunities("robot_brain", /datum/movespeed_modifier/damage_slowdown)
	organ_owner.remove_movespeed_mod_immunities("robot_brain", /datum/movespeed_modifier/damage_slowdown_flying)

	. = ..()

/obj/item/organ/brain/cybernetic/proc/activate_distress_beacon_death(mob/living/target, gibbed)
	SIGNAL_HANDLER
	if(!distress_beacon_active)
		activate_distress_beacon()

/obj/item/organ/brain/cybernetic/proc/emp_effect(datum/source, severity, protection)
	SIGNAL_HANDLER
	if(protection & EMP_PROTECT_SELF)
		return
	if(distress_beacon_active)
		deactivate_distress_beacon()

/datum/movespeed_modifier/robot_low_oil
	multiplicative_slowdown = 0.4
	blacklisted_movetypes = FLOATING|FLYING

/atom/movable/screen/fullscreen/static_vision/robot
	alpha = 0
	color = "#FFFFFF"

/atom/movable/screen/fullscreen/static_vision/robot_eyes
	alpha = 0
	color = "#FFFFFF"

/atom/movable/screen/fullscreen/robot_hot
	icon = 'local/icons/hud/screen_full.dmi'
	icon_state = "heat_"

/atom/movable/screen/fullscreen/robot_cold
	icon = 'local/icons/hud/screen_full.dmi'
	icon_state = "cold_"

/obj/item/organ/brain/cybernetic/proc/on_login(mob/living/source)
	SIGNAL_HANDLER
	run_updates()

/obj/item/organ/brain/cybernetic/proc/run_updates(instant = FALSE)
	if(power < 0)
		power = 0
	if(power > max_power)
		power = max_power
	handle_hud(owner, instant)
	var/power_left = power / max_power
	var/severity = 0
	var/static_alpha = 0
	switch(power_left)
		if(0.8 to INFINITY)
			severity = 0
		if(0.7 to 0.8)
			severity = 1
		if(0.6 to 0.7) // nice
			severity = 2
		if(0.5 to 0.6)
			severity = 3
		if(0.4 to 0.5)
			severity = 4
			static_alpha = 20
		if(0.3 to 0.4)
			severity = 5
			static_alpha = 60
		if(0.2 to 0.3)
			severity = 6
			static_alpha = 60
		if(0.15 to 0.2)
			severity = 7
			static_alpha = 125
		if(0.1 to 0.15)
			severity = 8
			static_alpha = 200
		if(0.05 to 0.1)
			severity = 9
			static_alpha = 225
		if(-INFINITY to 0.05)
			severity = 10
			static_alpha = 230
	if(severity)
		owner.overlay_fullscreen("power_loss", /atom/movable/screen/fullscreen/oxy, severity)
	else
		owner.clear_fullscreen("power_loss")
	if(static_alpha)
		owner.overlay_fullscreen("power_loss_static", /atom/movable/screen/fullscreen/static_vision/robot, screen_alpha = static_alpha)
	else
		owner.clear_fullscreen("power_loss_static")
	if(power == 0) // no power? dead
		owner.death()
		return
	var/power_deficiency = max_power - power
	if(power_deficiency >= 40)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/robot_power_slowdown, TRUE, multiplicative_slowdown = power_deficiency / 75)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/robot_power_slowdown_flying, TRUE, multiplicative_slowdown = power_deficiency / 25)
	else
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/robot_power_slowdown)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/robot_power_slowdown_flying)

/datum/movespeed_modifier/robot_power_slowdown
	blacklisted_movetypes = FLOATING|FLYING
	variable = TRUE

/datum/movespeed_modifier/robot_power_slowdown_flying
	movetypes = FLYING
	variable = TRUE

/obj/item/organ/brain/cybernetic/proc/drain_power_on_damage(datum/source, damage, damage_type)
	SIGNAL_HANDLER
	power = max(power - (damage * 0.5), 0)
	run_updates(TRUE)

/datum/movespeed_modifier/robot_hot
	blacklisted_movetypes = FLOATING
	variable = TRUE

/datum/movespeed_modifier/robot_cold
	blacklisted_movetypes = FLOATING
	variable = TRUE

/obj/item/organ/brain/cybernetic/proc/temperature_overrides(mob/living/carbon/human/robot, datum/species/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	robot.adjust_bodytemperature(3)
	robot.adjust_coretemperature(3)
	var/old_bodytemp = robot.old_bodytemperature
	var/bodytemp = robot.bodytemperature
	if(bodytemp > source.bodytemp_heat_damage_limit)
		temperature_disparity = bodytemp / BODYTEMP_NORMAL
		robot.remove_movespeed_modifier(/datum/movespeed_modifier/robot_cold)
		robot.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/robot_hot, multiplicative_slowdown = -(((min(robot.bodytemperature, BODYTEMP_HEAT_WARNING_3) - source.bodytemp_heat_damage_limit) / (COLD_SLOWDOWN_FACTOR * 2)) * 0.1))
		robot.overlay_fullscreen("robot_temp_hot", /atom/movable/screen/fullscreen/robot_hot, 1)
		if(bodytemp in source.bodytemp_heat_damage_limit to BODYTEMP_HEAT_WARNING_2)
			robot.throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/hot, 1)
		else if(bodytemp in BODYTEMP_HEAT_WARNING_2 to BODYTEMP_HEAT_WARNING_3)
			robot.overlay_fullscreen("robot_temp_hot", /atom/movable/screen/fullscreen/robot_hot, 2)
			robot.throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/hot, 2)
		else
			robot.overlay_fullscreen("robot_temp_hot", /atom/movable/screen/fullscreen/robot_hot, 3)
			robot.throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/hot, 3)
	else if(bodytemp < source.bodytemp_cold_damage_limit)
		temperature_disparity = BODYTEMP_NORMAL / bodytemp
		robot.remove_movespeed_modifier(/datum/movespeed_modifier/robot_hot)
		robot.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/robot_cold, multiplicative_slowdown = ((source.bodytemp_cold_damage_limit - max(BODYTEMP_COLD_WARNING_3, robot.bodytemperature)) / COLD_SLOWDOWN_FACTOR) * 0.25)
		robot.overlay_fullscreen("robot_temp_cold", /atom/movable/screen/fullscreen/robot_cold, 1)
		if(bodytemp in BODYTEMP_COLD_WARNING_2 to source.bodytemp_cold_damage_limit)
			robot.throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/cold, 1)
		else if(bodytemp in BODYTEMP_COLD_WARNING_3 to BODYTEMP_COLD_WARNING_2)
			robot.overlay_fullscreen("robot_temp_cold", /atom/movable/screen/fullscreen/robot_cold, 2)
			robot.throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/cold, 2)
		else
			owner.overlay_fullscreen("robot_temp_cold", /atom/movable/screen/fullscreen/robot_cold, 3)
			robot.throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/cold, 3)

	else if (old_bodytemp > source.bodytemp_heat_damage_limit || old_bodytemp < source.bodytemp_cold_damage_limit)
		temperature_disparity = 1
		robot.clear_fullscreen("robot_temp_hot")
		robot.clear_fullscreen("robot_temp_cold")
		robot.clear_alert(ALERT_TEMPERATURE)
		robot.remove_movespeed_modifier(/datum/movespeed_modifier/robot_hot)
		robot.remove_movespeed_modifier(/datum/movespeed_modifier/robot_cold)
		robot.clear_mood_event("cold")
		robot.clear_mood_event("hot")
	robot.old_bodytemperature = bodytemp
	return COMSIG_SPECIES_OVERRIDE_TEMPERATURE

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
		if(0.8 to INFINITY) // Give them a bonus for keeping up on their oil!
			if(robot.stat != DEAD && distress_beacon_active)
				deactivate_distress_beacon()
			robot.remove_movespeed_modifier(/datum/movespeed_modifier/robot_low_oil)
			robot.apply_status_effect(/datum/status_effect/oil_fast_click)
			robot.remove_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/no_oil)
		if(0.4 to 0.8) // Take away any bonuses.
			if(robot.stat != DEAD && distress_beacon_active)
				deactivate_distress_beacon()
			robot.remove_movespeed_modifier(/datum/movespeed_modifier/robot_low_oil)
			robot.remove_status_effect(/datum/status_effect/oil_fast_click)
			robot.remove_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/no_oil)
		if(0 to 0.4) // Start slowing their clicking down.
			if(robot.stat != DEAD && distress_beacon_active)
				deactivate_distress_beacon()
			robot.add_movespeed_modifier(/datum/movespeed_modifier/robot_low_oil)
			robot.apply_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/oil_fast_click)
			robot.remove_status_effect(/datum/status_effect/no_oil)
		if(-INFINITY to 0)
			if(!distress_beacon_active)
				activate_distress_beacon()
			robot.remove_movespeed_modifier(/datum/movespeed_modifier/robot_low_oil)
			robot.apply_status_effect(/datum/status_effect/no_oil)
			robot.apply_status_effect(/datum/status_effect/oil_slow_click)
			robot.remove_status_effect(/datum/status_effect/oil_fast_click)

	return HANDLE_BLOOD_HANDLED

/obj/item/organ/brain/cybernetic/proc/calculate_oil_usage()
	var/obj/item/organ/heart/oil_pump/oil_pump = owner.get_organ_slot(ORGAN_SLOT_HEART)
	if(!oil_pump || !istype(oil_pump) || (oil_pump.organ_flags & ORGAN_DEPOWERED) || (oil_pump.organ_flags & ORGAN_FAILING))
		return 5 // no oil pump/depowered? waste the fuck outta oil
	return 1 + (oil_pump.damage / (oil_pump.maxHealth * 2))

/obj/item/organ/brain/cybernetic/proc/drain_oil_movement(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/robot = mover
	if(!istype(robot))
		return
	if(CHECK_MOVE_LOOP_FLAGS(robot, MOVEMENT_LOOP_OUTSIDE_CONTROL))
		return // NOT INTENTIONAL MOVEMENT, DON'T DRAIN OIL
	robot.blood_volume -= ROBOT_OIL_LOSS_ON_STEP * calculate_oil_usage()
	run_updates()

/obj/item/organ/brain/cybernetic/proc/drain_oil_hand_interact(mob/living/carbon/human/source, atom/target, proximity_flag, modifiers)
	SIGNAL_HANDLER
	if(proximity_flag)
		source.blood_volume -= ROBOT_OIL_LOSS_ON_INTERACT * calculate_oil_usage()
	run_updates()
	return NONE

/obj/item/organ/brain/cybernetic/proc/drain_oil_interact(mob/living/source, atom/target, obj/item/weapon, list/modifiers)
	SIGNAL_HANDLER
	source.blood_volume -= ROBOT_OIL_LOSS_ON_INTERACT * calculate_oil_usage()
	run_updates()
	return NONE

/obj/item/organ/brain/cybernetic/proc/medhud_health(mob/living/source)
	SIGNAL_HANDLER
	var/health_calc = (power / max_power) * 100
	var/resulthealth = "health0"
	switch(health_calc)
		if(100 to INFINITY)
			resulthealth = "health100"
		if(90.625 to 100)
			resulthealth = "health93.75"
		if(84.375 to 90.625)
			resulthealth = "health87.5"
		if(78.125 to 84.375)
			resulthealth = "health81.25"
		if(71.875 to 78.125)
			resulthealth = "health75"
		if(65.625 to 71.875)
			resulthealth = "health68.75"
		if(59.375 to 65.625)
			resulthealth = "health62.5"
		if(53.125 to 59.375)
			resulthealth = "health56.25"
		if(46.875 to 53.125)
			resulthealth = "health50"
		if(40.625 to 46.875)
			resulthealth = "health43.75"
		if(34.375 to 40.625)
			resulthealth = "health37.5"
		if(28.125 to 34.375)
			resulthealth = "health31.25"
		if(21.875 to 28.125)
			resulthealth = "health25"
		if(15.625 to 21.875)
			resulthealth = "health18.75"
		if(9.375 to 15.625)
			resulthealth = "health12.5"
		if(1 to 9.375)
			resulthealth = "health6.25"
		if(-INFINITY to 1)
			resulthealth = "health0"
	source.set_hud_image_state(HEALTH_HUD, "hudrobot[resulthealth]")
	return COMSIG_LIVING_MED_HUD_SET_HEALTH_OVERRIDE

/obj/item/organ/brain/cybernetic/proc/medhud_status(mob/living/source)
	SIGNAL_HANDLER
	source.set_hud_image_state(STATUS_HUD, "hudrobot")
	return COMSIG_LIVING_MED_HUD_SET_STATUS_OVERRIDE

/obj/item/organ/brain/cybernetic/proc/allow_revives(mob/living/source)
	SIGNAL_HANDLER
	return COMSIG_LIVING_CAN_REVIVE_OVERRIDE

/obj/item/organ/brain/cybernetic/proc/block_stat_update(mob/living/source)
	SIGNAL_HANDLER
	if(source.stat != DEAD)
		if(HAS_TRAIT_FROM(source, TRAIT_DISSECTED, AUTOPSY_TRAIT))
			REMOVE_TRAIT(source, TRAIT_DISSECTED, AUTOPSY_TRAIT)
		if(HAS_TRAIT(source, TRAIT_KNOCKEDOUT))
			source.set_stat(UNCONSCIOUS)
		else
			source.set_stat(CONSCIOUS)
	source.update_damage_hud()
	source.update_health_hud()
	source.update_stamina_hud()
	source.med_hud_set_status()
	return COMSIG_CARBON_UPDATE_STAT_NO_UPDATE // We only want to die via power loss or manual death causes, not via raw damage, so disable the whole crit system.

/obj/item/organ/brain/cybernetic/on_life(seconds_per_tick, times_fired)
	. = ..()
	power -= (0.0125 * seconds_per_tick) * temperature_disparity
	run_updates()

/obj/item/organ/brain/cybernetic/proc/handle_hud(mob/living/carbon/target, instant = FALSE)
	// update it
	if(power_meter && oil_meter)
		power_meter.update_power_bar(instant)
		oil_meter.update_power_bar() // we don't wanna shake the oil meter
	// initialize it
	else if(target.hud_used)
		var/datum/hud/hud_used = target.hud_used
		if(hud_used.infodisplay.Find(hud_used.healths))
			hud_used.infodisplay -= hud_used.healths
		if(target.mob_mood)
			target.mob_mood.hide_hud()
		power_meter = new(null, hud_used)
		oil_meter = new(null, hud_used)
		hud_used.infodisplay += power_meter
		hud_used.infodisplay += oil_meter
		target.hud_used.show_hud(target.hud_used.hud_version)
		power_meter.update_power_bar()
		oil_meter.update_power_bar()

/obj/item/organ/brain/cybernetic/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	var/datum/hud/hud_used = organ_owner.hud_used
	if(hud_used?.healths)
		hud_used.infodisplay += hud_used.healths
	if(organ_owner.mob_mood)
		organ_owner.mob_mood.show_hud()
	. = ..()

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
