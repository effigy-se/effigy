/datum/species/android
	name = "Synth"
	id = SPECIES_ANDROID
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_GENELESS,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTLOWPRESSURE,
		/* TG traits removed
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_PIERCEIMMUNE,
		TRAIT_OVERDOSEIMMUNE,
		TRAIT_TOXIMMUNE,
		TRAIT_NOFIRE,
		TRAIT_NOBLOOD,
		TRAIT_NO_UNDERWEAR,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,*/
		TRAIT_UNHUSKABLE,
		TRAIT_STABLEHEART,
		TRAIT_STABLELIVER,
	)
	reagent_flags = PROCESS_SYNTHETIC
	body_markings = list(/datum/bodypart_overlay/simple/body_marking/lizard = "None")
	mutantheart = /obj/item/organ/heart/cybernetic/tier2
	mutantstomach = /obj/item/organ/stomach/cybernetic/tier2
	mutantliver = /obj/item/organ/liver/cybernetic/tier2

	bodytemp_heat_damage_limit = (BODYTEMP_NORMAL + 146) // 456 K / 183 C
	bodytemp_cold_damage_limit = (BODYTEMP_NORMAL - 80) // 230 K / -43 C
	/// Ability to recharge!
	var/datum/action/innate/power_cord/power_cord
	/// Hud element to display our energy level
	var/atom/movable/screen/synth/energy/energy_tracker
	/// How much energy we start with
	var/internal_charge = SYNTH_CHARGE_MAX

/datum/species/android/get_physical_attributes()
	return "Synths are distinguished by their constant need to nurture their internal battery; EMP weakness; \
		radiation and low pressure immunity - alongside the ability to attach lost (and \"found\"), limbs \
		without surgery."

/datum/species/android/get_species_description()
	return "Remarkably varied in both physical appearance and specialization; Synths are an entirely robotic species \
		characterized by their hardiness, reliance on energy infrastructure - and specialization for low-pressure and \
		irradiated environments."

/datum/species/android/get_species_lore()
	return list(
		"The collective term \"Synth\" was co-opted to describe the majority of mass-manufactured synthetic life \
	that dots the stars - though inexorably split down the middle between the \"TV Head\" Integrated Positronic Chassis; \
	and the relatively stronger-represented lizardlike forms that helm the Sentient Engine Liberation Front. Rarer \
	still are the fringer designs - those to look human; those to look all another.",

		"While their origins vary drastically; as do their purposes and peoples; languages and knowledge - Synths \
	are united by only the loosest definitions of history, with S.E.L.F. being the driving force behind their \
	continual integration with subsections of the larger galactic community; wherein they aren't expressly built for purpose regardless."
	)

/datum/species/android/on_species_gain(mob/living/carbon/target, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(ishuman(target))
		power_cord = new
		power_cord.Grant(target)

/datum/species/android/on_species_loss(mob/living/carbon/target, datum/species/new_species, pref_load)
	. = ..()
	if(power_cord)
		power_cord.Remove(target)
	if(target.hud_used)
		var/datum/hud/hud_used = target.hud_used
		hud_used.infodisplay -= energy_tracker
		QDEL_NULL(energy_tracker)

/datum/species/android/spec_revival(mob/living/carbon/human/target)
	if(internal_charge < 0.750 MEGA JOULES)
		internal_charge += 0.750 MEGA JOULES
	playsound(target.loc, 'sound/machines/chime.ogg', 50, TRUE)
	target.visible_message(span_notice("[target]'s LEDs flicker to life!"), span_notice("All systems nominal. You're back online!"))

/datum/species/android/spec_life(mob/living/carbon/human/target, seconds_per_tick, times_fired)
	. = ..()
	handle_hud(target)

	if(target.stat == SOFT_CRIT || target.stat == HARD_CRIT)
		target.adjustFireLoss(1 * seconds_per_tick) //Still deal some damage in case a cold environment would be preventing us from the sweet release to robot heaven
		target.adjust_bodytemperature(13 * seconds_per_tick) //We're overheating!!
		if(prob(10))
			to_chat(target, span_warning("Alert: Critical damage taken! Cooling systems failing!"))
			do_sparks(3, FALSE, target)

	if(target.stat == DEAD)
		return
	if(HAS_TRAIT(target, TRAIT_SYNTH_CHARGING))
		return
	if(internal_charge > SYNTH_ENERGY_CONSUMPTION)
		internal_charge -= SYNTH_ENERGY_CONSUMPTION
		target.remove_movespeed_modifier(/datum/movespeed_modifier/synth_nocharge)
	// Once out of power, you begin to move terribly slowly
	else // EffigyEdit TODO: ARGH make this only run once!
		//to_chat(target, span_warning("Alert: Internal charge critically low!"))
		target.add_movespeed_modifier(/datum/movespeed_modifier/synth_nocharge)

/datum/species/android/proc/handle_hud(mob/living/carbon/human/target)
	// update it
	if(energy_tracker)
		energy_tracker.update_energy_hud(internal_charge)
	// initialize it
	else if(target.hud_used)
		var/datum/hud/hud_used = target.hud_used
		energy_tracker = new(null, hud_used)
		hud_used.infodisplay += energy_tracker

		target.hud_used.show_hud(target.hud_used.hud_version)

/datum/species/android/prepare_human_for_preview(mob/living/carbon/human/robot_for_preview)
	robot_for_preview.dna.ear_type = CYBERNETIC_TYPE
	robot_for_preview.dna.features["ears"] = "No Ears"
	robot_for_preview.dna.features["ears_color_1"] = "#333333"
	robot_for_preview.dna.tail_type = CYBERNETIC_TYPE
	robot_for_preview.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	robot_for_preview.dna.features["frame_list"] = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/android/sgm,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/android/sgm,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/android/sgm,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/android/sgm,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/android/sgm,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/android/sgm)
	regenerate_organs(robot_for_preview)
	robot_for_preview.update_body(is_creating = TRUE)

/datum/movespeed_modifier/synth_nocharge
	multiplicative_slowdown = CRAWLING_ADD_SLOWDOWN
	flags = IGNORE_NOSLOW

#define SYNTH_HUD_TEXT(valuecolor, value) MAPTEXT("<div align='center' valign='middle'><font color='[valuecolor]'>[round((value/14000), 1)]%</font></div>")

/atom/movable/screen/synth
	icon = 'local/icons/hud/synth_hud.dmi'

/atom/movable/screen/synth/energy
	name = "internal charge"
	icon_state = "energy_display"
	screen_loc = "EAST-1:28,CENTER+1:21"

/atom/movable/screen/synth/energy/proc/update_energy_hud(internal_charge)
	maptext = SYNTH_HUD_TEXT(hud_text_color(internal_charge), internal_charge)
	if(internal_charge <= 300 KILO JOULES)
		icon_state = "energy_display_low"
	else
		icon_state = "energy_display"

/atom/movable/screen/synth/energy/proc/hud_text_color(internal_charge)
	return internal_charge > 300 KILO JOULES ? "#e7e9ee" : "#f0197d"

#undef SYNTH_HUD_TEXT
