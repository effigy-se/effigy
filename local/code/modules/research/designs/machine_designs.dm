/datum/design/board/scrap_compactor
	name = "Scrap Compactor Board"
	desc = "The circuit board for a scrap compactor."
	build_path = /obj/item/circuitboard/machine/scrap_compactor
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/bluespace_miner
	name = "Bluespace Miner Board"
	desc = "Allows for the construction of circuit boards used to build a bluespace miner."
	build_path = /obj/item/circuitboard/machine/bluespace_miner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/dna_fixer
	name = "Machine Design (DNA Fixer)"
	desc = "The circuit board for a DNA Fixer."
	build_path = /obj/item/circuitboard/machine/dna_fixer
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
