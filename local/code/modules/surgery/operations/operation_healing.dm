/// Helper to see if surgeon is eligible to receive exact numbers on tend wounds results
/datum/surgery_operation/basic/tend_wounds/proc/has_detailed_feedback(mob/living/patient, mob/living/surgeon)
	PRIVATE_PROC(TRUE)
	return HAS_TRAIT(surgeon, TRAIT_MEDICAL_HUD) || (locate(/obj/item/healthanalyzer) in surgeon.held_items) || locate_operating_computer(patient)

/datum/surgery_operation/basic/tend_wounds/get_feedback_message(mob/living/patient, mob/living/surgeon, list/operation_args)
	. = ..()
	if(!istype(patient))
		return
	if(!has_detailed_feedback(patient, surgeon))
		return

	var/parent_text = .
	var/brute_text = null
	var/burn_text = null
	if(operation_args[OPERATION_BRUTE_HEAL] > 0)
		brute_text = "<font color='#FF3333'>[ceil(patient.get_brute_loss())]</font>"
	if(operation_args[OPERATION_BURN_HEAL] > 0)
		burn_text = "<font color='#FF9933'>[ceil(patient.get_fire_loss())]</font>"
	return "[parent_text] ([brute_text][brute_text && burn_text ? "/" : null][burn_text])"
