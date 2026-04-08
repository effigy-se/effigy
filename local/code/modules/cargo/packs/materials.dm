/datum/supply_pack/materials/rawlumber
	name = "20 Towercap Logs"
	desc = "Set up a cookout or a classy beachside bonfire with these terrific towercaps!"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/grown/log)
	crate_name = "lumber crate"
	crate_type = /obj/structure/closet/crate/cargo

/datum/supply_pack/materials/rawlumber/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	for(var/i in 1 to 19)
		new /obj/item/grown/log(.)
