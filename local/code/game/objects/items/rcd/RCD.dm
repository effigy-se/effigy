/// Midrange model of RCD, with Combat being the high end
/obj/item/construction/rcd/mkii
	name = "RCD Mk II"
	desc = "A device used to rapidly build and deconstruct. Upgraded from the standard model with improved material storage. Reload with iron, plasteel, glass or compressed matter cartridges."
	icon = 'local/icons/obj/tools.dmi'
	icon_state = "ircd"
	inhand_icon_state = "ircd"
	max_matter = 240
	matter = 240
	construction_upgrades = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS | RCD_UPGRADE_NO_FREQUENT_USE_COOLDOWN

/obj/item/construction/rcd/industrial
	name = "RCD Mk III"
	desc = "A device used to rapidly build and deconstruct. Upgraded from the standard model with improved speed and capacity. Reload with iron, plasteel, glass or compressed matter cartridges."
	icon_state = "ircd"
	inhand_icon_state = "ircd"
	max_matter = 480
	matter = 480
	delay_mod = 0.9
	construction_upgrades = RCD_ALL_UPGRADES

/obj/item/rcd_ammo/mkii
	name = "RCD Mk II matter cartridge"
	desc = "A cartridge with one complete refill for an RCD Mk II."
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=54000, /datum/material/glass=44000)
	ammoamt = 200

/obj/item/storage/box/rcd_ammo
	name = "RCD Mk II matter box"
	desc = "A durable box with refill cartridges for an RCD Mk II."
	icon_state = "plasticbox"
	illustration = "swab"
	custom_materials = list(/datum/material/plastic = 1000)

/obj/item/storage/box/rcd_ammo/PopulateContents()
	for(var/i in 1 to 4)
		new/obj/item/rcd_ammo/mkii(src)
