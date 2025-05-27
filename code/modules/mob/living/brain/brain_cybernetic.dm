/obj/item/organ/brain/cybernetic
	name = "cybernetic brain"
	desc = "A mechanical brain found inside of androids. Not to be confused with a positronic brain."
	icon_state = "brain-c"
	organ_flags = ORGAN_ROBOTIC | ORGAN_VITAL
	failing_desc = "seems to be broken, and will not work without repairs."
	var/power = 100
	var/max_power = 100
	var/atom/movable/screen/power_meter/power_meter

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
	/// What state of power loss are we in?
	VAR_PRIVATE/state
	/// How much power is left?
	VAR_PRIVATE/power_left
	/// What icon do we show by the bar
	var/power_source_icon = 'icons/obj/drinks/bottles.dmi'
	/// What icon state do we show by the bar
	var/power_source_icon_state = "beer"
	/// The image shown by the bar.
	VAR_PRIVATE/image/power_source_image
	/// The actual bar
	VAR_PRIVATE/atom/movable/screen/hunger_bar/power/power_meter_bar

/atom/movable/screen/power_meter/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	var/mob/living/robot = hud_owner?.mymob
	if(!istype(robot))
		return

	power_source_image = image(icon = power_source_icon, icon_state = power_source_icon_state, pixel_x = -5)
	power_source_image.plane = plane
	power_source_image.appearance_flags |= KEEP_APART // To be unaffected by filters applied to src
	power_source_image.add_filter("simple_outline", 2, outline_filter(1, COLOR_BLACK, OUTLINE_SHARP))
	underlays += power_source_image // To be below filters applied to src

	// The actual bar
	power_meter_bar = new(src, null)
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
	var/old_power = power_left
	update_power_state()
	if(old_state != state)
		if(state == POWER_STATE_PLUG_IT_IN)
			if(!get_filter("hunger_outline"))
				add_filter("hunger_outline", 1, list("type" = "outline", "color" = "#FF0033", "alpha" = 0, "size" = 2))
				animate(get_filter("hunger_outline"), alpha = 200, time = 1.5 SECONDS, loop = -1)
				animate(alpha = 0, time = 1.5 SECONDS)

		else if(old_state == POWER_STATE_PLUG_IT_IN)
			remove_filter("hunger_outline")

	if(old_power != power_left)
		power_meter_bar.update_fullness(power_left, FALSE)

/atom/movable/screen/hunger_bar/power
	screen_loc = "EAST-1:28,CENTER+1:21"
	icon_state = "powerbar_bar"

/atom/movable/screen/hunger_bar/power/update_fullness(new_fullness, instant)
	if(new_fullness == last_fullness_band)
		return
	last_fullness_band = new_fullness
	var/new_color = gradient(hunger_gradient, clamp(new_fullness, 0, 1.2))
	if(instant)
		color = new_color
	else
		animate(src, color = new_color, 0.5 SECONDS)
	var/old_bar_offset = bar_offset
	bar_offset = clamp(-20 + (20 * new_fullness), -20, 0)
	if(old_bar_offset != bar_offset)
		if(instant || isnull(old_bar_offset))
			add_filter("hunger_bar_mask", 1, alpha_mask_filter(0, bar_offset, bar_mask))
		else
			transition_filter("hunger_bar_mask", alpha_mask_filter(0, bar_offset), 0.5 SECONDS)

#undef POWER_STATE_FULL_CHARGE
#undef POWER_STATE_CHARGED
#undef POWER_STATE_HALF_CHARGED
#undef POWER_STATE_LOW_CHARGE
#undef POWER_STATE_PLUG_IT_IN

/obj/item/organ/brain/cybernetic/on_life(seconds_per_tick, times_fired)
	. = ..()
	power -= 0.025 * seconds_per_tick
	handle_hud(owner)

/obj/item/organ/brain/cybernetic/proc/handle_hud(mob/living/carbon/target)
	// update it
	if(power_meter)
		power_meter.update_power_bar()
	// initialize it
	else if(target.hud_used)
		var/datum/hud/hud_used = target.hud_used
		power_meter = new(null, hud_used)
		hud_used.infodisplay += power_meter
		target.hud_used.show_hud(target.hud_used.hud_version)

/obj/item/organ/brain/cybernetic/Destroy()
	if(power_meter)
		if(owner?.hud_used)
			owner?.hud_used.infodisplay -= power_meter
		qdel(power_meter)
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
