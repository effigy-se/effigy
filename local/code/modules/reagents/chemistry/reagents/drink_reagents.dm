// modular drink reagents
/datum/reagent/consumable/pinkmilk
	name = "Strawberry Milk"
	description = "A drink of a bygone era of milk and artificial sweetener back on a rock."
	color = "#f76aeb"//rgb(247, 106, 235)
	quality = DRINK_VERYGOOD
	taste_description = "sweet strawberry and milk cream"

/datum/glass_style/drinking_glass/pinkmilk
	required_drink_type = /datum/reagent/consumable/pinkmilk
	icon = 'local/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "pinkmilk"
	name = "tall glass of strawberry milk"
	desc = "Delicious flavored strawberry syrup mixed with milk."

/datum/reagent/consumable/pinkmilk/on_mob_life(mob/living/carbon/M)
	if(prob(15))
		to_chat(M, span_notice("[pick("You cant help to smile.","You feel nostalgia all of sudden.","You remember to relax.")]"))
	..()
	. = 1

/datum/reagent/consumable/pinktea //Tiny Tim song
	name = "Strawberry Tea"
	description = "A timeless classic!"
	color = "#f76aeb"//rgb(247, 106, 235)
	quality = DRINK_VERYGOOD
	taste_description = "sweet tea with a hint of strawberry"

/datum/glass_style/drinking_glass/pinktea
	required_drink_type = /datum/reagent/consumable/pinktea
	icon = 'local/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "pinktea"
	name = "mug of strawberry tea"
	desc = "Delicious traditional tea flavored with strawberries."

/datum/reagent/consumable/pinktea/on_mob_life(mob/living/carbon/M)
	if(prob(10))
		to_chat(M, span_notice("[pick("Diamond skies where white deer fly.","Sipping strawberry tea.","Silver raindrops drift through timeless, Neverending June.","Crystal ... pearls free, with love!","Beaming love into me.")]"))
	..()
	. = TRUE

/datum/reagent/consumable/catnip_tea
	name = "Catnip Tea"
	description = "A sleepy and tasty catnip tea!"
	color = "#101000" // rgb: 16, 16, 0
	taste_description = "sugar and catnip"

/datum/glass_style/drinking_glass/catnip_tea
	required_drink_type = /datum/reagent/consumable/catnip_tea
	icon = 'local/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "catnip_tea"
	name = "glass of catnip tea"
	desc = "A purrfect drink for a cat."

/datum/reagent/consumable/catnip_tea/on_mob_life(mob/living/carbon/M)
	M.adjustStaminaLoss(min(50 - M.getStaminaLoss(), 3))
	if(isfelinid(M))
		if(prob(20))
			M.emote("nya")
		if(prob(20))
			to_chat(M, span_notice("[pick("Headpats feel nice.", "Backrubs would be nice.", "Mew")]"))
	else
		to_chat(M, span_notice("[pick("I feel oddly calm.", "I feel relaxed.", "Mew?")]"))
	..()

// Synth reagents
/datum/reagent/consumable/laughter/synth
	name = "humorlib.dll"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/consumable/laughter/synth)

/datum/reagent/consumable/superlaughter/synth
	name = "HAHAHAHAHA.exe"
	chemical_flags = REAGENT_NEUROWARE_PACKAGE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/consumable/superlaughter/synth)
