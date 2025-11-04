/datum/surgery
	/// Whether this surgery aims to remove or replace the target bodypart, with the goal of being used
	/// with a bodypart's `can_be_surgically_removed` variable. Defaults to FALSE.
	var/removes_target_bodypart = FALSE
	///What organ type is required. Used with organ_to_manipulate.
	var/requires_organ_type
	///What organ flags are required. Used with organ_to_manipulate.
	var/requires_organ_flags
	///What amount of damage is required on the organ before the surgery can start. Used with organ_to_manipulate.
	var/requires_organ_damage

// Prevents surgery if the target organ's bodyzone, damage, type, or flags differ from expected.
/datum/surgery/can_start(mob/user, mob/living/patient)
	. = ..()
	if(isnull(organ_to_manipulate))
		return
	var/obj/item/organ/target_organ = patient.get_organ_slot(organ_to_manipulate)
	if(isnull(target_organ))
		return FALSE
	// Ensure organ is where it's needed
	if(!(target_organ.zone in possible_locs))
		return FALSE
	// Ensure organ has the required amount of damage
	if(!isnull(requires_organ_damage) && target_organ.damage < requires_organ_damage)
		return FALSE
	// Ensure organ is the required type
	if(!isnull(requires_organ_type) && !istype(target_organ, requires_organ_type))
		return FALSE
	// Ensure organ has required flags
	if(!isnull(requires_organ_flags) && !(target_organ.organ_flags & requires_organ_flags))
		return FALSE

//Blacklists upstream's mechanical surgeries for augmented people in favor of our synth surgeries
//This is done for RP Purposes and to keep synthetic and organic surgeries fully segregated

/datum/surgery/advanced/bioware/cortex_folding/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/advanced/bioware/cortex_imprint/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/advanced/bioware/ligament_hook/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/advanced/bioware/muscled_veins/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/advanced/bioware/nerve_grounding/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/advanced/bioware/nerve_splicing/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/advanced/bioware/vein_threading/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/advanced/lobotomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/blood_filter/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/brain_surgery/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/coronary_bypass/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/gastrectomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/hepatectomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/lipoplasty/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/lobectomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

//Disable both normal and mechanical for synths. Makes some sense on augmented people so lacks a biotype check.
/datum/surgery/revival/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()

/datum/surgery/stomach_pump/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynth(target) && ..()
