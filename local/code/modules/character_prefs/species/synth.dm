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
		TRAIT_NO_DAMAGE_OVERLAY,
		TRAIT_NOCRITOVERLAY,
		TRAIT_NOHARDCRIT,
		TRAIT_NOSOFTCRIT,
		TRAIT_NOSTAMCRIT,
	)
	reagent_flags = PROCESS_SYNTHETIC
	body_markings = list(/datum/bodypart_overlay/simple/body_marking/lizard = "None")
	mutantheart = /obj/item/organ/heart/oil_pump
	mutantstomach = /obj/item/organ/stomach/fuel_generator
	mutantliver = /obj/item/organ/liver/cybernetic/tier2
	mutantbrain = /obj/item/organ/brain/cybernetic
	exotic_blood = /datum/reagent/fuel/oil
	exotic_bloodtype = BLOOD_TYPE_OIL
	bodytemp_heat_damage_limit = (BODYTEMP_NORMAL + 146) // 456 K / 183 C
	bodytemp_cold_damage_limit = (BODYTEMP_NORMAL - 80) // 230 K / -43 C
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


/datum/species/android/spec_revival(mob/living/carbon/human/target)
	if(internal_charge < 0.750 MEGA JOULES)
		internal_charge += 0.750 MEGA JOULES
	playsound(target.loc, 'sound/machines/chime.ogg', 50, TRUE)
	target.visible_message(span_notice("[target]'s LEDs flicker to life!"), span_notice("All systems nominal. You're back online!"))

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
