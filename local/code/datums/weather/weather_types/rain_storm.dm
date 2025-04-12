/datum/weather/rain_storm
	protected_areas = list(
		/area/taeloth/underground, \
		/area/taeloth/nearstation/bridge_roof/patio/under, \
		/area/taeloth/nearstation/bridge_crossway/deck, \
		) // outdoors = false also prevents you from using bluepirnts.. ough

// This sucks HARD but not as any fault of it's own.
/datum/weather/rain_storm/forever_storm
	telegraph_duration = 0
	weather_flags = parent_type::weather_flags | WEATHER_ENDLESS
	probability = 0
