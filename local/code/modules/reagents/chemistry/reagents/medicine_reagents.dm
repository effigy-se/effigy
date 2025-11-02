/datum/reagent/medicine/lidocaine
	name = "Lidocaine"
	description = "A numbing agent used often for surgeries, metabolizes slowly."
	color = "#6dbdbd" // 109, 189, 189
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	ph = 6.09
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_ANALGESIA)
	inverse_chem_val = 0.55
	inverse_chem = /datum/reagent/inverse/lidocaine
	taste_description = "vanilla"

	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/medicine/lidocaine/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.throw_alert("numbed", /atom/movable/screen/alert/numbed)

/datum/reagent/medicine/lidocaine/on_mob_end_metabolize(mob/living/metabolizer)
	metabolizer.clear_alert("numbed")
	return ..()

/datum/reagent/medicine/lidocaine/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjustOrganLoss(ORGAN_SLOT_HEART,3 * REM * seconds_per_tick, 80)
	return ..()

//Inverse Medicines//

/datum/reagent/inverse/lidocaine
	name = "Lidopaine"
	description = "A paining agent used often for... being a jerk, metabolizes faster than lidocaine."
	color = "#85111f" // 133, 17, 31
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	ph = 6.09
	tox_damage = 0

/datum/reagent/inverse/lidocaine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	to_chat(affected_mob, span_userdanger("Your body aches with unimaginable pain!"))
	affected_mob.adjustOrganLoss(ORGAN_SLOT_HEART,3 * REM * seconds_per_tick, 85)
	affected_mob.adjustStaminaLoss(5 * REM * seconds_per_tick, 0)
	if(prob(30))
		INVOKE_ASYNC(affected_mob, TYPE_PROC_REF(/mob, emote), "scream")

// Synth medicines
/datum/reagent/medicine/brain_neuroware
	name = "ntnetsys.robot-diag.exe"
	description = "Repairs basic brain traumas in synthetics."
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/brain_neuroware)

/datum/reagent/medicine/brain_neuroware/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick)
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	return ..()

/datum/reagent/medicine/reset_neuroware
	name = "ntnetsys.robot-antivirus.exe"
	description = "Deletes neuroware programs in synthetics."
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0
	metabolization_rate = 2 * REAGENTS_METABOLISM

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/reset_neuroware)

/datum/reagent/medicine/reset_neuroware/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	var/remove_amount = 1 * REM * seconds_per_tick;
	for(var/thing in affected_mob.reagents.reagent_list)
		var/datum/reagent/reagent = thing
		if((reagent.chemical_flags & REAGENT_NEUROWARE_PACKAGE) && (reagent != src))
			affected_mob.reagents.remove_reagent(reagent.type, remove_amount)
	return ..()

/datum/reagent/medicine/synaptizine/synth
	name = "synaptuner.zhe"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/synaptizine/synth)

/datum/reagent/medicine/psicodine/synth
	name = "zen-firstaid.zhe"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/psicodine/synth)

/datum/reagent/medicine/morphine/synth
	name = "AnaSynthic.zhe"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/morphine/synth)

/datum/reagent/medicine/lidocaine/synth
	name = "NGesic.zhe"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/morphine/synth)
