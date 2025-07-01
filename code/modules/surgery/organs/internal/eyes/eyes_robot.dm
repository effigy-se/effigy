/obj/item/organ/eyes/camera
	name = "cameras"
	desc = "Expensive cameras for viewing the station."
	icon = 'local/icons/obj/medical/organs/organs.dmi'
	icon_state = "camera"
	iris_overlay = null
	organ_flags = ORGAN_ROBOTIC
	failing_desc = "seems to be broken."

/obj/item/organ/eyes/camera/on_mob_remove(mob/living/carbon/eye_owner)
	. = ..()
	owner.clear_fullscreen("robot_eye_static")

/obj/item/organ/eyes/camera/damage_threshold_crossed(new_damage)
	return // we don't do that here

/obj/item/organ/eyes/camera/apply_damaged_eye_effects()
	var/static_alpha = 0
	static_alpha = 240 * (damage / maxHealth)
	if(organ_flags & ORGAN_DEPOWERED)
		static_alpha = 240
	if(organ_flags & ORGAN_FAILING)
		static_alpha = 240
	if(static_alpha)
		owner.overlay_fullscreen("robot_eye_static", /atom/movable/screen/fullscreen/static_vision/robot_eyes, screen_alpha = static_alpha)
	else
		owner.clear_fullscreen("robot_eye_static")

/obj/item/organ/eyes/camera/on_life(seconds_per_tick, times_fired)
	. = ..()
	apply_damaged_eye_effects()
	var/obj/item/organ/brain/cybernetic/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: No cybernetic brain to draw power from!")
			organ_flags |= ORGAN_DEPOWERED
		return
	if(robot_brain.power <= 3)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering cameras to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (ROBOT_POWER_DRAIN * seconds_per_tick) * robot_brain.temperature_disparity
	robot_brain.run_updates()

