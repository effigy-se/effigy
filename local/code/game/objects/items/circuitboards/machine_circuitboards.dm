/obj/item/circuitboard/machine/atmos_shield_gen/tier_two
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier2,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier2,
	)

/obj/item/circuitboard/machine/atmos_shield_gen/tier_three
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier3,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier3,
	)

/obj/item/circuitboard/machine/atmos_shield_gen/tier_four
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier4,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier4,
	)

/obj/item/circuitboard/machine/atmos_shield_gen/tier_five
	def_components = list(
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier5,
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier5,
	)

/obj/item/circuitboard/machine/bluespace_miner
	name = "Bluespace Miner"
	desc = "The bluespace miner is a machine that, when provided the correct temperature and pressure, will produce materials."
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/bluespace_miner
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 2,
	)

/obj/item/circuitboard/machine/dna_fixer
	name = "DNA Fixer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/dna_fixer
	req_components = list(/datum/stock_part/micro_laser = 1)

/obj/item/circuitboard/machine/scrap_beacon
	name = "Scrap Beacon"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/scrap_beacon
	req_components = list(/datum/stock_part/capacitor = 1)

/obj/item/circuitboard/machine/scrap_compactor
	name = "Scrap Compactor"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/scrap_compactor
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		)
