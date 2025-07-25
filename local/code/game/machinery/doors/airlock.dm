#define AIRLOCK_LIGHT_POWER_LOW 1
#define AIRLOCK_LIGHT_POWER_MID 1.4
#define AIRLOCK_LIGHT_POWER_HIGH 2.1
#define AIRLOCK_LIGHT_RANGE_LOW 1.4
#define AIRLOCK_LIGHT_RANGE_HIGH 1.5

// Airlock light states, used for generating the light overlays
#define AIRLOCK_LIGHT_OPENING_RAPID "opening_rapid"
#define AIRLOCK_LIGHT_POWERON "poweron"
#define AIRLOCK_LIGHT_ENGINEERING "engineering"
#define AIRLOCK_LIGHT_FIRE "fire"

#define AIRLOCK_FRAME_OPENING_RAPID "opening_rapid"

/obj/machinery/door/airlock
	doorOpen = 'local/sound/machines/airlock/airlock_open.ogg'
	doorClose = 'local/sound/machines/airlock/airlock_close.ogg'
	var/doorOpenRapid = 'local/sound/machines/airlock/airlock_open_rapid.ogg'
	boltUp = 'local/sound/machines/airlock/bolts_up.ogg'
	boltDown = 'local/sound/machines/airlock/bolts_down.ogg'
	light_dir = NONE
	///Airlock features such as lights, access restrictions, animation type
	var/airlock_features = ENV_LIGHTS
	///Is this door external? E.g. does it lead to space? Shuttle docking systems bolt doors with this flag.
	var/external = FALSE

/obj/machinery/door/airlock/Initialize(mapload)
	. = ..()
	if(mapload)
		RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(set_animation_type))

/obj/machinery/door/airlock/proc/set_animation_type()
	SIGNAL_HANDLER
	UnregisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME)
	if(airlock_features & LEGACY_ANIMATIONS)
		return

	if(length(req_access) || length(req_one_access))
		airlock_features = airlock_features | ACCESS_RESTRICTED
	else
		airlock_features = airlock_features & ~ACCESS_RESTRICTED

/obj/machinery/door/airlock/power_change()
	..()
	set_animation()

/obj/machinery/door/airlock/animation_length(animation)
	if(airlock_features & LEGACY_ANIMATIONS)
		return legacy_animation_length(animation)

	switch(animation)
		if(DOOR_OPENING_RAPID_ANIMATION)
			return 0.8 SECONDS
		if(DOOR_OPENING_ANIMATION)
			return 1.3 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 2.1 SECONDS

/obj/machinery/door/airlock/animation_segment_delay(animation)
	if(airlock_features & LEGACY_ANIMATIONS)
		return legacy_segment_delay(animation)

	if(rapid_open)
		return rapid_segment_delay(animation)

	switch(animation)
		if(AIRLOCK_OPENING_TRANSPARENT)
			return 0.7 SECONDS
		if(AIRLOCK_OPENING_PASSABLE)
			return 0.7 SECONDS
		if(AIRLOCK_OPENING_FINISHED)
			return 1.3 SECONDS
		if(AIRLOCK_CLOSING_UNPASSABLE)
			return 1.2 SECONDS
		if(AIRLOCK_CLOSING_OPAQUE)
			return 1.5 SECONDS
		if(AIRLOCK_CLOSING_FINISHED)
			return 2.1 SECONDS

/obj/machinery/door/airlock/proc/legacy_animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 0.6 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 2.0 SECONDS

