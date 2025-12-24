/datum/surgery_operation/organ/repair/brain/mechanic/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	if(!organ.owner.has_status_effect(/datum/status_effect/neuroware))
		return

	organ.owner.balloon_alert(surgeon, "neuroware reset")
	for(var/datum/reagent/reagent as anything in organ.owner.reagents.reagent_list)
		if(reagent.chemical_flags & REAGENT_NEUROWARE_PACKAGE)
			organ.owner.reagents.del_reagent(reagent.type)
