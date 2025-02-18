/datum/supply_pack/service/buildabar
	name = "Build a Bar Crate"
	desc = "Looking to set up your own little safe haven? Get a jump-start on it with this handy kit. Contains circuitboards for bar equipment, some parts, and some basic bartending supplies. (Glass not included)"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/storage/box/drinkingglasses,
		/obj/item/storage/box/drinkingglasses,
		/obj/item/storage/part_replacer/cargo,
		/obj/item/stack/sheet/iron/ten,
		/obj/item/stack/sheet/iron/five,
		/obj/item/stock_parts/power_store/cell/high,
		/obj/item/stock_parts/power_store/cell/high,
		/obj/item/stack/cable_coil,
		/obj/item/book/manual/wiki/barman_recipes,
		/obj/item/reagent_containers/cup/glass/shaker,
		/obj/item/circuitboard/machine/chem_dispenser/drinks/beer,
		/obj/item/circuitboard/machine/chem_dispenser/drinks,
		/obj/item/circuitboard/machine/dish_drive,
	)
	crate_name = "build a bar crate"
	crate_type = /obj/structure/closet/crate/nakamura

/datum/supply_pack/service/janitor/janpimp
	name = "Custodial Cruiser"
	desc = "Clown steal your ride? Assistant lock it in the dorms? Order a new one and get back to cleaning in style!"
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_JANITOR
	contains = list(
		/obj/vehicle/ridden/janicart,
		/obj/item/key/janitor,
	)
	crate_name = "pussy wagon crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/service/janitor/janpimpkey
	name = "Cruiser Keys"
	desc = "Replacement Keys for the Custodial Cruiser."
	cost = CARGO_CRATE_VALUE * 1.5
	access = ACCESS_JANITOR
	contains = list(/obj/item/key/janitor)
	crate_name = "key crate"
	crate_type = /obj/structure/closet/crate/secure/hydroponics

/datum/supply_pack/service/janitor/janpremium
	name = "Janitor Supplies"
	desc = "For when the mess is too big for a mop to handle. Contains, several cleaning grenades, some spare bottles of ammonia, two bars of soap, and an MCE (or Massive Cleaning Explosive)."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/soap/nanotrasen,
		/obj/item/soap/nanotrasen,
		/obj/item/grenade/clusterbuster/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/reagent_containers/cup/bottle/ammonia,
		/obj/item/reagent_containers/cup/bottle/ammonia,
		/obj/item/reagent_containers/cup/bottle/ammonia,
	)
	crate_name = "janitorial crate"
	crate_type = /obj/structure/closet/crate/hydroponics
