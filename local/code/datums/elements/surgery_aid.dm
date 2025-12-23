/datum/element/surgery_aid/surgery_prep(mob/living/target_mob, mob/living/surgeon, body_zone)
	. = ..()
	if(!target_mob.has_status_effect(/datum/status_effect/surgery_prepped)) // proc call was to cancel surgery, not initiate
		return

	var/list/passed_check = list()
	var/list/failed_check = list()
	var/turf/mob_turf = get_turf(target_mob)
	var/obj/structure/table/optable/operating_table = locate(/obj/structure/table/optable, mob_turf)
	if(!isnull(operating_table))
		if(operating_table.computer?.is_operational)
			passed_check += "the operating table/computer"
		else
			passed_check += "the operating table"
			failed_check += "an operating computer"

	if(!issynth(target_mob))
		if((HAS_TRAIT(target_mob, TRAIT_ANALGESIA) && !(HAS_TRAIT(target_mob, TRAIT_STASIS))) || target_mob.stat == DEAD)
			passed_check += "pain management"
		else if(!(HAS_TRAIT(target_mob, TRAIT_STASIS)))
			failed_check += "using anesthetics or painkillers"

		if(target_mob.has_sterilizine())
			passed_check += "sterilizine/cryostylane"
		else
			failed_check += "using sterilizine or cryostylane"

	if(length(passed_check) > 0)
		to_chat(surgeon, span_greenannounce("You have surgery speed bonuses from [english_list(passed_check)]!"))
	if(length(failed_check) > 0)
		to_chat(surgeon, span_boldnotice("You could increase surgery speed by [english_list(failed_check)]."))

	if(!(HAS_TRAIT(target_mob, TRAIT_ANALGESIA) || target_mob.stat == DEAD) && !issynth(target_mob))
		to_chat(surgeon, span_bolddanger("[target_mob] has no treatment to manage surgery pain!"))
