/datum/controller/subsystem/persistence
	var/last_storyteller_type = ""

/// Saves the persistence data for the owner.
/mob/living/carbon/human/proc/save_individual_persistence(var/ckey)
	return
	/* EffigyEdit TODO: confirm if required
	var/obj/item/organ/internal/brain/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	return brain?.modular_persistence?.save_data(ckey)
	*/
