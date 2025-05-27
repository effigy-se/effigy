/obj/item/organ/stomach/fuel_generator
	name = "liquid fuel generator"
	desc = "Burns fuel to generate power."
	disable_base_stomach_behavior = TRUE
	can_process_solids = FALSE
	organ_flags = ORGAN_ROBOTIC
	reagent_vol = 100
	var/list/flammable_reagents = list(
		/datum/reagent/thermite = 70,
		/datum/reagent/clf3 = 80,
		/datum/reagent/stable_plasma = 10, // too stable to burn well, not a good source of fuel
		/datum/reagent/fuel = 30, // Not great but works in a pinch
		/datum/reagent/toxin/plasma = 200 // STRAIGHT PLASMA BABY LETS GO
	)
	// Burns into carbon, which clogs up the fuel generator.
	var/list/bad_reagents = list(
		/datum/reagent/toxin,
		/datum/reagent/consumable,
		/datum/reagent/drug,
		/datum/reagent/catalyst_agent,
		/datum/reagent/medicine
	)
	var/obj/effect/abstract/particle_holder/particle_effect
	var/datum/looping_sound/generator/soundloop

/obj/item/organ/stomach/fuel_generator/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/organ/stomach/fuel_generator/on_life(seconds_per_tick, times_fired)
	. = ..()

	var/power_generated = 0
	var/mob/living/carbon/body = owner
	if(reagents.total_volume)
		soundloop.start()
	else
		soundloop.stop()
	var/carbon_amount = reagents.get_reagent_amount(/datum/reagent/carbon)
	if(carbon_amount > 0)
		if(!particle_effect)
			to_chat(body, span_warning("The exhaust pipe on [src] emits smoke."))
			balloon_alert(body, "generator smoking!")
			particle_effect = new(body, /particles/smoke)
	else
		if(particle_effect)
			QDEL_NULL(particle_effect)
	for(var/datum/reagent/bit as anything in reagents?.reagent_list)
		if(istype(bit, /datum/reagent/carbon))
			continue // skip that mf
		if(bit.metabolization_rate <= 0)
			continue
		reagents.set_temperature(1000)
		reagents.handle_reactions()
		if(istype(bit, /datum/reagent/consumable/ethanol)) // Burn ethanol for power!
			var/datum/reagent/consumable/ethanol/liquid = bit
			power_generated += max((liquid.boozepwr / 100) - (carbon_amount / 100), 0) * 2
			reagents.remove_reagent(liquid.type, 1)
			break
		else if(is_type_in_list(bit, flammable_reagents)) // Alternative burn options
			power_generated += max((flammable_reagents[bit.type] / 100) - (carbon_amount / 100), 0)
			reagents.remove_reagent(bit.type, 1)
			break
		else if(is_type_in_list(bit, bad_reagents)) // Expressly do not try to burn these
			reagents.add_reagent(/datum/reagent/carbon, 1)
			reagents.remove_reagent(bit.type, 1)
			break
		else // Everything else cooks off.
			reagents.remove_reagent(bit.type, 1)
			break

	var/obj/item/organ/brain/cybernetic/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	robot_brain.power = min(robot_brain.power + power_generated, robot_brain.max_power)
