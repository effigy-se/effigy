/datum/emote/living/blush
	sound = 'local/sound/emotes/generic/blush.ogg'

/datum/emote/living/emote_whisper
	key = "emotew"
	key_third_person = "emotew"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/mggaow
	key = "mggaow"
	key_third_person = "meowloud"
	message = "meows loudly!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/mggaow.ogg'

/datum/emote/living/peep
	key = "peep"
	key_third_person = "peeps"
	message = "peeps like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/peep_once.ogg'

/datum/emote/living/peep2
	key = "peep2"
	key_third_person = "peeps twice"
	message = "peeps twice like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/peep.ogg'

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "snaps twice."
	message_param = "snaps twice at %t."
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'local/sound/emotes/voice/snap2.ogg'

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "snaps thrice."
	message_param = "snaps thrice at %t."
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'local/sound/emotes/voice/snap3.ogg'

/datum/emote/living/quill
	key = "quill"
	key_third_person = "quills"
	message = "rustles their quills."
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'local/sound/emotes/generic/voxrustle.ogg'

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

	emote_content = span_emote("<b>[user]</b>[space]<i>[user.apply_message_emphasis(emote_content)]</i>")

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

/datum/emote/living/bow
	targets_person = TRUE

/datum/emote/living/glare
	targets_person = TRUE

/datum/emote/living/look
	targets_person = TRUE

/datum/emote/living/nod
	targets_person = TRUE

/datum/emote/living/point
	targets_person = TRUE

/datum/emote/living/stare
	targets_person = TRUE
