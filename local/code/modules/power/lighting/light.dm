/obj/machinery/light
	icon = 'local/icons/obj/lighting.dmi'
	overlay_icon = 'local/icons/obj/lighting_overlay.dmi'
	brightness = 7
	fire_colour = "#E85888"
	bulb_colour = LIGHT_COLOR_DEFAULT
	bulb_power = 1.15
	nightshift_light_color = null // Let the dynamic night shift color code handle this.
	bulb_low_power_colour = COLOR_STRONG_BLUE
	bulb_low_power_brightness_mul = 0.75
	bulb_low_power_pow_mul = 0.75
	bulb_low_power_pow_min = 0.75
	bulb_emergency_colour = LIGHT_COLOR_INTENSE_RED
	bulb_major_emergency_brightness_mul = 1
	power_consumption_rate = 15.9

/obj/machinery/light/dim
	bulb_colour = LIGHT_COLOR_DEFAULT
	bulb_power = 0.8

/obj/machinery/light/cold/dim
	bulb_power = 0.8

/obj/machinery/light/warm/dim
	bulb_power = 0.8

/obj/machinery/light/small
	brightness = 3.5
	nightshift_brightness = 3
	bulb_colour = LIGHT_COLOR_DEFAULT
	bulb_power = 1
	fire_colour = "#E85888"

/obj/machinery/light/cold
	bulb_colour = COLOR_LIGHT_FIXTURE_COLD
	nightshift_light_color = null

/obj/machinery/light/warm
	bulb_colour = LIGHT_COLOR_DEFAULT
	nightshift_light_color = null


#undef NIGHTSHIFT_POWER_MODIFIER
#undef NIGHTSHIFT_RANGE_MODIFIER
#undef NIGHTSHIFT_COLOR_MODIFIER
