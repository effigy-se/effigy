/obj/item/organ/heart/oil_pump
	name = "liquid fuel generator"
	desc = "Burns fuel to generate power."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/heart/oil_pump/Initialize(mapload)
	. = ..()

/obj/item/organ/heart/oil_pump/on_life(seconds_per_tick, times_fired)
	. = ..()
