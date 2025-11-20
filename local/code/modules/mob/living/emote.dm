/datum/emote/living/awoo
	key = "awoo"
	key_third_person = "awoos"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/awoo.ogg'

/datum/emote/living/awoo_long
	key = "awoo2"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/long_awoo.ogg'

/datum/emote/living/baa
	key = "baa"
	key_third_person = "baas"
	message = "lets out a baa."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/baa.ogg'

/datum/emote/living/baa2
	key = "baa2"
	key_third_person = "baas"
	message = "bleats."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/baa2.ogg'

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/bark2.ogg'

/datum/emote/living/bark2
	key = "bark2"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/bark1.ogg'

/datum/emote/living/bawk
	key = "bawk"
	key_third_person = "bawks"
	message = "bawks like a chicken."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/bawk.ogg'

/datum/emote/beep
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/generic/twobeep.ogg'
	mob_type_allowed_typecache = list(/mob/living) // Beep already exists on brains and silicons

/datum/emote/living/blep
	key = "blep"
	key_third_person = "bleps"
	message = "bleps their tongue out. Blep."
	message_AI = "shows an image of a random blepping animal. Blep."
	message_robot = "bleps their robo-tongue out. Blep."

/datum/emote/living/blink2
	key = "blink2"
	key_third_person = "blinks twice"
	message = "blinks twice."
	message_AI = "has their display flicker twice."

/datum/emote/living/blink_rapid
	key = "rblink"
	key_third_person = "rapidly blinks"
	message = "rapidly blinks!"
	message_AI = "has their display flash rapidly!"

/datum/emote/living/blush
	sound = 'local/sound/emotes/generic/blush.ogg'

/datum/emote/living/bork
	key = "bork"
	key_third_person = "borks"
	message = "lets out a bork."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/bork.ogg'

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/hyena/cackle.ogg'

/datum/emote/living/cackle_giggle
	key = "cackle2"
	message = "cackles hysterically!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/hyena/cackle_giggle.ogg'

/datum/emote/living/cat_chirp
	key = "catchirp"
	message = "chirps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/catchirp.ogg'

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "caws twice!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/caw2.ogg'

/datum/emote/living/chitter
	key = "chitter"
	key_third_person = "chitters"
	message = "chitters!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/generic/mothchitter.ogg'

