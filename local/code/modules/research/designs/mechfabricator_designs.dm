/datum/design/borg_suit
	name = "Cybernetic Endoskeleton"

/datum/design/borg_chest
	name = "Basic Torso"
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS,
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_BASIC_LIMBS,
	)

/datum/design/borg_head
	name = "Basic Head"
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS,
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_BASIC_LIMBS,
	)

/datum/design/borg_l_arm
	name = "Basic Left Arm"
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS,
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_BASIC_LIMBS,
	)

/datum/design/borg_r_arm
	name = "Basic Right Arm"
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS,
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_BASIC_LIMBS,
	)

/datum/design/borg_l_leg
	name = "Basic Left Leg"
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS,
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_BASIC_LIMBS,
	)

/datum/design/borg_r_leg
	name = "Basic Right Leg"
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS,
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_BASIC_LIMBS,
	)

// Design Datums
/datum/design/customizable_head
	name = "Customizable Head"
	id = "customizable_head"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	build_path = /obj/item/bodypart/head/robot/effigy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_CUSTOMIZABLE_LIMBS,
		RND_CATEGORY_MECHFAB_SYNTH + RND_CATEGORY_MECHFAB_SYNTH_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/customizable_chest
	name = "Customizable Chest"
	id = "customizable_chest"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	build_path = /obj/item/bodypart/chest/robot/effigy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_CUSTOMIZABLE_LIMBS,
		RND_CATEGORY_MECHFAB_SYNTH + RND_CATEGORY_MECHFAB_SYNTH_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/customizable_l_arm
	name = "Customizable Left Arm"
	id = "customizable_l_arm"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	build_path = /obj/item/bodypart/arm/left/robot/effigy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_CUSTOMIZABLE_LIMBS,
		RND_CATEGORY_MECHFAB_SYNTH + RND_CATEGORY_MECHFAB_SYNTH_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/customizable_r_arm
	name = "Customizable Right Arm"
	id = "customizable_r_arm"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	build_path = /obj/item/bodypart/arm/right/robot/effigy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_CUSTOMIZABLE_LIMBS,
		RND_CATEGORY_MECHFAB_SYNTH + RND_CATEGORY_MECHFAB_SYNTH_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/customizable_l_leg
	name = "Customizable Left Leg"
	id = "customizable_l_leg"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	build_path = /obj/item/bodypart/leg/left/robot/effigy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_CUSTOMIZABLE_LIMBS,
		RND_CATEGORY_MECHFAB_SYNTH + RND_CATEGORY_MECHFAB_SYNTH_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/customizable_r_leg
	name = "Customizable Right Leg"
	id = "customizable_r_leg"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	build_path = /obj/item/bodypart/leg/right/robot/effigy
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_CUSTOMIZABLE_LIMBS,
		RND_CATEGORY_MECHFAB_SYNTH + RND_CATEGORY_MECHFAB_SYNTH_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