/obj/machinery/door/airlock/proc/legacy_segment_delay(animation)
	switch(animation)
		if(AIRLOCK_OPENING_TRANSPARENT)
			return 0.1 SECONDS
		if(AIRLOCK_OPENING_PASSABLE)
			return 0.4 SECONDS
		if(AIRLOCK_OPENING_FINISHED)
			return 0.6 SECONDS
		if(AIRLOCK_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(AIRLOCK_CLOSING_OPAQUE)
			return 0.6 SECONDS
		if(AIRLOCK_CLOSING_FINISHED)
			return 2.0 SECONDS

/obj/machinery/door/airlock/proc/rapid_segment_delay(animation)
	switch(animation)
		if(AIRLOCK_OPENING_TRANSPARENT)
			return 0.1 SECONDS
		if(AIRLOCK_OPENING_PASSABLE)
			return 0.4 SECONDS
		if(AIRLOCK_OPENING_FINISHED)
			return 0.8 SECONDS
		if(AIRLOCK_CLOSING_UNPASSABLE)
			return 1.2 SECONDS
		if(AIRLOCK_CLOSING_OPAQUE)
			return 1.5 SECONDS
		if(AIRLOCK_CLOSING_FINISHED)
			return 2.1 SECONDS

/obj/machinery/door/airlock/update_overlays()
	. = ..()
	var/frame_state
	var/light_state = AIRLOCK_LIGHT_POWERON
	var/new_light_power = AIRLOCK_LIGHT_POWER_LOW
	var/new_light_range = AIRLOCK_LIGHT_RANGE_HIGH
	var/new_light_color = COLOR_STARLIGHT
	if(machine_stat & MAINT) // in the process of being emagged
		frame_state = AIRLOCK_FRAME_CLOSED
	else switch(airlock_state)
		if(AIRLOCK_CLOSED)
			frame_state = AIRLOCK_FRAME_CLOSED
			if(locked)
				light_state = AIRLOCK_LIGHT_BOLTS
				new_light_power = AIRLOCK_LIGHT_POWER_MID
				new_light_range = AIRLOCK_LIGHT_RANGE_HIGH
				new_light_color = LIGHT_COLOR_BUBBLEGUM
			else if(!normalspeed)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				new_light_color = COLOR_EFFIGY_HOT_PINK
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				new_light_color = COLOR_EFFIGY_SPRING_GREEN
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				new_light_power = AIRLOCK_LIGHT_POWER_MID
				new_light_range = AIRLOCK_LIGHT_RANGE_LOW
				new_light_color = LIGHT_COLOR_PINK
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				new_light_color = COLOR_EFFIGY_HOT_PINK
		if(AIRLOCK_DENY)
			frame_state = AIRLOCK_FRAME_CLOSED
			light_state = AIRLOCK_LIGHT_DENIED
			new_light_power = AIRLOCK_LIGHT_POWER_MID
			new_light_range = AIRLOCK_LIGHT_RANGE_LOW
			new_light_color = LIGHT_COLOR_BUBBLEGUM
		if(AIRLOCK_CLOSING)
			frame_state = AIRLOCK_FRAME_CLOSING
			light_state = AIRLOCK_LIGHT_CLOSING
			new_light_power = AIRLOCK_LIGHT_POWER_HIGH
			new_light_range = AIRLOCK_LIGHT_RANGE_LOW
			new_light_color = COLOR_EFFIGY_HOT_PINK
		if(AIRLOCK_OPEN)
			frame_state = AIRLOCK_FRAME_OPEN
			new_light_power = AIRLOCK_LIGHT_POWER_MID
			new_light_range = AIRLOCK_LIGHT_RANGE_LOW
			if(locked)
				light_state = AIRLOCK_LIGHT_BOLTS
				new_light_color = LIGHT_COLOR_BUBBLEGUM
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				new_light_color = LIGHT_COLOR_DEFAULT
			else if(!normalspeed)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				new_light_color = COLOR_EFFIGY_HOT_PINK
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				new_light_color = COLOR_EFFIGY_SPRING_GREEN
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				new_light_color = COLOR_EFFIGY_HOT_PINK
			else
				new_light_color = COLOR_EFFIGY_SPRING_GREEN
			light_state += "_open"
		if(AIRLOCK_OPENING)
			if(rapid_open)
				frame_state = AIRLOCK_FRAME_OPENING_RAPID
				light_state = AIRLOCK_LIGHT_OPENING_RAPID
			else
				frame_state = AIRLOCK_FRAME_OPENING
				light_state = AIRLOCK_LIGHT_OPENING
			new_light_power = AIRLOCK_LIGHT_POWER_HIGH
			new_light_range = AIRLOCK_LIGHT_RANGE_LOW
			new_light_color = COLOR_EFFIGY_SPRING_GREEN

	if(airlock_material)
		. += get_airlock_overlay("[airlock_material]_[frame_state]", overlays_file, src, em_block = TRUE)
	else
		. += get_airlock_overlay("fill_[frame_state]", icon, src, em_block = TRUE)

	if(lights && hasPower() && (airlock_features & ENV_LIGHTS))
		. += get_airlock_overlay("lights_[light_state]", overlays_file, src, em_block = FALSE)

		if(multi_tile && filler)
			filler.set_light(l_range = new_light_range, l_power = new_light_power, l_color = new_light_color, l_on = TRUE)

		set_light(l_range = new_light_range, l_power = new_light_power, l_color = new_light_color, l_on = TRUE)
	else
		set_light(l_on = FALSE)

	if(panel_open)
		. += get_airlock_overlay("panel_[frame_state][security_level ? "_protected" : null]", overlays_file, src, em_block = TRUE)
	if(frame_state == AIRLOCK_FRAME_CLOSED && welded)
		. += get_airlock_overlay("welded", overlays_file, src, em_block = TRUE)

	if(machine_stat & MAINT) // in the process of being emagged
		. += get_airlock_overlay("sparks", overlays_file, src, em_block = FALSE)

	if(hasPower())
		if(frame_state == AIRLOCK_FRAME_CLOSED)
			if(atom_integrity < integrity_failure * max_integrity)
				. += get_airlock_overlay("sparks_broken", overlays_file, src, em_block = FALSE)
			else if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_damaged", overlays_file, src, em_block = FALSE)
		else if(frame_state == AIRLOCK_FRAME_OPEN)
			if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_open", overlays_file, src, em_block = FALSE)

	if(note)
		. += get_airlock_overlay(get_note_state(frame_state), note_overlay_file, src, em_block = TRUE)

	if(frame_state == AIRLOCK_FRAME_CLOSED && seal)
		. += get_airlock_overlay("sealed", overlays_file, src, em_block = TRUE)

	if(hasPower() && unres_sides && frame_state == AIRLOCK_FRAME_CLOSED && light_state == AIRLOCK_LIGHT_POWERON)
		for(var/heading in list(NORTH,SOUTH,EAST,WEST))
			if(!(unres_sides & heading))
				continue
			. += get_airlock_overlay("unres_[heading]", overlays_file, src, em_block = FALSE)

/obj/machinery/door/airlock/open(forced = DEFAULT_DOOR_CHECKS)
	if(!(airlock_features & LEGACY_ANIMATIONS) && !(airlock_features & ACCESS_RESTRICTED))
		rapid_open()

	return ..()

/obj/machinery/door/airlock
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	post_init_icon_state = "closed"
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#757278#757278"

/obj/machinery/door/airlock/atmos
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/atmos"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/atmos
	greyscale_colors = "#52b4e9#757278#7cb8dd"

/obj/machinery/door/airlock/command
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/command"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/command
	greyscale_colors = "#1987c2#4d4d4d#ffd66e"

/obj/machinery/door/airlock/engineering
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/engineering"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/engineering
	greyscale_colors = "#efb341#757278#e39825"

/obj/machinery/door/airlock/hydroponics
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/hydroponics"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#46c26d#52b4e9"

/obj/machinery/door/airlock/maintenance
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/maintenance"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#D1D0D2#757278"

/obj/machinery/door/airlock/maintenance/external
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/maintenance/external"
	greyscale_colors = "#d65e2f#757278"

/obj/machinery/door/airlock/medical
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/medical"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/medical
	greyscale_colors = "#52b4e9#eeeeff#eeeeff"

/obj/machinery/door/airlock/mining
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/mining"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/cargo
	greyscale_colors = "#915416#757278#915416"

/obj/machinery/door/airlock/research
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/research"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/science
	greyscale_colors = "#be64ad#eeeeff#eeeeff"

/obj/machinery/door/airlock/science
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/science"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/science
	greyscale_colors = "#aa3ec3#eeeeff#eeeeff"

/obj/machinery/door/airlock/security
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/security"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/security
	greyscale_colors = "#cf3249#4d4d4d#ab293c"

/obj/machinery/door/airlock/virology
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/virology"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/viro
	greyscale_colors = "#46c26d#eeeeff#eeeeff"

/obj/machinery/door/airlock/silver
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/silver"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#D1D0D2#D1D0D2"

/obj/machinery/door/airlock/public
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/public"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#D1D0D2#D1D0D2"

/obj/machinery/door/airlock/public/glass/no_lights
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	airlock_features = parent_type::airlock_features & ~ENV_LIGHTS

/**
 * Misc
 */
/obj/machinery/door/airlock/vault
	icon = 'local/icons/obj/doors/airlocks/vault/vault.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/vault/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/hatch
	icon = 'local/icons/obj/doors/airlocks/hatch/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/hatch/overlays.dmi'
	note_overlay_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/maintenance_hatch
	icon = 'local/icons/obj/doors/airlocks/hatch/maintenance.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/hatch/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/highsecurity
	icon = 'local/icons/obj/doors/airlocks/highsec/highsec.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/highsec/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/shuttle
	icon = 'local/icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/shuttle/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null
	external = TRUE

/obj/machinery/door/airlock/abductor
	icon = 'local/icons/obj/doors/airlocks/abductor/abductor_airlock.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/abductor/overlays.dmi'
	note_overlay_file = 'icons/obj/doors/airlocks/external/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/cult
	name = "cult airlock"
	icon = 'local/icons/obj/doors/airlocks/cult/runed/cult.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/cult/runed/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/cult/unruned
	icon = 'local/icons/obj/doors/airlocks/cult/unruned/cult.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/cult/unruned/overlays.dmi'

/obj/machinery/door/airlock/centcom
	icon = 'local/icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/centcom/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/grunge
	icon = 'local/icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/centcom/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/freezer
	icon = 'local/icons/obj/doors/airlocks/station/freezer.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/**
 * External
 */
/obj/machinery/door/airlock/external
	icon = 'local/icons/obj/doors/airlocks/external/external.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/external/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null
	external = TRUE

/obj/machinery/door/airlock/survival_pod
	icon = 'local/icons/obj/doors/airlocks/external/external.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/external/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/**
 * Multi-tile
 */

/obj/machinery/door/airlock/multi_tile
	icon = 'local/icons/obj/doors/airlocks/multi_tile/public/glass.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/multi_tile/public/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null
	airlock_features = NONE

/**
 * Tram
 */

/obj/machinery/door/airlock/tram
	icon = 'icons/obj/doors/airlocks/tram/tram.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/tram/tram-overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/tram/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, l_angle, l_dir, l_height, l_on)
	return

/**
 * Mineral/Material
 */

/obj/machinery/door/airlock/material
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/material"
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#757278"
	assemblytype = /obj/structure/door_assembly/door_assembly_material

/obj/machinery/door/airlock/bananium
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/bananium"
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#FFFF69"
	doorOpen = 'sound/items/bikehorn.ogg'

/obj/machinery/door/airlock/gold
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/gold"
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#EDBB31"

/obj/machinery/door/airlock/diamond
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/diamond"
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#7DF9FF"

/obj/machinery/door/airlock/uranium
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/uranium"
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#21FA90"

/obj/machinery/door/airlock/plasma
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/plasma"
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#F0197D"

/obj/machinery/door/airlock/sandstone
	icon = 'icons/map_icons/airlocks.dmi'
	icon_state = "/obj/machinery/door/airlock/sandstone"
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#DFCEAC"

/obj/machinery/door/airlock/wood
	icon = 'local/icons/obj/doors/airlocks/station/wood.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/titanium
	icon = 'local/icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/shuttle/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/bronze
	icon = 'local/icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/clockwork/overlays.dmi'
	icon_state = "closed"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/**
 * Effigy
 */

/obj/machinery/door/airlock/service
	icon = 'icons/map_icons/airlocks.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	icon_state = "/obj/machinery/door/airlock/service"
	greyscale_config = /datum/greyscale_config/airlock_effigy/service
	greyscale_colors = "#46c26d#4d4d4d#369655"

/obj/machinery/door/airlock/service/glass
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	opacity = FALSE
	glass = TRUE

/obj/structure/door_assembly/door_assembly_svc
	name = "service airlock assembly"
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_svc"
	post_init_icon_state = "construction"
	greyscale_config = /obj/machinery/door/airlock/service::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/service::greyscale_colors
	base_name = "service airlock"
	glass_type = /obj/machinery/door/airlock/service/glass
	airlock_type = /obj/machinery/door/airlock/service

/// Syndicate
/obj/machinery/door/airlock/syndicate
	icon = 'icons/map_icons/airlocks.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	icon_state = "/obj/machinery/door/airlock/syndicate"
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#950404#4d4d4d"

/obj/machinery/door/airlock/syndicate/glass
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	opacity = FALSE
	glass = TRUE

/obj/structure/door_assembly/door_assembly_syn
	name = "syndicate airlock assembly"
	icon = 'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_syn"
	post_init_icon_state = "construction"
	greyscale_config = /obj/machinery/door/airlock/syndicate::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/syndicate::greyscale_colors
	base_name = "syndicate airlock"
	glass_type = /obj/machinery/door/airlock/syndicate/glass
	airlock_type = /obj/machinery/door/airlock/syndicate

/// Central Command
/obj/machinery/door/airlock/central_command
	icon = 'icons/map_icons/airlocks.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	icon_state = "/obj/machinery/door/airlock/central_command"
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#449455#39393F"

/obj/machinery/door/airlock/central_command/glass
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	opacity = FALSE
	glass = TRUE

// Variant that's indestructible and unhackable. Oorah.
/obj/machinery/door/airlock/central_command/indestructible_and_unhackable_not_fun_for_players_do_not_map_off_a_centcom_z_level // I'm sensing a pattern with this PR
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	damage_deflection = INFINITY
	integrity_failure = 0
	aiControlDisabled = AI_WIRE_DISABLED
	hackProof = TRUE
	normalspeed = FALSE
	move_resist = INFINITY

/obj/machinery/door/airlock/central_command/indestructible_and_unhackable_not_fun_for_players_do_not_map_off_a_centcom_z_level/screwdriver_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_SKIP_TO_ATTACK // Prevents opening the panel. Admins can varedit panel_open to muck with the wires still; if they really want.

#undef AIRLOCK_LIGHT_POWER_LOW
#undef AIRLOCK_LIGHT_POWER_MID
#undef AIRLOCK_LIGHT_POWER_HIGH
#undef AIRLOCK_LIGHT_RANGE_LOW
#undef AIRLOCK_LIGHT_RANGE_HIGH

#undef AIRLOCK_LIGHT_OPENING_RAPID
#undef AIRLOCK_LIGHT_POWERON
#undef AIRLOCK_LIGHT_ENGINEERING
#undef AIRLOCK_LIGHT_FIRE

#undef AIRLOCK_FRAME_OPENING_RAPID
