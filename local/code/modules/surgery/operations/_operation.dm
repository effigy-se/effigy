/// Checks if a mob under surgery has sterilizine applied
/mob/living/proc/has_sterilizine()
	return (LAZYACCESS(mob_surgery_speed_mods, /datum/reagent/space_cleaner/sterilizine) || LAZYACCESS(mob_surgery_speed_mods, /datum/reagent/cryostylane))

/// Returns feedback text to show the surgeon after completing a step
/datum/surgery_operation/proc/get_feedback_message(mob/living/patient, mob/living/surgeon, list/operation_args)
	return "[round(1 / (operation_args[OPERATION_SPEED] || 1), 0.1)]x speed"
