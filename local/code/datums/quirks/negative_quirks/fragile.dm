/datum/quirk/fragile
	name = "Fragile"
	desc = "You feel incredibly fragile. Burns and bruises hurt you more than the average person!"
	value = -6
	medical_record_text = "Patient's body has adapted to low gravity. Sadly, low gravity environments are not conducive to strong bone development."
	icon = FA_ICON_SKULL

/datum/quirk/fragile/post_add()
	. = ..()
	MODIFY_PHYSIOLOGY(quirk_holder, BRUTE, 1.15)
	MODIFY_PHYSIOLOGY(quirk_holder, BURN, 1.15)

/datum/quirk/fragile/remove()
	. = ..()
	MODIFY_PHYSIOLOGY(quirk_holder, BRUTE, 1 / 1.15)
	MODIFY_PHYSIOLOGY(quirk_holder, BURN, 1 / 1.15)
