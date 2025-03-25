/datum/keybinding/client/communication/looc
	hotkey_keys = list("L")
	name = LOOC_CHANNEL
	full_name = "Local OOC (LOOC)"
	keybind_signal = COMSIG_KB_CLIENT_LOOC_DOWN

/datum/keybinding/client/communication/looc/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(LOOC_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/emote_standard
	hotkey_keys = list("I")
	name = "Emote Standard"
	full_name = "Emote Standard"
	keybind_signal = COMSIG_KB_CLIENT_EMOTE_STANDARD_DOWN

/datum/keybinding/client/communication/emote_standard/down(client/user)
	. = ..()
	if(.)
		return
	return user.mob.emote("me", intentional = TRUE)

/datum/keybinding/client/communication/whisper
	hotkey_keys = list("Y")
	name = WHIS_CHANNEL
	full_name = "Whisper"
	keybind_signal = COMSIG_KB_CLIENT_WHISPER_DOWN

/datum/keybinding/client/communication/whisper/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(WHIS_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/emote_whisper
	hotkey_keys = list("CtrlI")
	name = "Emote Whispe"
	full_name = "Emote Whisper"
	keybind_signal = COMSIG_KB_CLIENT_EMOTE_WHISPER_DOWN

/datum/keybinding/client/communication/emote_whisper/down(client/user)
	. = ..()
	if(.)
		return
	return user.mob.emote("emotew", intentional = TRUE)
