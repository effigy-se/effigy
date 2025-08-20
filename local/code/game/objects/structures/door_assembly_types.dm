/**
 * TG Door Assemblies
 */

/obj/structure/door_assembly
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly"
	post_init_icon_state = "construction"
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /obj/machinery/door/airlock::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock::greyscale_colors

/obj/structure/door_assembly/door_assembly_public
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_public"
	greyscale_config = /obj/machinery/door/airlock/public::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/public::greyscale_colors

/obj/structure/door_assembly/door_assembly_com
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_com"
	greyscale_config = /obj/machinery/door/airlock/command::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/command::greyscale_colors

/obj/structure/door_assembly/door_assembly_sec
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_sec"
	greyscale_config = /obj/machinery/door/airlock/security::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/security::greyscale_colors

/obj/structure/door_assembly/door_assembly_eng
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_eng"
	greyscale_config = /obj/machinery/door/airlock/engineering::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/engineering::greyscale_colors

/obj/structure/door_assembly/door_assembly_min
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_min"
	greyscale_config = /obj/machinery/door/airlock/mining::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/mining::greyscale_colors

/obj/structure/door_assembly/door_assembly_atmo
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_atmo"
	greyscale_config = /obj/machinery/door/airlock/atmos::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/atmos::greyscale_colors

/obj/structure/door_assembly/door_assembly_research
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_research"
	greyscale_config = /obj/machinery/door/airlock/research::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/research::greyscale_colors

/obj/structure/door_assembly/door_assembly_science
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_science"
	greyscale_config = /obj/machinery/door/airlock/science::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/science::greyscale_colors

/obj/structure/door_assembly/door_assembly_med
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_med"
	greyscale_config = /obj/machinery/door/airlock/medical::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/medical::greyscale_colors

/obj/structure/door_assembly/door_assembly_hydro
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_hydro"
	greyscale_config = /obj/machinery/door/airlock/hydroponics::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/hydroponics::greyscale_colors

/obj/structure/door_assembly/door_assembly_viro
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_viro"
	greyscale_config = /obj/machinery/door/airlock/virology::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/virology::greyscale_colors

/obj/structure/door_assembly/door_assembly_silver
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_silver"
	greyscale_config = /obj/machinery/door/airlock/silver::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/silver::greyscale_colors

/obj/structure/door_assembly/door_assembly_mai
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_mai"
	greyscale_config = /obj/machinery/door/airlock/maintenance::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/maintenance::greyscale_colors

/obj/structure/door_assembly/door_assembly_extmai
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_extmai"
	greyscale_config = /obj/machinery/door/airlock/maintenance/external::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/maintenance/external::greyscale_colors

/obj/structure/door_assembly/door_assembly_material
	icon =  'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_material"
	greyscale_config = /obj/machinery/door/airlock/material::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/material::greyscale_colors

/obj/structure/door_assembly/door_assembly_abductor
	icon = 'icons/obj/doors/airlocks/abductor/abductor_airlock.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/abductor/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_bronze
	icon = 'icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_cult
	icon = 'icons/obj/doors/airlocks/cult/runed/cult.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/cult/runed/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_hatch
	icon = 'icons/obj/doors/airlocks/hatch/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/hatch/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_mhatch
	icon = 'icons/obj/doors/airlocks/hatch/maintenance.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/hatch/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_fre
	icon = 'icons/obj/doors/airlocks/station/freezer.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_ext
	icon = 'local/icons/obj/doors/airlocks/external/external.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/external/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_highsecurity
	icon = 'icons/obj/doors/airlocks/highsec/highsec.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/highsec/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_vault
	icon = 'icons/obj/doors/airlocks/vault/vault.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/vault/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_shuttle
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/shuttle/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_titanium
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/shuttle/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/door_assembly_grunge
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/centcom/overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/multi_tile
	icon = 'icons/obj/doors/airlocks/multi_tile/public/glass.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/multi_tile/public/overlays.dmi'
	icon_state = null
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/obj/structure/door_assembly/multi_tile/door_assembly_tram
	icon = 'icons/obj/doors/airlocks/tram/tram.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/tram/tram-overlays.dmi'
	icon_state = "construction"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_colors = null

/**
 * Effigy Door Assemblies
 */

/obj/structure/door_assembly/door_assembly_cce
	name = "central command airlock assembly"
	icon = 'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/door_assembly/door_assembly_cce"
	post_init_icon_state = "construction"
	greyscale_config = /obj/machinery/door/airlock/central_command::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/central_command::greyscale_colors
	base_name = "central command airlock"
	glass_type = /obj/machinery/door/airlock/central_command/glass
	airlock_type = /obj/machinery/door/airlock/central_command
