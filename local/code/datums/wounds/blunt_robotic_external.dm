/// The multiplier put against our movement effects if our victim has the determined reagent
#define ROBOTIC_WOUND_DETERMINATION_MOVEMENT_EFFECT_MOD 0.7
/// The multiplier of stagger intensity on hit if our victim has the determined reagent
#define ROBOTIC_WOUND_DETERMINATION_STAGGER_MOVEMENT_MULT 0.7

/// The multiplier put against our movement effects if our limb is grasped
#define ROBOTIC_BLUNT_GRASPED_MOVEMENT_MULT 0.7

/datum/wound/blunt/robotic
	name = "Robotic Blunt (Screws and bolts) Wound"
	wound_flags = (ACCEPTS_GAUZE|CAN_BE_GRASPED)

	default_scar_file = METAL_SCAR_FILE

	/// If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	/// What brain trauma group, if any, we can draw from for head wounds
	var/brain_trauma_group
	/// If we deal brain traumas, when is the next one due?
	var/next_trauma_cycle
	/// How long do we wait +/- 20% for the next trauma?
	var/trauma_cycle_cooldown

	/// The ratio stagger score will be multiplied against for determining the final chance of moving away from the attacker.
	var/stagger_movement_chance_ratio = 1
	/// The ratio stagger score will be multiplied against for determining the amount of pixelshifting we will do when we are hit.
	var/stagger_shake_shift_ratio = 0.05

	/// The ratio of stagger score to shake duration during a stagger() call
	var/stagger_score_to_shake_duration_ratio = 0.1

	/// In the stagger aftershock, the stagger score will be multiplied against for determining the chance of dropping held items.
	var/stagger_drop_chance_ratio = 1.25
	/// In the stagger aftershock, the stagger score will be multiplied against for determining the chance of falling over.
	var/stagger_fall_chance_ratio = 1

	/// In the stagger aftershock, the stagger score will be multiplied against for determining how long we are knocked down for.
	var/stagger_aftershock_knockdown_ratio = 0.5
	/// In the stagger after shock, the stagger score will be multiplied against this (if caused by movement) for determining how long we are knocked down for.
	var/stagger_aftershock_knockdown_movement_ratio = 0.1

	/// If the victim stops moving before the aftershock, aftershock effects will be multiplied against this.
	var/aftershock_stopped_moving_score_mult = 0.1

	/// The ratio damage applied will be multiplied against for determining our stagger score.
	var/chest_attacked_stagger_mult = 2.5
	/// The minimum score an attack must do to trigger a stagger.
	var/chest_attacked_stagger_minimum_score = 5
	/// The ratio of damage to stagger chance on hit.
	var/chest_attacked_stagger_chance_ratio = 2

	/// The base score given to stagger() when we successfully stagger on a move.
	var/base_movement_stagger_score = 30
	/// The base chance of moving to trigger stagger().
	var/chest_movement_stagger_chance = 1

	/// The base duration of a stagger()'s sprite shaking.
	var/base_stagger_shake_duration = 1.5 SECONDS
	/// The base duration of a stagger()'s sprite shaking if caused by movement.
	var/base_stagger_movement_shake_duration = 1.5 SECONDS

	/// The ratio of stagger score to camera shake chance.
	var/stagger_camera_shake_chance_ratio = 0.75
	/// The base duration of a stagger's aftershock's camerashake.
	var/base_aftershock_camera_shake_duration = 1.5 SECONDS
	/// The base strength of a stagger's aftershock's camerashake.
	var/base_aftershock_camera_shake_strength = 0.5

	/// The amount of x and y pixels we will be shaken around by during a movement stagger.
	var/movement_stagger_shift = 1

	/// If we are currently oscillating. If true, we cannot stagger().
	var/oscillating = FALSE

	/// % chance for hitting our limb to fix something.
	var/percussive_maintenance_repair_chance = 10
	/// Damage must be under this to proc percussive maintenance.
	var/percussive_maintenance_damage_max = 7
	/// Damage must be over this to proc percussive maintenance.
	var/percussive_maintenance_damage_min = 0

	/// The time, in world time, that we will be allowed to do another movement shake. Useful because it lets us prioritize attacked shakes over movement shakes.
	var/time_til_next_movement_shake_allowed = 0

	/// The percent our limb must get to max possible damage by burn damage alone to count as malleable if it has no T2 burn wound.
	var/limb_burn_percent_to_max_threshold_for_malleable = 0.8 // must be 75% to max damage by burn damage alone

	/// The last time our victim has moved. Used for determining if we should increase or decrease the chance of having stagger aftershock.
	var/last_time_victim_moved = 0

	processes = TRUE
	/// Whenever an oscillation is triggered by movement, we wait 4 seconds before trying to do another.
	COOLDOWN_DECLARE(movement_stagger_cooldown)


