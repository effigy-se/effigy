/// Adds the neuroware status effect, or adds 1 to the existing effect's program count.
/datum/reagent/proc/on_neuroware_metabolize(mob/living/affected_mob)
	var/datum/status_effect/neuroware/neuro_status = affected_mob.has_status_effect(/datum/status_effect/neuroware)
	if(isnull(neuro_status))
		affected_mob.apply_status_effect(/datum/status_effect/neuroware)
	else
		neuro_status.adjust_program_count(1)

/// Subtracts 1 from the neuroware status effect's program count, if it exists.
/datum/reagent/proc/on_neuroware_end_metabolize(mob/living/affected_mob)
	var/datum/status_effect/neuroware/neuro_status = affected_mob.has_status_effect(/datum/status_effect/neuroware)
	if(!isnull(neuro_status))
		neuro_status.adjust_program_count(-1)

/// Returns a random neuroware reagent type.
/proc/get_random_neuroware()
	return GLOB.name2neuroware[pick(GLOB.name2neuroware)]
