/datum/emote/living/carbon/human/synth
	mob_type_allowed_typecache = /mob/living/carbon/human/species/synth

// Beep already exists on brains and silicons
/datum/emote/living/carbon/human/synth/beep
	key = "beep"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/beep/twobeep.ogg'

/datum/emote/living/carbon/human/synth/beep2
	key = "beep2"
	key_third_person = "beeps sharply"
	message = "beeps sharply."
	message_param = "beeps sharply at %t."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/machines/beep/twobeep.ogg'

/datum/emote/living/carbon/human/synth/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "chirps happily!"
	vary = TRUE
	sound = 'local/sound/emotes/generic/dwoop.ogg'
	cooldown = 2 SECONDS

/datum/emote/living/carbon/human/synth/error
	key = "error"
	message = "experiences a system error."
	vary = FALSE
	sound = 'local/sound/emotes/voice/synth_error.ogg'
	cooldown = 2 SECONDS

/datum/emote/living/carbon/human/synth/laughtrack
	key = "laughtrack"
	message = "plays a laughtrack."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/items/sitcom_laugh/SitcomLaugh2.ogg'

/datum/emote/living/carbon/human/synth/rshutdown
	key = "shutdown"
	message = "emits a nostalgic tone as they fall silent."
	vary = FALSE
	sound = 'local/sound/emotes/voice/synth_shutdown.ogg'
	cooldown = 2 SECONDS


/datum/emote/living/carbon/human/synth/rstartup
	key = "startup"
	message = "chimes to life."
	vary = FALSE
	sound = 'local/sound/emotes/voice/synth_startup.ogg'
	cooldown = 2 SECONDS

/datum/emote/living/carbon/human/synth/scary
	key = "scary"
	message = "emits a disconcerting tone."
	vary = FALSE
	sound = 'local/sound/emotes/voice/synth_scary.ogg'
	cooldown = 2 SECONDS
