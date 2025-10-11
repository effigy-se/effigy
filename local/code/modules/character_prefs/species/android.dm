/datum/species/android

/datum/species/android/prepare_human_for_preview(mob/living/carbon/human/robot_for_preview)
	robot_for_preview.dna.ear_type = CYBERNETIC_TYPE
	robot_for_preview.dna.features["ears"] = "No Ears"
	robot_for_preview.dna.features["ears_color_1"] = "#333333"
	robot_for_preview.dna.tail_type = CYBERNETIC_TYPE
	robot_for_preview.dna.features["tail_other"] = /datum/sprite_accessory/tails/lizard/none::name
	robot_for_preview.dna.features["frame_list"] = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/effigy/sgm,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/effigy/sgm,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/effigy/sgm,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/effigy/sgm,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/effigy/sgm,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/effigy/sgm)
	regenerate_organs(robot_for_preview)
	robot_for_preview.update_body(is_creating = TRUE)

/*
#define SYNTH_HUD_TEXT(valuecolor, value) MAPTEXT("<div align='center' valign='middle'><font color='[valuecolor]'>[round((value/14000), 1)]%</font></div>")

/atom/movable/screen/synth
	icon = 'local/icons/hud/synth_hud.dmi'

/atom/movable/screen/synth/energy
	name = "internal charge"
	icon_state = "energy_display"
	screen_loc = "EAST-1:28,CENTER+1:21"

/atom/movable/screen/synth/energy/proc/update_energy_hud(internal_charge)
	maptext = SYNTH_HUD_TEXT(hud_text_color(internal_charge), internal_charge)
	if(internal_charge <= 300 KILO JOULES)
		icon_state = "energy_display_low"
	else
		icon_state = "energy_display"

/atom/movable/screen/synth/energy/proc/hud_text_color(internal_charge)
	return internal_charge > 300 KILO JOULES ? "#e7e9ee" : "#f0197d"

#undef SYNTH_HUD_TEXT
*/
