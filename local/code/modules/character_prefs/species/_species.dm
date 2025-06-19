/**
 * # species datum
 *
 * Datum that handles different species in the game.
 *
 * This datum handles species in the game, such as lizardpeople, mothmen, zombies, skeletons, etc.
 * It is used in [carbon humans][mob/living/carbon/human] to determine various things about them, like their food preferences, if they have biological genders, their damage resistances, and more.
 *
 */
/datum/species
	/// Adding a language type to this in the form of /datum/language will allow the language to be displayed in preferences for that species, even if it is a secret language.
	var/list/language_prefs_whitelist
	/// If a species can always be picked in prefs for the purposes of customizing it for ghost roles or events
	var/always_customizable = FALSE
	/// How are we treated regarding processing reagents, by default we process them as if we're organic
	var/reagent_flags = PROCESS_ORGANIC
	/// This is the outfit which will be used by the species its preview portrait
	var/datum/outfit/preview_outfit = /datum/outfit/job/assistant/consistent
	/// Override for the alpha of bodyparts and mutant parts.
	var/specific_alpha = 255
	var/list/digi_leg_overrides = list(
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade,
	)
	/// Is this species restricted from changing their body_size in character creation?
	var/body_size_restricted = FALSE

/// Cybernetic limbs logic here!
//	Used for most races
/datum/species/on_species_gain(mob/living/carbon/human/target, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	var/list/frame_bodyparts = target.dna.features["frame_list"]
	if(!(type in GLOB.bodypart_allowed_species[CYBER_FRAME]))
		return ..()
	if(type == /datum/species/android && frame_bodyparts && frame_bodyparts[BODY_ZONE_HEAD])
		bodypart_overrides[BODY_ZONE_HEAD] = frame_bodyparts[BODY_ZONE_HEAD]
	if(frame_bodyparts && frame_bodyparts[BODY_ZONE_CHEST])
		bodypart_overrides[BODY_ZONE_CHEST] = frame_bodyparts[BODY_ZONE_CHEST]
	if(frame_bodyparts && frame_bodyparts[BODY_ZONE_R_ARM])
		bodypart_overrides[BODY_ZONE_R_ARM] = frame_bodyparts[BODY_ZONE_R_ARM]
	if(frame_bodyparts && frame_bodyparts[BODY_ZONE_L_ARM])
		bodypart_overrides[BODY_ZONE_L_ARM] = frame_bodyparts[BODY_ZONE_L_ARM]
	if(frame_bodyparts && frame_bodyparts[BODY_ZONE_R_LEG])
		bodypart_overrides[BODY_ZONE_R_LEG] = frame_bodyparts[BODY_ZONE_R_LEG]
	if(frame_bodyparts && frame_bodyparts[BODY_ZONE_L_LEG])
		bodypart_overrides[BODY_ZONE_L_LEG] = frame_bodyparts[BODY_ZONE_L_LEG]
	return ..()

/// spec_revival logic
/datum/species/proc/spec_revival(mob/living/carbon/human/target)
	return

/mob/living/carbon/set_species(datum/species/mrace, icon_update = TRUE, pref_load = FALSE)
	. = ..()
	dna.update_effigy_body_size()

/mob/living/carbon/human/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	. = ..()
	if(.)
		if(dna && dna.species)
			dna.species.spec_revival(src)
