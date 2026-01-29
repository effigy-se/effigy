/// A subtype of blunt wounds that has a "secure internals" step
/datum/wound/blunt/robotic/secures_internals
	/// Our current counter for gel + gauze regeneration
	var/regen_time_elapsed = 0 SECONDS
	/// Time needed for gel to secure internals.
	var/regen_time_needed = 30 SECONDS

	/// If we have used bone gel to secure internals.
	var/gelled = FALSE
	/// Total brute damage taken over the span of [regen_time_needed] deciseconds when we gel our limb.
	var/gel_damage = 10 // brute in total

	/// If we are ready to begin screwdrivering or gelling our limb.
	var/ready_to_secure_internals = FALSE
	/// If our external plating has been torn open and we can access our internals without a tool
	var/crowbarred_open = FALSE
	/// If internals are secured, and we are ready to weld our limb closed and end the wound
	var/ready_to_resolder = TRUE

/datum/wound/blunt/robotic/secures_internals/handle_process(seconds_per_tick, times_fired)
	. = ..()

	if(!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	if(gelled)
		regen_time_elapsed += ((seconds_per_tick SECONDS) / 2)
		if(victim.body_position == LYING_DOWN)
			if(SPT_PROB(30, seconds_per_tick))
				regen_time_elapsed += 1 SECONDS
			if(victim.IsSleeping() && SPT_PROB(30, seconds_per_tick))
				regen_time_elapsed += 1 SECONDS

		var/effective_damage = ((gel_damage / (regen_time_needed / 10)) * seconds_per_tick)
		var/obj/item/stack/gauze = limb.current_gauze
		if(gauze)
			effective_damage *= gauze.splint_factor
		limb.receive_damage(effective_damage, wound_bonus = CANT_WOUND, damage_source = src)
		if(effective_damage && prob(33))
			var/gauze_text = (gauze?.splint_factor ? ", although the [gauze] helps to prevent some of the leakage" : "")
			to_chat(victim, span_danger("Your [limb.plaintext_zone] sizzles as some gel leaks and warps the exterior metal[gauze_text]..."))

		if(regen_time_elapsed > regen_time_needed)
			if(!victim || !limb)
				qdel(src)
				return
			to_chat(victim, span_green("The gel within your [limb.plaintext_zone] has fully hardened, allowing you to re-solder it!"))
			gelled = FALSE
			ready_to_resolder = TRUE
			ready_to_secure_internals = FALSE
			set_disabling(FALSE)

/datum/wound/blunt/robotic/secures_internals/modify_desc_before_span(desc)
	. = ..()

	var/use_exclamation = FALSE

	if(!limb.current_gauze) // gauze covers it up
		if(crowbarred_open)
			. += ", [span_notice("and is violently torn open, internals visible to the outside")]"
			use_exclamation = TRUE
		if(gelled)
			. += ", [span_notice("with fizzling blue surgical gel leaking out of the cracks")]"
			use_exclamation = TRUE
		if(use_exclamation)
			. += "!"

/datum/wound/blunt/robotic/secures_internals/get_scanner_description(mob/user)
	. = ..()

	var/to_add = get_wound_status()
	if(!isnull(to_add))
		. += "\nWound status: [to_add]"

/datum/wound/blunt/robotic/secures_internals/get_simple_scanner_description(mob/user)
	. = ..()

	var/to_add = get_wound_status()
	if(!isnull(to_add))
		. += "\nWound status: [to_add]"

/// Returns info specific to the dynamic state of the wound.
/datum/wound/blunt/robotic/secures_internals/proc/get_wound_status(mob/user)
	if(crowbarred_open)
		. += "The limb has been torn open, allowing ease of access to internal components, but also disabling it. "
	if(gelled)
		. += "Bone gel has been applied, causing progressive corrosion of the metal, but eventually securing the internals. "

/datum/wound/blunt/robotic/secures_internals/item_can_treat(obj/item/potential_treater, mob/user)
	if(potential_treater.tool_behaviour == TOOL_WELDER || potential_treater.tool_behaviour == TOOL_CAUTERY)
		if(ready_to_resolder)
			return TRUE

	if(ready_to_secure_internals)
		if(item_can_secure_internals(potential_treater))
			return TRUE

	return ..()

/datum/wound/blunt/robotic/secures_internals/treat(obj/item/potential_treater, mob/user)
	if(ready_to_secure_internals)
		if(istype(potential_treater, /obj/item/stack/medical/bone_gel))
			return apply_gel(potential_treater, user)
		else if(!crowbarred_open && potential_treater.tool_behaviour == TOOL_CROWBAR)
			return crowbar_open(potential_treater, user)
		else if(item_can_secure_internals(potential_treater))
			return secure_internals_normally(potential_treater, user)
	else if(ready_to_resolder && (potential_treater.tool_behaviour == TOOL_WELDER) || (potential_treater.tool_behaviour == TOOL_CAUTERY))
		return resolder(potential_treater, user)

	return ..()

/// Returns TRUE if the item can be used in our 1st step (2nd if T3) of repairs.
/datum/wound/blunt/robotic/secures_internals/proc/item_can_secure_internals(obj/item/potential_treater)
	return (potential_treater.tool_behaviour == TOOL_SCREWDRIVER || potential_treater.tool_behaviour == TOOL_WRENCH || istype(potential_treater, /obj/item/stack/medical/bone_gel))

#define CROWBAR_OPEN_SELF_TEND_DELAY_MULT 2
#define CROWBAR_OPEN_KNOWS_ROBO_WIRES_DELAY_MULT 0.5
#define CROWBAR_OPEN_KNOWS_ENGI_WIRES_DELAY_MULT 0.5
#define CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT 0.5
#define CROWBAR_OPEN_WOUND_SCANNED_DELAY_MULT 0.5
/// If our limb is essential, damage dealt to it by tearing it open will be multiplied against this.
#define CROWBAR_OPEN_ESSENTIAL_LIMB_DAMAGE_MULT 1.5

/// The "power" put into electrocute_act whenever someone gets shocked when they crowbar open our limb
#define CROWBAR_OPEN_SHOCK_POWER 20
/// The brute damage done to this limb (doubled on essential limbs) when it is crowbarred open
#define CROWBAR_OPEN_BRUTE_DAMAGE 20

/**
 * Available during the "secure internals" step of T2 and T3. Requires a crowbar. Low-quality ghetto option.
 *
 * Tears open the limb, exposing internals. This massively increases the chance of secure internals succeeding, and removes the self-tend malice.
 *
 * Deals significant damage to the limb, and shocks the user (causing failure) if victim is alive, this limb is wired, and user is not insulated.
 */
/datum/wound/blunt/robotic/secures_internals/proc/crowbar_open(obj/item/crowbarring_item, mob/living/user)
	if(!crowbarring_item.tool_start_check())
		return TRUE

	var/delay_mult = 1
	if(user == victim)
		delay_mult *= CROWBAR_OPEN_SELF_TEND_DELAY_MULT

	var/knows_wires = FALSE
	if(HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= CROWBAR_OPEN_KNOWS_ROBO_WIRES_DELAY_MULT
		knows_wires = TRUE
	else if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= CROWBAR_OPEN_KNOWS_ENGI_WIRES_DELAY_MULT
		knows_wires = TRUE
	if(HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if(knows_wires)
			delay_mult *= (CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT * 1.5)
		else
			delay_mult *= CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= CROWBAR_OPEN_WOUND_SCANNED_DELAY_MULT

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")

	var/limb_can_shock_pre_sleep = (victim.stat != DEAD && limb.biological_state & BIO_WIRED)
	var/shock_or_not = (limb_can_shock_pre_sleep ? ", risking electrocution" : "")
	var/self_message = span_warning("You start prying open [your_or_other] [limb.plaintext_zone] with [crowbarring_item][shock_or_not]...")

	user?.visible_message(span_bolddanger("[user] starts prying open [their_or_other] [limb.plaintext_zone] with [crowbarring_item]!"), self_message, ignored_mobs = list(victim))

	var/victim_message
	if(user != victim) // this exists so we can do a userdanger
		victim_message = span_userdanger("[user] starts prying open your [limb.plaintext_zone] with [crowbarring_item]!")
	else
		victim_message = self_message
	to_chat(victim, victim_message)

	playsound(get_turf(crowbarring_item), 'sound/machines/airlock/airlock_alien_prying.ogg', 30, TRUE)
	if(!crowbarring_item.use_tool(target = victim, user = user, delay = (7 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/limb_can_shock = (victim.stat != DEAD && limb.biological_state & BIO_WIRED) // re-define the previous shock variable because we slept
	var/stunned = FALSE

	var/message

	if(user && limb_can_shock)
		var/electrocute_flags = (SHOCK_KNOCKDOWN|SHOCK_NO_HUMAN_ANIM|SHOCK_SUPPRESS_MESSAGE)
		var/stun_chance = 100

		if(HAS_TRAIT(user, TRAIT_SHOCKIMMUNE))
			stun_chance = 0

		else if(iscarbon(user)) // doesn't matter if we're shock immune, it's set to 0 anyway
			var/mob/living/carbon/carbon_user = user
			if(carbon_user.gloves)
				stun_chance *= carbon_user.gloves.siemens_coefficient

			if(ishuman(user))
				var/mob/living/carbon/human/human_user = user
				stun_chance *= human_user.physiology.siemens_coeff
			stun_chance *= carbon_user.dna.species.siemens_coeff

		if(stun_chance && prob(stun_chance))
			electrocute_flags &= ~SHOCK_KNOCKDOWN
			electrocute_flags &= ~SHOCK_NO_HUMAN_ANIM
			stunned = TRUE

			message = span_boldwarning("[user] is shocked by [their_or_other] [limb.plaintext_zone], [user.p_their()] crowbar slipping as [user.p_they()] briefly convulse!")
			self_message = span_userdanger("You are shocked by [your_or_other] [limb.plaintext_zone], causing your crowbar to slip out!")
			if(user != victim)
				victim_message = span_userdanger("[user] is shocked by your [limb.plaintext_zone] in [user.p_their()] efforts to tear it open!")

		var/shock_damage = CROWBAR_OPEN_SHOCK_POWER
		if(limb.current_gauze)
			shock_damage *= limb.current_gauze.splint_factor // always good to let gauze do something
		user.electrocute_act(shock_damage, limb, flags = electrocute_flags)

	if(!stunned)
		var/other_shock_text = ""
		var/self_shock_text = ""
		if(!limb_can_shock)
			other_shock_text = ", and is striken by golden bolts of electricity"
			self_shock_text = ", but are immediately shocked by the electricity contained within"
		message = span_boldwarning("[user] tears open [their_or_other] [limb.plaintext_zone] with [user.p_their()] crowbar[other_shock_text]!")
		self_message = span_warning("You tear open [your_or_other] [limb.plaintext_zone] with your crowbar[self_shock_text]!")
		if(user != victim)
			victim_message = span_userdanger("Your [limb.plaintext_zone] fragments and splinters as [user] tears it open with [user.p_their()] crowbar!")

		playsound(get_turf(crowbarring_item), 'sound/effects/bang.ogg', 35, TRUE) // we did it!
		to_chat(user, span_green("You've torn [your_or_other] [limb.plaintext_zone] open, heavily damaging it but making it a lot easier to screwdriver the internals!"))
		var/damage = CROWBAR_OPEN_BRUTE_DAMAGE
		if(limb_essential()) // can't be disabled
			damage *= CROWBAR_OPEN_ESSENTIAL_LIMB_DAMAGE_MULT
		limb.receive_damage(brute = CROWBAR_OPEN_BRUTE_DAMAGE, wound_bonus = CANT_WOUND, damage_source = crowbarring_item)
		set_torn_open(TRUE)

	if(user == victim)
		victim_message = self_message

	user.visible_message(message, self_message, ignored_mobs = list(victim))
	to_chat(victim, victim_message)
	return TRUE

#undef CROWBAR_OPEN_SELF_TEND_DELAY_MULT
#undef CROWBAR_OPEN_KNOWS_ROBO_WIRES_DELAY_MULT
#undef CROWBAR_OPEN_KNOWS_ENGI_WIRES_DELAY_MULT
#undef CROWBAR_OPEN_HAS_DIAG_HUD_DELAY_MULT
#undef CROWBAR_OPEN_WOUND_SCANNED_DELAY_MULT
#undef CROWBAR_OPEN_ESSENTIAL_LIMB_DAMAGE_MULT

#undef CROWBAR_OPEN_BRUTE_DAMAGE
#undef CROWBAR_OPEN_SHOCK_POWER

/// Sets [crowbarred_open] to the new value. If we werent originally disabling, or if we arent currently and we're torn open, we set disabling to true.
/datum/wound/blunt/robotic/secures_internals/proc/set_torn_open(torn_open_state)
	// if we aren't disabling but we were torn open, OR if we aren't disabling by default
	var/should_update_disabling = ((!disabling && torn_open_state) || !initial(disabling))

	crowbarred_open = torn_open_state
	if(should_update_disabling)
		set_disabling(torn_open_state)

/// If, on a secure internals attempt, we have less than this chance to succeed, we warn the user.
#define SECURE_INTERNALS_CONFUSED_CHANCE_THRESHOLD 25
#define SECURE_INTERNALS_FAILURE_BRUTE_DAMAGE 5

/**
 * The primary way of performing the secure internals step for T2/T3. Uses a screwdriver/wrench. Very hard to do by yourself, or without a diag hud/wire knowledge.
 * Roboticists/engineers have a very high chance of succeeding.
 * Deals some brute damage on failure, but moves to the final step of treatment (re-soldering) on success.
 *
 * If [crowbarred_open], made far more likely and remove the self-tend malice.
 */
/datum/wound/blunt/robotic/secures_internals/proc/secure_internals_normally(obj/item/securing_item, mob/user)
	if(!securing_item.tool_start_check())
		return TRUE

	var/chance = 10
	var/delay_mult = 1

	if(user == victim)
		if(!crowbarred_open)
			chance *= 0.2
		delay_mult *= 2

	var/knows_wires = FALSE
	if(crowbarred_open)
		chance *= 4 // even self-tends get a high chance of success if torn open!
	if(HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		chance *= 8 // almost guaranteed if it's not self surgery - guaranteed with diag hud
		delay_mult *= 0.75
		knows_wires = TRUE
	else if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		chance *= 5.5
		delay_mult *= 0.85
		knows_wires = TRUE
	if(HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if (knows_wires)
			chance *= 1.25 // ((10 * 8) * 1.25) = 100%
		else
			chance *= 4
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		chance *= 1.5 // youre not intended to fix this by yourself this way
		delay_mult *= 0.8

	var/confused = (chance < SECURE_INTERNALS_CONFUSED_CHANCE_THRESHOLD) // generate chance beforehand, so we can use this var

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	user?.visible_message(span_notice("[user] begins the delicate operation of securing the internals of [their_or_other] [limb.plaintext_zone]..."), \
		span_notice("You begin the delicate operation of securing the internals of [your_or_other] [limb.plaintext_zone]..."))
	if(confused)
		to_chat(user, span_warning("You are confused by the layout of [your_or_other] [limb.plaintext_zone]! A diagnostic hud would help, as would knowing robo/engi wires! You could also tear the limb open with a crowbar, or get someone else to help."))

	if(!securing_item.use_tool(target = victim, user = user, delay = (10 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	if(prob(chance))
		user?.visible_message(span_green("[user] finishes securing the internals of [their_or_other] [limb.plaintext_zone]!"), \
			span_green("You finish securing the internals of [your_or_other] [limb.plaintext_zone]!"))
		to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone]'s internals are now secure! Your next step is to weld/cauterize it."))
		ready_to_secure_internals = FALSE
		ready_to_resolder = TRUE
	else
		user?.visible_message(span_danger("[user] screws up and accidentally damages [their_or_other] [limb.plaintext_zone]!"))
		limb.receive_damage(brute = SECURE_INTERNALS_FAILURE_BRUTE_DAMAGE, damage_source = securing_item, wound_bonus = CANT_WOUND)

	return TRUE

#undef SECURE_INTERNALS_CONFUSED_CHANCE_THRESHOLD
#undef SECURE_INTERNALS_FAILURE_BRUTE_DAMAGE

/**
 * "Premium" ghetto option of the secure internals step for T2/T3. Requires bone gel. Guaranteed to work.
 * Deals damage over time and disables the limb, but finishes the step afterwards.
 */
/datum/wound/blunt/robotic/secures_internals/proc/apply_gel(obj/item/stack/medical/bone_gel/gel, mob/user)
	if(gelled)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.plaintext_zone] is already filled with bone gel!"))
		return TRUE

	var/delay_mult = 1
	if(victim == user)
		delay_mult *= 1.5

	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	user.visible_message(span_danger("[user] begins hastily applying [gel] to [victim]'s [limb.plaintext_zone]..."), span_warning("You begin hastily applying [gel] to [user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone], disregarding the acidic effect it seems to have on the metal..."))

	if(!do_after(user, (6 SECONDS * delay_mult), target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	gel.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user] finishes applying [gel] to [victim]'s [limb.plaintext_zone], emitting a fizzing noise!"), span_notice("You finish applying [gel] to [victim]'s [limb.plaintext_zone]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] finishes applying [gel] to your [limb.plaintext_zone], and you can hear the sizzling of the metal..."))
	else
		victim.visible_message(span_notice("[victim] finishes applying [gel] to [victim.p_their()] [limb.plaintext_zone], emitting a funny fizzing sound!"), span_notice("You finish applying [gel] to your [limb.plaintext_zone], and you can hear the sizzling of the metal..."))

	gelled = TRUE
	set_disabling(TRUE)
	processes = TRUE
	return TRUE

/**
 * The final step of T2/T3, requires a welder/cautery. Guaranteed to work. Cautery is slower.
 * Once complete, removes the wound entirely.
 */
/datum/wound/blunt/robotic/secures_internals/proc/resolder(obj/item/welding_item, mob/user)
	if(!welding_item.tool_start_check())
		return TRUE

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	victim.visible_message(span_notice("[user] begins re-soldering [their_or_other] [limb.plaintext_zone]..."), \
		span_notice("You begin re-soldering [your_or_other] [limb.plaintext_zone]..."))

	var/delay_mult = 1
	if(welding_item.tool_behaviour == TOOL_CAUTERY)
		delay_mult *= 3 // less efficient
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if(!welding_item.use_tool(target = victim, user = user, delay = 7 SECONDS * delay_mult, volume = 50,  extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	victim.visible_message(span_green("[user] finishes re-soldering [their_or_other] [limb.plaintext_zone]!"), \
		span_notice("You finish re-soldering [your_or_other] [limb.plaintext_zone]!"))
	remove_wound()
	return TRUE

/// Returns a string with our current treatment step for use in health analyzers.
/datum/wound/blunt/robotic/secures_internals/proc/get_wound_step_info()
	var/string

	if(ready_to_resolder)
		string = "Apply a welder/cautery to the limb to finalize repairs."
	else if (ready_to_secure_internals)
		string = "Use a screwdriver/wrench to secure the internals of the limb. This step is best performed by a qualified technician. \
		In absence of one, bone gel or a crowbar may be used."

	return string

/datum/wound/blunt/robotic/secures_internals/get_scanner_description(mob/user)
	. = ..()

	var/wound_step = get_wound_step_info()
	if(wound_step)
		. += "\n\n<b>Current step</b>: [span_notice(wound_step)]"

/datum/wound/blunt/robotic/secures_internals/get_simple_scanner_description(mob/user)
	. = ..()

	var/wound_step = get_wound_step_info()
	if(wound_step)
		. += "\n\n<b>Current step</b>: [span_notice(wound_step)]"

/datum/wound/blunt/robotic/secures_internals/severe
	name = "Detached Fastenings"
	desc = "Various fastening devices are extremely loose and solder has disconnected at multiple points, causing significant jostling of internal components and \
	noticable limb dysfunction."
	treat_text_short = "Repair surgically, start with a screwdriver and then weld in place. Use gauze to reduce negative effects."
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

/datum/wound/blunt/robotic/secures_internals/critical
	name = "Collapsed Superstructure"
	desc = "The superstructure has totally collapsed in one or more locations, causing extreme internal oscillation with every move and massive limb dysfunction"
	treat_text_short = "Repair surgically, start by superheating the limb until you can mold it by aggressively grabbing it, screwdriver, then weld. \
		When it's done, use gauze to reduce negative effects."
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

