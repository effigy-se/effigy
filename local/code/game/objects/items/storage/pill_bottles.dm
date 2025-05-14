// Pill bottles for synthetic healing medications
/obj/item/storage/pill_bottle/liquid_solder
	name = "bottle of liquid solder pills"
	desc = "Contains pills used to treat synthetic brain damage."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/liquid_solder

// Contains 4 liquid_solder pills instead of 7, and 10u pills instead of 50u.
// 50u pills heal 375 brain damage, 10u pills heal 75.
/obj/item/storage/pill_bottle/liquid_solder/braintumor
	desc = "Contains diluted pills used to treat synthetic brain damage symptoms. Take one when feeling lightheaded."
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/liquid_solder/braintumor

/obj/item/storage/pill_bottle/nanite_slurry
	name = "bottle of nanite slurry pills"
	desc = "Contains pills used to treat robotic bodyparts."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/nanite_slurry

/obj/item/storage/pill_bottle/system_cleaner
	name = "bottle of system cleaner pills"
	desc = "Contains pills used to detoxify synthetic bodies."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/system_cleaner

/obj/item/storage/pill_bottle/lidocaine
	name = "box of lidocaine pills"
	desc = "A package of local anesthetic medication, used in surgery to numb patients."
	icon = 'local/icons/obj/storage/medkit.dmi'
	icon_state = "lidocaine_box"
	custom_price = PAYCHECK_LOWER * 3
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/lidocaine
