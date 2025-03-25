/datum/emote/living/emote_whisper
	key = "emotew"
	key_third_person = "emotew"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/emote_whisper/run_emote(mob/user, params, type_override = null)
	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE
	var/emote_content
	var/whisper_emote = params
	if(SSdbcore.IsConnected() && is_banned_from(user, "emote"))
		to_chat(user, span_warning("You cannot send subtle emotes (banned)."))
		return FALSE
	else if(user.client?.prefs.muted & MUTE_IC)
		to_chat(user, span_warning("You cannot send IC messages (muted)."))
		return FALSE
	else if(!params)
		whisper_emote = tgui_input_text(user, "Write an emote to display.", "Emote (Whisper)", null, MAX_MESSAGE_LEN, TRUE)
		if(!whisper_emote)
			return FALSE
		emote_content = whisper_emote
	else
		emote_content = params
		if(type_override)
			emote_type = type_override

	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE

	user.log_message(emote_content, LOG_EMOTE)

	var/space = should_have_space_before_emote(html_decode(whisper_emote)[1]) ? " " : ""

	emote_content = span_emote("<b>[user]</b>[space]<i>[user.say_emphasis(emote_content)]</i>")

	var/list/viewers = get_hearers_in_view(1, user)

	var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[user]
	if(hologram)
		viewers |= get_hearers_in_view(1, hologram)

	for(var/obj/effect/overlay/holo_pad_hologram/iterating_hologram in viewers)
		if(iterating_hologram?.Impersonation?.client)
			viewers |= iterating_hologram.Impersonation

	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		if((ghost.client?.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(ghost in viewers))
			to_chat(ghost, "[FOLLOW_LINK(ghost, user)] [emote_content]")

	for(var/mob/receiver in viewers)
		receiver.show_message(emote_content, alt_msg = emote_content)

	return TRUE