/datum/emote/living/clap1
	key = "clap1"
	key_third_person = "claps once"
	message = "claps once."
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/clap1/can_run_emote(mob/living/user, status_check = TRUE , intentional, params)
	if(!iscarbon(user) || user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/clap1/get_sound(mob/living/user)
	return pick(
		'local/sound/emotes/generic/claponce1.ogg',
		'local/sound/emotes/generic/claponce2.ogg',
	)

/datum/emote/living/clear
	key = "clear"
	key_third_person = "clears their throat"
	message = "clears their throat."

/datum/emote/living/ear_twitch
	key = "etwitch"
	key_third_person = "twitches their ears"
	message = "twitches their ears!"

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

/datum/emote/living/eyeroll
	key = "eyeroll"
	key_third_person = "rolls their eyes"
	message = "rolls their eyes."

/datum/emote/living/gasp/get_sound(mob/living/user)
	if(HAS_MIND_TRAIT(user, TRAIT_MIMING))
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/human_user = user
	if(human_user.physique == FEMALE)
		return pick(
			'local/sound/emotes/generic/female/gasp_f1.ogg',
			'local/sound/emotes/generic/female/gasp_f2.ogg',
			'local/sound/emotes/generic/female/gasp_f3.ogg',
			'local/sound/emotes/generic/female/gasp_f4.ogg',
			'local/sound/emotes/generic/female/gasp_f5.ogg',
			'local/sound/emotes/generic/female/gasp_f6.ogg',
		)
	return pick(
		'local/sound/emotes/generic/male/gasp_m1.ogg',
		'local/sound/emotes/generic/male/gasp_m2.ogg',
		'local/sound/emotes/generic/male/gasp_m3.ogg',
		'local/sound/emotes/generic/male/gasp_m4.ogg',
		'local/sound/emotes/generic/male/gasp_m5.ogg',
		'local/sound/emotes/generic/male/gasp_m6.ogg',
	)

/datum/emote/living/gnash
	key = "gnash"
	key_third_person = "gnashes"
	message = "gnashes."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/items/weapons/bite.ogg'

/datum/emote/living/growl
	key = "growl"
	key_third_person = "growls"
	message = "lets out a growl."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/growl.ogg'

/datum/emote/living/headtilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
	message_AI = "tilts the image on their display."

/datum/emote/living/hiss
	key = "hiss1"
	key_third_person = "hisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'local/sound/emotes/generic/hiss.ogg'

/datum/emote/living/hiss_feline
	key = "fhiss"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/feline_hiss.ogg'

/datum/emote/living/honk
	key = "honk1"
	key_third_person = "honks loudly like a goose!"
	message = "honks loudly like a goose!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/goose_honk.ogg'

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "hoots!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/hoot.ogg'

/datum/emote/living/huff
	key = "huffs"
	key_third_person = "huffs"
	message = "huffs!"

/datum/emote/living/hyena_laugh
	key = "hlaugh"
	key_third_person = "hlaughs"
	message = "laughs!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/hyena_laugh/get_sound(mob/living/user)
	return pick(
		'local/sound/emotes/voice/hyena/laugh_bright.ogg',
		'local/sound/emotes/voice/hyena/laugh_low.ogg',
		'local/sound/emotes/voice/hyena/laugh_short.ogg',
		'local/sound/emotes/voice/hyena/laugh_twice.ogg',
		'local/sound/emotes/voice/hyena/laugh1.ogg',
		'local/sound/emotes/voice/hyena/laugh2.ogg',
	)

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "meows!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/generic/meow.ogg'

/datum/emote/living/merp
	key = "merp"
	key_third_person = "merps"
	message = "merps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/merp.ogg'

/datum/emote/living/mggaow
	key = "mggaow"
	key_third_person = "meowloud"
	message = "meows loudly!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/mggaow.ogg'

/datum/emote/living/moo
	key = "moo"
	key_third_person = "moos!"
	message = "moos!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/moo.ogg'

/datum/emote/living/mothsqueak
	key = "msqueak"
	key_third_person = "lets out a tiny squeak"
	message = "lets out a tiny squeak!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/mothsqueak.ogg'

/datum/emote/living/nya
	key = "nya"
	key_third_person = "nyas"
	message = "lets out a nya!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/nya.ogg'

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

/datum/emote/living/purr
	key = "purr"
	key_third_person = "purrs!"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/feline_purr.ogg'

/datum/emote/living/quill
	key = "quill"
	key_third_person = "quills"
	message = "rustles their quills."
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'local/sound/emotes/generic/voxrustle.ogg'

/datum/emote/living/rattle
	key = "rattle"
	key_third_person = "rattles"
	message = "rattles!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/rattle.ogg'

/datum/emote/living/rawr
	key = "rawr"
	key_third_person = "rawrs"
	message = "lets out a rawr!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/rawr.ogg'

/datum/emote/living/rpurr
	key = "rpurr"
	key_third_person = "purrs!"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/raptor_purr.ogg'

/datum/emote/living/smirk
	key = "smirk"
	key_third_person = "smirks"
	message = "smirks."

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

/datum/emote/living/squeak_mouse
	key = "squeak"
	key_third_person = "squeaks"
	message = "squeaks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg'

/datum/emote/living/squint
	key = "squint"
	key_third_person = "squints"
	message = "squints."
	message_AI = "zooms in."

/datum/emote/living/squish
	key = "squish"
	key_third_person = "squishes"
	message = "squishes!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/slime_squish.ogg'

/datum/emote/living/thump
	key = "thump"
	key_third_person = "thumps"
	message = "thumps their foot!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/effects/glass/glassbash.ogg'

/datum/emote/living/trills
	key = "trills"
	key_third_person = "trills!"
	message = "trills!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/trills.ogg'

/datum/emote/living/warble
	key = "warble"
	key_third_person = "warbles"
	message = "warbles!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/warbles.ogg'

/datum/emote/living/weh
	key = "weh"
	key_third_person = "wehs"
	message = "lets out a weh!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/weh.ogg'

/datum/emote/living/whine1
	key = "whine1"
	key_third_person = "whines"
	message = "lets out a whine!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/whine1.ogg'

/datum/emote/living/whine2
	key = "whine2"
	message = "lets out a whine!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/whine2.ogg'

/datum/emote/living/whoop
	key = "whoop"
	key_third_person = "whoops"
	message = "lets out a whoop!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/hyena/whoop.ogg'

/datum/emote/living/whoop2
	key = "whoop2"
	message = "lets out a whoop!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/hyena/whoop_long.ogg'

/datum/emote/living/woof
	key = "woof"
	key_third_person = "woofs"
	message = "lets out a woof!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/woof.ogg'

/datum/emote/living/woof2
	key = "woof2"
	message = "lets out a woof!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/woof2.ogg'

/datum/emote/living/wurble
	key = "wurble"
	key_third_person = "wurbles"
	message = "lets out a wurble."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/wurble.ogg'

/datum/emote/living/yelp1
	key = "yelp"
	message = "lets out a yelp!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/yelp1.ogg'

/datum/emote/living/yelp2
	key = "yelp2"
	message = "lets out a yelp!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'local/sound/emotes/voice/yelp2.ogg'

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
