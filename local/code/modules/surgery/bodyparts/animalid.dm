/obj/item/bodypart/head/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID
	limb_id = SPECIES_ANIMALID
	is_dimorphic = FALSE

/obj/item/bodypart/chest/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID
	limb_id = SPECIES_ANIMALID

/obj/item/bodypart/arm/left/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID
	limb_id = SPECIES_ANIMALID

/obj/item/bodypart/arm/right/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID
	limb_id = SPECIES_ANIMALID

/obj/item/bodypart/leg/left/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID
	limb_id = SPECIES_ANIMALID

/obj/item/bodypart/leg/left/digitigrade/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID

/obj/item/bodypart/leg/left/digitigrade/animalid/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	if(limb_id == SPECIES_LIZARD)
		limb_id = SPECIES_ANIMALID

/obj/item/bodypart/leg/right/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID
	limb_id = SPECIES_ANIMALID

/obj/item/bodypart/leg/right/digitigrade/animalid
	icon_greyscale = BODYPART_ICON_ANIMALID

/obj/item/bodypart/leg/right/digitigrade/animalid/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	if(limb_id == SPECIES_LIZARD)
		limb_id = SPECIES_ANIMALID
