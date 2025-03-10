/obj/item/ttsdevice
	name = "TTS device"
	desc = "A small device with a keyboard attached. Anything entered on the keyboard is played out the speaker. \n<span class='notice'>Ctrl-click the device to make it beep.</span> \n<span class='notice'>Ctrl-shift-click to name the device."
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "generic_delivery"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = UNIQUE_RENAME

/obj/item/ttsdevice/attack_self(mob/user)
	user.balloon_alert_to_viewers("typing...", "started typing...")
	playsound(src, 'local/sound/items/tts/started_type.ogg', 50, TRUE)
	var/str = tgui_input_text(user, "What would you like the device to say?", "Say Text", "", MAX_MESSAGE_LEN, encode = FALSE)
	if(QDELETED(src) || !user.can_perform_action(src))
		return
	if(!str)
		user.balloon_alert_to_viewers("stops typing", "stopped typing")
		playsound(src, 'local/sound/items/tts/stopped_type.ogg', 50, TRUE)
		return
	src.say(str)
	str = null

/obj/item/ttsdevice/item_ctrl_click(mob/user)
	var/noisechoice = tgui_input_list(user, "What noise would you like to make?", "Robot Noises", list("Beep","Buzz","Ping"))
	if(noisechoice == "Beep")
		user.audible_message("makes their TTS beep!", audible_message_flags = EMOTE_MESSAGE)
		playsound(user, 'sound/machines/beep/twobeep.ogg', 50, 1, -1)
	if(noisechoice == "Buzz")
		user.audible_message("makes their TTS buzz!", audible_message_flags = EMOTE_MESSAGE)
		playsound(user, 'sound/machines/buzz/buzz-sigh.ogg', 50, 1, -1)
	if(noisechoice == "Ping")
		user.audible_message("makes their TTS ping!", audible_message_flags = EMOTE_MESSAGE)
		playsound(user, 'sound/machines/ping.ogg', 50, 1, -1)
	if(!noisechoice)
		return CLICK_ACTION_BLOCKING
	return CLICK_ACTION_SUCCESS

/obj/item/ttsdevice/click_ctrl_shift(mob/user)
	var/new_name = reject_bad_name(tgui_input_text(user, "Name your Text-to-Speech device. This matters for displaying it in the chat bar.", "Set TTS Device Name", "", MAX_NAME_LEN))
	if(new_name)
		name = "[new_name]'s [initial(name)]"
	else
		name = initial(name)