/datum/wound/blunt/robotic/set_victim(new_victim)
	if(victim)
		UnregisterSignal(victim, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(victim, COMSIG_MOB_AFTER_APPLY_DAMAGE)
	if(new_victim)
		RegisterSignal(new_victim, COMSIG_MOVABLE_MOVED, PROC_REF(victim_moved))
		RegisterSignal(new_victim, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(victim_attacked))

	return ..()

/datum/wound/blunt/robotic/get_limb_examine_description()
	return span_warning("This limb looks loosely held together.")

// this wound is unaffected by cryoxadone and pyroxadone
/datum/wound/blunt/robotic/on_xadone(power)
	return

/datum/wound/blunt/robotic/wound_injury(datum/wound/old_wound, attack_direction)
	. = ..()

	// hook into gaining/losing gauze so crit bone wounds can re-enable/disable depending if they're slung or not
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	var/obj/item/held_item = victim.get_item_for_held_index(limb.held_index || 0)
	if(held_item && (disabling || prob(30 * severity)))
		if(istype(held_item, /obj/item/offhand))
			held_item = victim.get_inactive_held_item()
		if(held_item && victim.dropItemToGround(held_item))
			victim.visible_message(span_danger("[victim] drops [held_item] in shock!"), span_warning("<b>The force on your [limb.plaintext_zone] causes you to drop [held_item]!</b>"), vision_distance=COMBAT_MESSAGE_RANGE)

/datum/wound/blunt/robotic/remove_wound(ignore_limb, replaced, destroying)
	. = ..()

	QDEL_NULL(active_trauma)

/datum/wound/blunt/robotic/handle_process(seconds_per_tick, times_fired)
	. = ..()

	if(!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

/// If true, allows our superstructure to be modified if we are T3. RCDs can always fix our superstructure.
/datum/wound/blunt/robotic/proc/limb_malleable()
	if(!isnull(get_overheat_wound()))
		return TRUE
	var/burn_damage_to_max = (limb.burn_dam / limb.max_damage) // only exists for the weird case where it cant get a overheat wound
	if(burn_damage_to_max >= limb_burn_percent_to_max_threshold_for_malleable)
		return TRUE
	return FALSE

/// If we have one, returns a robotic overheat wound of severe severity or higher. Null otherwise.
/datum/wound/blunt/robotic/proc/get_overheat_wound()
	RETURN_TYPE(/datum/wound/burn/robotic/overheat)
	for(var/datum/wound/found_wound as anything in limb.wounds)
		var/datum/wound_pregen_data/pregen_data = found_wound.get_pregen_data()
		if(pregen_data.wound_series == WOUND_SERIES_METAL_BURN_OVERHEAT && found_wound.severity >= WOUND_SEVERITY_MODERATE) // meh solution but whateva
			return found_wound
	return null

/// If our victim is lying down and is attacked in the chest, effective oscillation damage is multiplied against this.
#define OSCILLATION_ATTACKED_LYING_DOWN_EFFECT_MULT 0.5

/// If the attacker is wearing a diag hud, chance of percussive maintenance succeeding is multiplied against this.
#define PERCUSSIVE_MAINTENANCE_DIAG_HUD_CHANCE_MULT 1.5
/// If our wound has been scanned by a wound analyzer, chance of percussive maintenance succeeding is multiplied against this.
#define PERCUSSIVE_MAINTENANCE_WOUND_SCANNED_CHANCE_MULT 1.5
/// If the attacker is NOT our victim, chance of percussive maintenance succeeding is multiplied against this.
#define PERCUSSIVE_MAINTENANCE_ATTACKER_NOT_VICTIM_CHANCE_MULT 2.5

/// Signal handler proc to when our victim has damage applied via apply_damage(), which is a external attack.
/datum/wound/blunt/robotic/proc/victim_attacked(datum/source, damage, damagetype, def_zone, blocked, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(def_zone != limb.body_zone) // use this proc since receive damage can also be called for like, chems and shit
		return
	if(!victim)
		return

	var/effective_damage = (damage - blocked)

	var/obj/item/stack/gauze = limb.current_gauze
	if(gauze)
		effective_damage *= gauze.splint_factor

	switch(limb.body_zone)
		if(BODY_ZONE_CHEST)
			var/oscillation_mult = 1
			if(victim.body_position == LYING_DOWN)
				oscillation_mult *= OSCILLATION_ATTACKED_LYING_DOWN_EFFECT_MULT
			var/oscillation_damage = effective_damage
			var/stagger_damage = oscillation_damage * chest_attacked_stagger_mult
			if(victim.has_status_effect(/datum/status_effect/determined))
				oscillation_damage *= ROBOTIC_WOUND_DETERMINATION_STAGGER_MOVEMENT_MULT
			if((stagger_damage >= chest_attacked_stagger_minimum_score) && prob(oscillation_damage * chest_attacked_stagger_chance_ratio))
				stagger(stagger_damage * oscillation_mult, attack_direction, attacking_item, shift = stagger_damage * stagger_shake_shift_ratio)

	if(!uses_percussive_maintenance() || damage < percussive_maintenance_damage_min || damage > percussive_maintenance_damage_max || damagetype != BRUTE || sharpness)
		return
	var/success_chance_mult = 1
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		success_chance_mult *= PERCUSSIVE_MAINTENANCE_WOUND_SCANNED_CHANCE_MULT
	var/mob/living/user
	if(isatom(attacking_item))
		var/atom/attacking_atom = attacking_item
		user = attacking_atom.loc // nullable
		if(istype(user))
			if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
				success_chance_mult *= PERCUSSIVE_MAINTENANCE_DIAG_HUD_CHANCE_MULT

		if(user != victim)
			success_chance_mult *= PERCUSSIVE_MAINTENANCE_ATTACKER_NOT_VICTIM_CHANCE_MULT // encourages people to get other people to beat the shit out of their limbs
	if(prob(percussive_maintenance_repair_chance * success_chance_mult))
		handle_percussive_maintenance_success(attacking_item, user)
	else
		handle_percussive_maintenance_failure(attacking_item, user)

#undef OSCILLATION_ATTACKED_LYING_DOWN_EFFECT_MULT
#undef PERCUSSIVE_MAINTENANCE_DIAG_HUD_CHANCE_MULT
#undef PERCUSSIVE_MAINTENANCE_WOUND_SCANNED_CHANCE_MULT
#undef PERCUSSIVE_MAINTENANCE_ATTACKER_NOT_VICTIM_CHANCE_MULT

/// The percent, in decimal, of a stagger's shake() duration, that will be used in a addtimer() to queue aftershock().
#define STAGGER_PERCENT_OF_SHAKE_DURATION_TO_AFTERSHOCK_DELAY 0.65 // 1 = happens at the end, .5 = happens halfway through

/// Causes an oscillation, which 1. has a chance to move our victim away from the attacker, and 2. after a delay, calls aftershock().
/datum/wound/blunt/robotic/proc/stagger(stagger_score, attack_direction, obj/item/attacking_item, from_movement, shake_duration = base_stagger_shake_duration, shift, knockdown_ratio = stagger_aftershock_knockdown_ratio)
	if(oscillating)
		return

	var/self_message = "Your [limb.plaintext_zone] oscillates"
	var/message = "[victim]'s [limb.plaintext_zone] oscillates"
	if(attacking_item)
		message += " from the impact"
	else if(from_movement)
		message += " from the movement"
	message += "!"
	self_message += "! You might be able to avoid an aftershock by stopping and waiting..."

	if(isnull(attack_direction) && !isnull(attacking_item))
		attack_direction = get_dir(victim, attacking_item)

	if(!isnull(attack_direction) && prob(stagger_score * stagger_movement_chance_ratio))
		to_chat(victim, span_warning("The force of the blow sends you reeling!"))
		var/turf/target_loc = get_step(victim, attack_direction)
		victim.Move(target_loc)

	victim.visible_message(span_warning(message), ignored_mobs = victim)
	to_chat(victim, span_warning(self_message))
	victim.balloon_alert(victim, "oscillation! stop moving")

	victim.Shake(pixelshiftx = shift, pixelshifty = shift, duration = shake_duration)
	var/aftershock_delay = (shake_duration * STAGGER_PERCENT_OF_SHAKE_DURATION_TO_AFTERSHOCK_DELAY)
	var/knockdown_time = stagger_score * knockdown_ratio
	addtimer(CALLBACK(src, PROC_REF(aftershock), stagger_score, attack_direction, attacking_item, world.time, knockdown_time), aftershock_delay)
	oscillating = TRUE

#undef STAGGER_PERCENT_OF_SHAKE_DURATION_TO_AFTERSHOCK_DELAY

#define AFTERSHOCK_GRACE_THRESHOLD_PERCENT 0.33 // lower mult = later grace period = more forgiving

/**
 * Timer proc from stagger().
 *
 * Based on chance, causes items to be dropped, knockdown to be applied, and/or screenshake to occur.
 * Chance is massively reduced if the victim isn't moving.
 */
/datum/wound/blunt/robotic/proc/aftershock(stagger_score, attack_direction, obj/item/attacking_item, stagger_starting_time, knockdown_time)
	if(!still_exists())
		return FALSE

	var/message = "The oscillations from your [limb.plaintext_zone] spread, "
	var/limb_message = "causing "
	var/limb_affected

	var/stopped_moving_grace_threshold = (world.time - ((world.time - stagger_starting_time) * AFTERSHOCK_GRACE_THRESHOLD_PERCENT))
	var/victim_stopped_moving = (last_time_victim_moved <= stopped_moving_grace_threshold)
	if(victim_stopped_moving)
		stagger_score *= aftershock_stopped_moving_score_mult

	if(prob(stagger_score * stagger_drop_chance_ratio))
		limb_message += "your <b>hands</b>"
		victim.drop_all_held_items()
		limb_affected = TRUE

	if(prob(stagger_score * stagger_fall_chance_ratio))
		if(limb_affected)
			limb_message += " and "
		limb_message += "your <b>legs</b>"
		victim.Knockdown(knockdown_time)
		limb_affected = TRUE

	if(prob(stagger_score * stagger_camera_shake_chance_ratio))
		if(limb_affected)
			limb_message += " and "
		limb_message += "your <b>head</b>"
		shake_camera(victim, base_aftershock_camera_shake_duration, base_aftershock_camera_shake_strength)
		limb_affected = TRUE

	if(limb_affected)
		message += "[limb_message] to shake uncontrollably!"
	else
		message += "but pass harmlessly"
		if(victim_stopped_moving)
			message += " thanks to your stillness"
		message += "."

	to_chat(victim, span_danger(message))
	victim.balloon_alert(victim, "oscillation over")

	oscillating = FALSE

#undef AFTERSHOCK_GRACE_THRESHOLD_PERCENT

/// Called when percussive maintenance succeeds at its random roll.
/datum/wound/blunt/robotic/proc/handle_percussive_maintenance_success(attacking_item, mob/living/user)
	victim.visible_message(span_green("[victim]'s [limb.plaintext_zone] rattles from the impact, but looks a lot more secure!"), \
		span_green("Your [limb.plaintext_zone] rattles into place!"))
	remove_wound()

/// Called when percussive maintenance fails at its random roll.
/datum/wound/blunt/robotic/proc/handle_percussive_maintenance_failure(attacking_item, mob/living/user)
	to_chat(victim, span_warning("Your [limb.plaintext_zone] rattles around, but you don't sense any sign of improvement."))

/// If our victim has no gravity, the effects of movement are multiplied by this.
#define VICTIM_MOVED_NO_GRAVITY_EFFECT_MULT 0.5
/// If our victim is resting, or is walking and isnt forced to move, the effects of movement are multiplied by this.
#define VICTIM_MOVED_CAREFULLY_EFFECT_MULT 0.25

/// Signal handler proc that applies movements affect to our victim if they were moved.
/datum/wound/blunt/robotic/proc/victim_moved(datum/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	var/overall_mult = 1

	var/obj/item/stack/gauze = limb.current_gauze
	if(gauze)
		overall_mult *= gauze.splint_factor
	if(!victim.has_gravity(get_turf(victim)))
		overall_mult *= VICTIM_MOVED_NO_GRAVITY_EFFECT_MULT
	else if(victim.body_position == LYING_DOWN || (!forced && victim.move_intent == MOVE_INTENT_WALK))
		overall_mult *= VICTIM_MOVED_CAREFULLY_EFFECT_MULT
	if(victim.has_status_effect(/datum/status_effect/determined))
		overall_mult *= ROBOTIC_WOUND_DETERMINATION_MOVEMENT_EFFECT_MOD
	if(limb.grasped_by)
		overall_mult *= ROBOTIC_BLUNT_GRASPED_MOVEMENT_MULT

	overall_mult *= get_buckled_movement_consequence_mult(victim.buckled)

	if(limb.body_zone == BODY_ZONE_CHEST && COOLDOWN_FINISHED(src, movement_stagger_cooldown))
		var/stagger_chance = chest_movement_stagger_chance * overall_mult
		if(prob(stagger_chance))
			COOLDOWN_START(src, movement_stagger_cooldown, 4 SECONDS)
			stagger(base_movement_stagger_score, shake_duration = base_stagger_movement_shake_duration, from_movement = TRUE, shift = movement_stagger_shift, knockdown_ratio = stagger_aftershock_knockdown_movement_ratio)

	last_time_victim_moved = world.time

#undef VICTIM_MOVED_NO_GRAVITY_EFFECT_MULT
#undef VICTIM_MOVED_CAREFULLY_EFFECT_MULT

/// If our victim is buckled to a generic object, movement effects will be multiplied against this.
#define VICTIM_BUCKLED_BASE_MOVEMENT_EFFECT_MULT 0.5
/// If our victim is buckled to a medical bed (e.g. rollerbed), movement effects will be multiplied against this.
#define VICTIM_BUCKLED_ROLLER_BED_MOVEMENT_EFFECT_MULT 0.05

/// Returns a multiplier to our movement effects based on what our victim is buckled to.
/datum/wound/blunt/robotic/proc/get_buckled_movement_consequence_mult(atom/movable/buckled_to)
	if(!buckled_to)
		return 1

	if(istype(buckled_to, /obj/structure/bed/medical))
		return VICTIM_BUCKLED_ROLLER_BED_MOVEMENT_EFFECT_MULT
	else
		return VICTIM_BUCKLED_BASE_MOVEMENT_EFFECT_MULT

#undef VICTIM_BUCKLED_BASE_MOVEMENT_EFFECT_MULT
#undef VICTIM_BUCKLED_ROLLER_BED_MOVEMENT_EFFECT_MULT

/// If this wound can be treated in its current state by just hitting it with a low force object. Exists for conditional logic, e.g. "Should we respond
/// to percussive maintenance right now?". Critical blunt uses this to only react when the limb is malleable and superstructure is broken.
/datum/wound/blunt/robotic/proc/uses_percussive_maintenance()
	return FALSE

#undef ROBOTIC_WOUND_DETERMINATION_MOVEMENT_EFFECT_MOD
#undef ROBOTIC_WOUND_DETERMINATION_STAGGER_MOVEMENT_MULT

#undef ROBOTIC_BLUNT_GRASPED_MOVEMENT_MULT

/datum/wound/blunt/robotic/moderate
	name = "Loosened Screws"
	desc = "Various semi-external fastening instruments have loosened, causing components to jostle, inhibiting limb control."
	treat_text_short = "Use a screwdriver on the affected limb, use gauze to reduce negative effects."
	treat_text = "Recommend topical re-fastening of instruments with a screwdriver, though percussive maintenance via low-force bludgeoning may suffice - \
	albeit at risk of worsening the injury."
	examine_desc = "appears to be loosely secured"
	occur_text = "jostles awkwardly and seems to slightly unfasten"
	severity = WOUND_SEVERITY_MODERATE
	simple_treat_text = "<b>Bandaging</b> the wound will reduce the impact until its <b>screws are secured</b> - which is <b>faster</b> if done by \
	<b>someone else</b>, a <b>roboticist</b>, an <b>engineer</b>, or with a <b>diagnostic HUD</b>."
	homemade_treat_text = "In a pinch, <b>percussive maintenance</b> can reset the screws - the chance of which is increased if done by <b>someone else</b> or \
	with a <b>diagnostic HUD</b>!"
	status_effect_type = /datum/status_effect/wound/blunt/robotic/moderate
	treatable_tools = list(TOOL_SCREWDRIVER)
	interaction_efficiency_penalty = 1.2
	limp_slowdown = 2.5
	limp_chance = 30
	threshold_penalty = 20
	can_scar = FALSE
	a_or_from = "from"

/datum/wound_pregen_data/blunt_metal/loose_screws
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/moderate
	viable_zones = list(BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	threshold_minimum = 30

/datum/wound/blunt/robotic/moderate/uses_percussive_maintenance()
	return TRUE

/datum/wound/blunt/robotic/moderate/treat(obj/item/potential_treater, mob/user)
	if(potential_treater.tool_behaviour == TOOL_SCREWDRIVER)
		fasten_screws(potential_treater, user)
		return TRUE

	return ..()

/// The main treatment for T1 blunt. Uses a screwdriver, guaranteed to always work, better with a diag hud. Removes the wound.
/datum/wound/blunt/robotic/moderate/proc/fasten_screws(obj/item/screwdriver_tool, mob/user)
	if(!screwdriver_tool.tool_start_check())
		return

	var/delay_mult = 1

	if(user == victim)
		delay_mult *= 2

	if(HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		delay_mult *= 0.5

	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.5

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	victim.visible_message(span_notice("[user] begins fastening the screws of [their_or_other] [limb.plaintext_zone]..."), \
		span_notice("You begin fastening the screws of [your_or_other] [limb.plaintext_zone]..."))

	if(!screwdriver_tool.use_tool(target = victim, user = user, delay = (6 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	victim.visible_message(span_green("[user] finishes fastening [their_or_other] [limb.plaintext_zone]!"), \
		span_green("You finish fastening [your_or_other] [limb.plaintext_zone]!"))

	remove_wound()

/datum/wound/blunt/robotic/secures_internals/severe
	name = "Detached Fastenings"
	desc = "Various fastening devices are extremely loose and solder has disconnected at multiple points, causing significant jostling of internal components and \
	noticable limb dysfunction."
	treat_text_short = "Repair surgically, start with a screwdriver and follow the instructions, use gauze to reduce negative effects."
	treat_text = "Fastening of bolts and screws by a qualified technician (though bone gel may suffice in the absence of one) followed by re-soldering."
	examine_desc = "jostles with every move, solder visibly broken"
	occur_text = "visibly cracks open, solder flying everywhere"
	severity = WOUND_SEVERITY_SEVERE

	simple_treat_text = "<b>If on the <b>chest</b>, <b>walk</b>, <b>grasp it</b>, <b>splint</b>, <b>rest</b> or <b>buckle yourself</b> to something to reduce movement effects. \
	Afterwards, get <b>someone else</b>, ideally a <b>robo/engi</b> to <b>screwdriver/wrench</b> it, and then <b>re-solder it</b>!"
	homemade_treat_text = "If <b>unable to screw/wrench</b>, <b>bone gel</b> can, over time, secure inner components at risk of <b>corrossion</b>. \
	Alternatively, <b>crowbar</b> the limb open to expose the internals - this will make it <b>easier</b> to re-secure them, but has a <b>high risk</b> of <b>shocking</b> you, \
	so use insulated gloves. This will <b>cripple the limb</b>, so use it only as a last resort!"

	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|CAN_BE_GRASPED)
	treatable_by = list(/obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/robotic/severe
	treatable_tools = list(TOOL_WELDER, TOOL_CROWBAR)

	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60

	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 1.5 MINUTES

	threshold_penalty = 40

	base_movement_stagger_score = 40

	chest_attacked_stagger_chance_ratio = 5
	chest_attacked_stagger_mult = 3

	chest_movement_stagger_chance = 2

	stagger_aftershock_knockdown_ratio = 0.3
	stagger_aftershock_knockdown_movement_ratio = 0.2

	a_or_from = "from"

	ready_to_secure_internals = TRUE
	ready_to_resolder = FALSE

	scar_keyword = "bluntsevere"

/datum/wound_pregen_data/blunt_metal/fastenings
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/severe

	threshold_minimum = 65

/datum/wound/blunt/robotic/secures_internals/critical
	name = "Collapsed Superstructure"
	desc = "The superstructure has totally collapsed in one or more locations, causing extreme internal oscillation with every move and massive limb dysfunction"
	treat_text_short = "THIS TEXT WAS GARBAGE USELESS AND SHOULD BE REPLACED WITH ACTUAL SHORT TEXT ON HOW TO TREAT THE WOUND"
	treat_text = "Reforming of superstructure via either RCD or manual molding, followed by typical treatment of loosened internals. \
				To manually mold, the limb must be aggressively grabbed and welded held to it to make it malleable (though attacking it til thermal overload may be adequate) \
				followed by firmly grasping and molding the limb with heat-resistant gloves."
	occur_text = "caves in on itself, damaged solder and shrapnel flying out in a miniature explosion"
	examine_desc = "has caved in, with internal components visible through gaps in the metal"
	severity = WOUND_SEVERITY_CRITICAL

	disabling = TRUE

	simple_treat_text = "If on the <b>chest</b>, <b>walk</b>, <b>grasp it</b>, <b>splint</b>, <b>rest</b> or <b>buckle yourself</b> to something to reduce movement effects. \
	Afterwards, get someone, ideally a <b>robo/engi</b> to <b>firmly grasp</b> the limb and hold a <b>welder</b> to it. Then, have them <b>use their hands</b> to <b>mold the metal</b> - \
	careful though, it's <b>hot</b>! An <b>RCD</b> can skip all this, but is hard to come by. Afterwards, have them <b>screw/wrench</b> and then <b>re-solder</b> the limb!"

	homemade_treat_text = "The metal can be made <b>malleable</b> by repeated application of a welder, to a <b>severe burn</b>. Afterwards, a <b>plunger</b> can reset the metal, \
	as can <b>percussive maintenance</b>. After the metal is reset, if <b>unable to screw/wrench</b>, <b>bone gel</b> can, over time, secure inner components at risk of <b>corrossion</b>. \
	Alternatively, <b>crowbar</b> the limb open to expose the internals - this will make it <b>easier</b> to re-secure them, but has a <b>high risk</b> of <b>shocking</b> you, \
	so use insulated gloves. This will <b>cripple the limb</b>, so use it only as a last resort!"

	interaction_efficiency_penalty = 2.8
	limp_slowdown = 8
	limp_chance = 80
	threshold_penalty = 60

	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 2.5 MINUTES

	scar_keyword = "bluntcritical"

	status_effect_type = /datum/status_effect/wound/blunt/robotic/critical

	sound_effect = 'sound/effects/wounds/crack2.ogg'

	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|CAN_BE_GRASPED)
	treatable_by = list(/obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/robotic/critical
	treatable_tools = list(TOOL_WELDER, TOOL_CROWBAR)

	base_movement_stagger_score = 50

	base_aftershock_camera_shake_duration = 1.75 SECONDS
	base_aftershock_camera_shake_strength = 1

	chest_attacked_stagger_chance_ratio = 6.5
	chest_attacked_stagger_mult = 4

	chest_movement_stagger_chance = 8

	aftershock_stopped_moving_score_mult = 0.3

	stagger_aftershock_knockdown_ratio = 0.5
	stagger_aftershock_knockdown_movement_ratio = 0.3

	percussive_maintenance_repair_chance = 3
	percussive_maintenance_damage_max = 6

	regen_time_needed = 60 SECONDS
	gel_damage = 20

	ready_to_secure_internals = FALSE
	ready_to_resolder = FALSE

	a_or_from = "a"

	/// Has the first stage of our treatment been completed? E.g. RCDed, manually molded...
	var/superstructure_remedied = FALSE

/datum/wound_pregen_data/blunt_metal/superstructure
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/critical
	threshold_minimum = 125

/datum/wound/blunt/robotic/secures_internals/critical/item_can_treat(obj/item/potential_treater)
	if(!superstructure_remedied)
		if(istype(potential_treater, /obj/item/construction/rcd))
			return TRUE
		if(limb_malleable() && istype(potential_treater, /obj/item/plunger))
			return TRUE
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/check_grab_treatments(obj/item/potential_treater, mob/user)
	if(potential_treater.tool_behaviour == TOOL_WELDER && (!superstructure_remedied && !limb_malleable()))
		return TRUE
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/treat(obj/item/item, mob/user)
	if(!superstructure_remedied)
		if(istype(item, /obj/item/construction/rcd))
			return rcd_superstructure(item, user)
		if(uses_percussive_maintenance() && istype(item, /obj/item/plunger))
			return plunge(item, user)
		if(item.tool_behaviour == TOOL_WELDER && !limb_malleable() && isliving(victim.pulledby))
			var/mob/living/living_puller = victim.pulledby
			if (living_puller.grab_state >= GRAB_AGGRESSIVE) // only let other people do this
				return heat_metal(item, user)
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone)
		return FALSE

	if(superstructure_remedied || !limb_malleable())
		return FALSE

	if(user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("You must have [victim] in an aggressive grab to manipulate [victim.p_their()] [LOWER_TEXT(name)]!"))
		return TRUE

	user.visible_message(span_danger("[user] begins softly pressing against [victim]'s collapsed [limb.plaintext_zone]..."), \
	span_notice("You begin softly pressing against [victim]'s collapsed [limb.plaintext_zone]..."), \
	ignored_mobs = victim)
	to_chat(victim, span_userdanger("[user] begins pressing against your collapsed [limb.plaintext_zone]!"))

	var/delay_mult = 1
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if(!do_after(user, 4 SECONDS, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return
	mold_metal(user)
	return TRUE

/// If the user turns combat mode on after they start to mold metal, our limb takes this much brute damage.
#define MOLD_METAL_SABOTAGE_BRUTE_DAMAGE 30 // really punishing
/// Our limb takes this much brute damage on a failed mold metal attempt.
#define MOLD_METAL_FAILURE_BRUTE_DAMAGE 5
/// If the user's hand is unprotected from heat when they mold metal, we do this much burn damage to it.
#define MOLD_METAL_HAND_BURNT_BURN_DAMAGE 5
/// Gloves must be above or at this threshold to cause the user to not be burnt apon trying to mold metal.
#define MOLD_METAL_HEAT_RESISTANCE_THRESHOLD 1000 // less than the black gloves max resist
/**
 * Standard treatment for 1st step of T3, after the limb has been made malleable. Done via aggrograb.
 * High chance to work, very high with robo/engi wires and diag hud.
 * Can be sabotaged by switching to combat mode.
 * Deals brute to the limb on failure.
 * Burns the hand of the user if it's not insulated.
 */
/datum/wound/blunt/robotic/secures_internals/critical/proc/mold_metal(mob/living/carbon/human/user)
	var/chance = 60

	var/knows_wires = FALSE
	if(HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		chance *= 2
		knows_wires = TRUE
	else if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		chance *= 1.25
		knows_wires = TRUE
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		chance *= 2
	if(HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if(knows_wires)
			chance *= 1.25
		else
			chance *= 2

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")

	if((user != victim && user.combat_mode))
		user.visible_message(span_bolddanger("[user] molds [their_or_other] [limb.plaintext_zone] into a really silly shape! What a goofball!"), \
			span_danger("You maliciously mold [victim]'s [limb.plaintext_zone] into a weird shape, damaging it in the process!"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] molds your [limb.plaintext_zone] into a weird shape, damaging it in the process!"))

		limb.receive_damage(brute = MOLD_METAL_SABOTAGE_BRUTE_DAMAGE, wound_bonus = CANT_WOUND, damage_source = user)
	else if(prob(chance))
		user.visible_message(span_green("[user] carefully molds [their_or_other] [limb.plaintext_zone] into the proper shape!"), \
			span_green("You carefully mold [victim]'s [limb.plaintext_zone] into the proper shape!"), ignored_mobs = victim)
		to_chat(victim, span_green("[user] carefully molds your [limb.plaintext_zone] into the proper shape!"))
		to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone] has been molded into the proper shape! Your next step is to use a screwdriver/wrench to secure your internals."))
		set_superstructure_status(TRUE)
	else
		user.visible_message(span_danger("[user] accidentally molds [their_or_other] [limb.plaintext_zone] into the wrong shape!"), \
			span_danger("You accidentally mold [your_or_other] [limb.plaintext_zone] into the wrong shape!"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] accidentally molds your [limb.plaintext_zone] into the wrong shape!"))

		limb.receive_damage(brute = MOLD_METAL_FAILURE_BRUTE_DAMAGE, damage_source = user, wound_bonus = CANT_WOUND)

	var/sufficiently_insulated_gloves = FALSE
	var/obj/item/clothing/gloves/worn_gloves = user.gloves
	if((worn_gloves?.heat_protection & HANDS) && worn_gloves?.max_heat_protection_temperature && worn_gloves.max_heat_protection_temperature >= MOLD_METAL_HEAT_RESISTANCE_THRESHOLD)
		sufficiently_insulated_gloves = TRUE

	if(sufficiently_insulated_gloves || HAS_TRAIT(user, TRAIT_RESISTHEAT) || HAS_TRAIT(user, TRAIT_RESISTHEATHANDS))
		return

	to_chat(user, span_danger("You burn your hand on [victim]'s [limb.plaintext_zone]!"))
	var/obj/item/bodypart/affecting = user.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	affecting?.receive_damage(burn = MOLD_METAL_HAND_BURNT_BURN_DAMAGE, damage_source = limb)

#undef MOLD_METAL_SABOTAGE_BRUTE_DAMAGE
#undef MOLD_METAL_FAILURE_BRUTE_DAMAGE
#undef MOLD_METAL_HAND_BURNT_BURN_DAMAGE
#undef MOLD_METAL_HEAT_RESISTANCE_THRESHOLD

/**
 * A "safe" way to give our victim a T2 burn wound. Requires an aggrograb, and a welder. This is required to mold metal, the 1st step of treatment.
 * Guaranteed to work. After a delay, causes a T2 burn wound with no damage.
 * Can be sabotaged by enabling combat mode to cause a T3.
 */
/datum/wound/blunt/robotic/secures_internals/critical/proc/heat_metal(obj/item/welder, mob/living/user)
	if(!welder.tool_use_check())
		return TRUE

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")

	user?.visible_message(span_danger("[user] carefully holds [welder] to [their_or_other] [limb.plaintext_zone], slowly heating it..."), \
		span_warning("You carefully hold [welder] to [your_or_other] [limb.plaintext_zone], slowly heating it..."), ignored_mobs = victim)

	var/delay_mult = 1
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if(!welder.use_tool(target = victim, user = user, delay = 3 SECONDS * delay_mult, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/wound_path = /datum/wound/burn/robotic/overheat/moderate
	if(user != victim && user.combat_mode)
		wound_path = /datum/wound/burn/robotic/overheat/critical // it really isnt that bad, overheat wounds are a bit funky
		user.visible_message(span_danger("[user] heats [victim]'s [limb.plaintext_zone] aggressively, overheating it far beyond the necessary point!"), \
			span_danger("You heat [victim]'s [limb.plaintext_zone] aggressively, overheating it far beyond the necessary point!"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] heats your [limb.plaintext_zone] aggressively, overheating it far beyond the necessary point!"))

	var/datum/wound/burn/robotic/overheat/overheat_wound = new wound_path
	overheat_wound.apply_wound(limb, wound_source = welder)

	to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone] is now heated, allowing it to be molded! Your next step is to have someone physically reset the superstructure with their hands."))
	return TRUE

/// Cost of an RCD to quickly fix our broken in raw matter
#define ROBOTIC_T3_BLUNT_WOUND_RCD_COST 25
/// Cost of an RCD to quickly fix our broken in silo material
#define ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST ROBOTIC_T3_BLUNT_WOUND_RCD_COST / 4

/// The "premium" treatment for 1st step of T3. Requires an RCD. Guaranteed to work, but can cause damage if delay is high.
/datum/wound/blunt/robotic/secures_internals/critical/proc/rcd_superstructure(obj/item/construction/rcd/treating_rcd, mob/user)
	if(!treating_rcd.tool_use_check())
		return TRUE

	var/has_enough_matter = (treating_rcd.get_matter(user) > ROBOTIC_T3_BLUNT_WOUND_RCD_COST)
	var/silo_has_enough_materials = (treating_rcd.get_silo_iron() > ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST)

	if(!silo_has_enough_materials && !has_enough_matter) // neither the silo, nor the rcd, has enough
		user?.balloon_alert(user, "not enough matter!")
		return TRUE

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")

	var/base_time = 7 SECONDS
	var/delay_mult = 1
	var/knows_wires = FALSE
	if(victim == user)
		delay_mult *= 2
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75
	if(HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= 0.5
		knows_wires = TRUE
	else if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= 0.5 // engis are accustomed to using RCDs
		knows_wires = TRUE
	if(HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if(knows_wires)
			delay_mult *= 0.85
		else
			delay_mult *= 0.5

	var/final_time = (base_time * delay_mult)
	var/misused = (final_time > base_time) // if we damage the limb when we're done

	if(user)
		var/misused_text = (misused ? "<b>unsteadily</b> " : "")

		var/message = "[user]'s RCD whirs to life as it begins [misused_text]replacing the damaged superstructure of [their_or_other] [limb.plaintext_zone]..."
		var/self_message = "Your RCD whirs to life as it begins [misused_text]replacing the damaged superstructure of [your_or_other] [limb.plaintext_zone]..."

		if(misused) // warning span if misused, notice span otherwise
			message = span_danger(message)
			self_message = span_danger(self_message)
		else
			message = span_notice(message)
			self_message = span_notice(self_message)

		user.visible_message(message, self_message)

	if(!treating_rcd.use_tool(target = victim, user = user, delay = final_time, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE
	playsound(get_turf(treating_rcd), 'sound/machines/ping.ogg', 75) // celebration! we did it
	set_superstructure_status(TRUE)

	var/use_amount = (silo_has_enough_materials ? ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST : ROBOTIC_T3_BLUNT_WOUND_RCD_COST)
	if(!treating_rcd.useResource(use_amount, user))
		return TRUE

	if(user)
		var/misused_text = (misused ? ", though it replaced a bit more than it should've..." : "!")
		var/message = "[user]'s RCD lets out a small ping as it finishes replacing the superstructure of [their_or_other] [limb.plaintext_zone][misused_text]"
		var/self_message = "Your RCD lets out a small ping as it finishes replacing the superstructure of [your_or_other] [limb.plaintext_zone][misused_text]"
		if(misused)
			message = span_danger(message)
			self_message = span_danger(self_message)
		else
			message = span_green(message)
			self_message = span_green(self_message)

		user.visible_message(message, self_message)
		if(misused)
			limb.receive_damage(brute = 10, damage_source = treating_rcd, wound_bonus = CANT_WOUND)
		// the double message is fine here, since the first message also tells you if you fucked up and did some damage
		to_chat(user, span_green("The superstructure has been reformed! Your next step is to secure the internals via a screwdriver/wrench."))
	return TRUE

#undef ROBOTIC_T3_BLUNT_WOUND_RCD_COST
#undef ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST

/**
 * Goofy but practical, this is the superior ghetto self-tend of T3's first step compared to percussive maintenance.
 * Still requires the limb to be malleable, but has a high chance of success and doesn't burn your hand, but gives worse bonuses for wires/HUD.
 */
/datum/wound/blunt/robotic/secures_internals/critical/proc/plunge(obj/item/plunger/treating_plunger, mob/user)
	if(!treating_plunger.tool_use_check())
		return TRUE

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	user?.visible_message(span_notice("[user] begins plunging at the dents on [their_or_other] [limb.plaintext_zone] with [treating_plunger]..."), \
		span_green("You begin plunging at the dents on [your_or_other] [limb.plaintext_zone] with [treating_plunger]..."))

	var/delay_mult = 1
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	delay_mult /= treating_plunger.plunge_mod

	if(!treating_plunger.use_tool(target = victim, user = user, delay = 6 SECONDS * delay_mult, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/success_chance = 80
	if(victim == user)
		success_chance *= 0.6

	if(HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		success_chance *= 1.25
	else if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		success_chance *= 1.1
	if(HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		success_chance *= 1.25 // it's kinda alien to do this, so even people with the wires get the full bonus of diag huds
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		success_chance *= 1.5

	if(prob(success_chance))
		user?.visible_message(span_green("[victim]'s [limb.plaintext_zone] lets out a sharp POP as [treating_plunger] forces it into its normal position!"), \
			span_green("[victim]'s [limb.plaintext_zone] lets out a sharp POP as your [treating_plunger] forces it into its normal position!"))
		to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone]'s structure has been reset to its proper position! Your next step is to secure it with a screwdriver/wrench, though bone gel would also work."))
		set_superstructure_status(TRUE)
	else
		user?.visible_message(span_danger("[victim]'s [limb.plaintext_zone] splinters from [treating_plunger]'s plunging!"), \
			span_danger("[capitalize(your_or_other)] [limb.plaintext_zone] splinters from your [treating_plunger]'s plunging!"))
		limb.receive_damage(brute = 5, damage_source = treating_plunger)

	return TRUE

/datum/wound/blunt/robotic/secures_internals/critical/handle_percussive_maintenance_success(attacking_item, mob/living/user)
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	victim.visible_message(span_green("[victim]'s [limb.plaintext_zone] gets smashed into a proper shape!"), \
		span_green("Your [limb.plaintext_zone] gets smashed into a proper shape!"))

	var/user_message = "[capitalize(your_or_other)] [limb.plaintext_zone]'s superstructure has been reset! Your next step is to screwdriver/wrench the internals, \
	though if you're desperate enough to use percussive maintenance, you might want to either use a crowbar or bone gel..."
	to_chat(user, span_green(user_message))

	set_superstructure_status(TRUE)

/datum/wound/blunt/robotic/secures_internals/critical/handle_percussive_maintenance_failure(attacking_item, mob/living/user)
	to_chat(victim, span_danger("Your [limb.plaintext_zone] only deforms more from the impact..."))
	limb.receive_damage(brute = 1, damage_source = attacking_item, wound_bonus = CANT_WOUND)

/datum/wound/blunt/robotic/secures_internals/critical/uses_percussive_maintenance()
	return (!superstructure_remedied && limb_malleable())

/// Transitions our steps by setting both superstructure and secure internals readiness.
/datum/wound/blunt/robotic/secures_internals/critical/proc/set_superstructure_status(remedied)
	superstructure_remedied = remedied
	ready_to_secure_internals = remedied

/datum/wound/blunt/robotic/secures_internals/critical/get_wound_step_info()
	. = ..()

	if(!superstructure_remedied)
		. = "The superstructure must be reformed."
		if(!limb_malleable())
			. += " The limb must be heated to thermal overload, then manually molded with a firm grasp"
		else
			. += " The limb has been sufficiently heated, and can be manually molded with a firm grasp/repeated application of a low-force object"
		. += " - OR an RCD may be used with little risk."
