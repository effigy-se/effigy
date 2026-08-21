/datum/techweb_node/gene_engineering/New()
	unlocked_designs += list(
		/datum/design/board/dna_fixer,
	)
	return ..()

// Hypospray upgrade
/datum/design/hypomkii/deluxe
	name = "Hypospray Mk. II Deluxe Upgrade"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/device/custom_kit/deluxe_hypo2
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)

// Hypospray Research
/datum/techweb_node/chem_synthesis/New()
	unlocked_designs += list(
		/datum/design/hypovial,
		/datum/design/hypovial/large,
		/datum/design/hypokit,
		/datum/design/hypomkii,
	)
	return ..()

/datum/techweb_node/medbay_equip_adv/New()
	unlocked_designs += list(
		/datum/design/hypokit/deluxe,
	)
	return ..()

/datum/techweb_node/alien_surgery/New()
	unlocked_designs += list(
		/datum/design/hypomkii/deluxe,
	)
	return ..()
