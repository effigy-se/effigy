/obj/item/reagent_containers/applicator/pill/liquid_solder
	name = "liquid solder pill"
	desc = "Used to treat synthetic brain damage."
	icon_state = "pill21"
	list_reagents = list(/datum/reagent/medicine/liquid_solder = 30)

// Lower quantity solder pill.
// 50u pills heal 375 brain damage, 10u pills heal 75.
/obj/item/reagent_containers/applicator/pill/liquid_solder/braintumor
	list_reagents = list(/datum/reagent/medicine/liquid_solder = 10)

/obj/item/reagent_containers/applicator/pill/nanite_slurry
	name = "nanite slurry pill"
	desc = "Used to repair robotic bodyparts."
	icon_state = "pill18"
	list_reagents = list(/datum/reagent/medicine/nanite_slurry = 19)

/obj/item/reagent_containers/applicator/pill/system_cleaner
	name = "system cleaner pill"
	desc = "Used to detoxify synthetic bodies."
	icon_state = "pill7"
	list_reagents = list(/datum/reagent/medicine/system_cleaner = 30)

/obj/item/reagent_containers/applicator/pill/lidocaine
	name = "lidocaine pill"
	desc = "A local anesthetic medication used in surgery to numb patients."
	icon_state = "pill3"
	layers_remaining = 1
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 17,
		/datum/reagent/consumable/astrotame = 7,
	)
