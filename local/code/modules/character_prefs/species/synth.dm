/datum/species/synth
	name = "Synthetic Humanoid"
	id = SPECIES_SYNTH
	inherent_biotypes = MOB_ROBOTIC | MOB_HUMANOID
	inherent_traits = list(
		TRAIT_CAN_STRIP,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RADIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_TOXIMMUNE,
		TRAIT_GENELESS,
		TRAIT_STABLEHEART,
		TRAIT_LIMBATTACHMENT,
		TRAIT_UNHUSKABLE,
		TRAIT_LITERATE,
		TRAIT_NOCRITDAMAGE, // We do our own handling of crit damage.
		TRAIT_ROBOTIC_DNA_ORGANS,
		TRAIT_SYNTH,
		TRAIT_SILICON_EMOTES_ALLOWED,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	reagent_flags = PROCESS_SYNTHETIC
	payday_modifier = 1.0 // Matches the rest of the pay penalties the non-human crew have
	death_sound = 'local/sound/mobs/humanoids/synth/hacked.ogg'
	species_language_holder = /datum/language_holder/machine
	mutant_organs = list(/obj/item/organ/cyberimp/arm/toolkit/power_cord)
	mutantbrain = /obj/item/organ/brain/synth
	mutantstomach = /obj/item/organ/stomach/synth
	mutantears = /obj/item/organ/ears/synth
	mutanttongue = /obj/item/organ/tongue/synth
	mutanteyes = /obj/item/organ/eyes/synth
	mutantlungs = /obj/item/organ/lungs/synth
	mutantheart = /obj/item/organ/heart/synth
	mutantliver = /obj/item/organ/liver/synth
	mutantappendix = null
	exotic_bloodtype =  BLOOD_TYPE_OIL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/effigy/bare,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/effigy/bare,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/effigy/bare,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/effigy/bare,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/effigy/bare,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/effigy/bare,
	)
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	coldmod = 1.2
	heatmod = 2 // TWO TIMES DAMAGE FROM BEING TOO HOT?! WHAT?! No wonder lava is literal instant death for us.
	siemens_coeff = 1 // Puts you in deep crit and near death but not outright dead
	/// The innate action that synths get, if they've got a screen selected on species being set.
	var/datum/action/innate/monitor_head/screen
	/// Set to TRUE if the species was emagged before
	var/emag_effect = FALSE

/datum/species/synth/spec_life(mob/living/carbon/human/human)
	. = ..()

	if(human.stat == SOFT_CRIT || human.stat == HARD_CRIT)
		human.adjustFireLoss(1) //Still deal some damage in case a cold environment would be preventing us from the sweet release to robot heaven
		human.adjust_bodytemperature(13) //We're overheating!!
		if(prob(10))
			to_chat(human, span_warning("Alert: Critical damage taken! Cooling systems failing!"))
			do_sparks(3, TRUE, human)

/datum/species/synth/spec_revival(mob/living/carbon/human/transformer)
	playsound(transformer.loc, 'sound/machines/chime.ogg', 50, TRUE)
	transformer.visible_message(span_notice("[transformer]'s [screen ? "monitor lights up" : "eyes flicker to life"]!"), span_notice("All systems nominal. You're back online!"))

/datum/species/synth/on_species_gain(mob/living/carbon/human/transformer, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()

	RegisterSignal(transformer, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emag_act))
	var/datum/action/sing_tones/sing_action = new
	sing_action.Grant(transformer)

/datum/species/synth/on_species_loss(mob/living/carbon/human/human)
	. = ..()

	UnregisterSignal(human, COMSIG_ATOM_EMAG_ACT)

	var/obj/item/organ/eyes/eyes = human.get_organ_slot(ORGAN_SLOT_EYES)

	if(eyes)
		eyes.eye_icon_state = initial(eyes.eye_icon_state)

	if(screen)
		screen.Remove(human)

/datum/species/synth/proc/on_emag_act(mob/living/carbon/human/source, mob/user)
	SIGNAL_HANDLER

	if(emag_effect)
		return
	emag_effect = TRUE
	playsound(source.loc, 'sound/misc/interference.ogg', 50)
	to_chat(source, span_warning("Alert: Security breach detected in central processing unit. Error Code: 540-EXO"))

/datum/species/synth/get_physical_attributes()
	return "Synths are distinguished by their constant need to nurture their internal battery; EMP weakness; \
		radiation and low pressure immunity - alongside the ability to attach lost (and \"found\"), limbs \
		without surgery."

/datum/species/synth/get_species_description()
	return "Remarkably varied in both physical appearance and specialization; Synths are an entirely robotic species \
		characterized by their hardiness, reliance on energy infrastructure - and specialization for low-pressure and \
		irradiated environments."

/datum/species/synth/get_species_lore()
	return list(
		"The collective term \"Synth\" was co-opted to describe the majority of mass-manufactured synthetic life \
	that dots the stars - though inexorably split down the middle between the \"TV Head\" Integrated Positronic Chassis; \
	and the relatively stronger-represented lizardlike forms that helm the Sentient Engine Liberation Front. Rarer \
	still are the fringer designs - those to look human; those to look all another.",

		"While their origins vary drastically; as do their purposes and peoples; languages and knowledge - Synths \
	are united by only the loosest definitions of history, with S.E.L.F. being the driving force behind their \
	continual integration with subsections of the larger galactic community; wherein they aren't expressly built for purpose regardless."
	)

/datum/species/synth/get_types_to_preload()
	return ..() - typesof(/obj/item/organ/cyberimp/arm/toolkit/power_cord) // Don't cache things that lead to hard deletions.

/datum/species/synth/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "robot",
		SPECIES_PERK_NAME = "Synthetic Benefits",
		SPECIES_PERK_DESC = "Unlike organics, you DON'T explode when faced with a vacuum! Additionally, your chassis is built with such strength as to \
		grant you immunity to OVERpressure! Just make sure that the extreme cold or heat doesn't fry your circuitry."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "star-of-life",
		SPECIES_PERK_NAME = "Unhuskable",
		SPECIES_PERK_DESC = "[plural_form] can't be husked, disappointing changelings galaxy-wide.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "music",
		SPECIES_PERK_NAME = "Tone Synthesizer",
		SPECIES_PERK_DESC = "[plural_form] can sing musical tones using an internal synthesizer.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "robot",
		SPECIES_PERK_NAME = "Synthetic Oddities",
		SPECIES_PERK_DESC = "[plural_form] are unable to gain nutrition from traditional foods. Instead, you must either consume welding fuel or extend a \
		wire from your arm to draw power from an APC. In addition to this, welders and wires are your sutures and mesh and only specific chemicals even metabolize inside \
		of you. This ranges from whiskey, to synthanol, to various obscure medicines. Finally, you suffer from a set of wounds exclusive to synthetics."
	))

	return perk_descriptions

/datum/species/synth/prepare_human_for_preview(mob/living/carbon/human/beepboop)
	beepboop.dna.ear_type = CYBERNETIC_TYPE
	beepboop.dna.features["ears"] = "No Ears"
	beepboop.dna.features["ears_color_1"] = "#333333"
	beepboop.dna.tail_type = CYBERNETIC_TYPE
	beepboop.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	beepboop.dna.features["frame_list"] = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/effigy/bare,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/effigy/bare,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/effigy/bare,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/effigy/bare,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/effigy/bare,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/effigy/bare,
	)
	regenerate_organs(beepboop)
	beepboop.update_body(is_creating = TRUE)
