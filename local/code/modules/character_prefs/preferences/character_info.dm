/datum/preferences
	var/headshot = ""
	var/headshot_nsfw = ""
	var/headshot_silicon = ""
	var/headshot_silicon_nsfw = ""

/datum/preference/text/flavor_text
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["flavor_text"] = value

/datum/preference/text/flavor_text/create_default_value()
	return ""

/datum/preference/text/silicon_flavor_text
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_flavor_text"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH
	// This does not get a apply_to_human proc, this is read directly in silicon/robot/examine.dm

/datum/preference/text/silicon_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE // To prevent the not-implemented runtime

/datum/preference/text/ooc_notes
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ooc_notes"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/ooc_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ooc_notes"] = value

//OOC notes for Silicons. Overwrites regular OOC notes when you are playing a Silicon character.
//TODO: Make this your regular OOC notes if you don't have Silicon ones. Every time I've tried, for some reason regular OOC notes haven't shown.
/datum/preference/text/ooc_notes/silicon
	savefile_key = "ooc_notes_silicon"

/datum/preference/text/ooc_notes/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/custom_species
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_species"
	maximum_value_length = 64

/datum/preference/text/custom_species/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["custom_species"] = value

//Custom species and lore for silicons, also known as "Custom Model." This allows silicons to define a custom species rather than receiving, by default "A cyborg unit." BORING.
/datum/preference/text/custom_species/silicon
	savefile_key = "custom_species_silicon"

/datum/preference/text/custom_species/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/custom_species_lore
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_species_lore"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/custom_species_lore/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["custom_species_lore"] = value

/datum/preference/text/custom_species_lore/silicon
	savefile_key = "custom_species_lore_silicon"

/datum/preference/text/custom_species_lore/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/general
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "general_record"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/general/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/medical
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "medical_record"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/medical/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/security
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "security_record"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/security/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/background
	category = PREFERENCE_CATEGORY_PROFILE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "background_info"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/background/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/pda_writing
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pda_writing"
	maximum_value_length = MAX_FLAVOR_TEXT_LENGTH

/datum/preference/text/pda_writing/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

// Hey listen! Imgur doesn't actually work, it's been tested.
/datum/preference/text/headshot
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "headshot"
	maximum_value_length = MAX_MESSAGE_LEN
	/// Assoc list of ckeys and their link, used to cut down on chat spam
	var/list/stored_link = list()
	var/static/link_regex = regex("i.gyazo.com|a.l3n.co|b.l3n.co|c.l3n.co|static.f-list.net/images/|images2.imgbox.com|thumbs2.imgbox.com|files.catbox.moe") //effigy, gyazo, catbox, imgbox, lensdump, f-list
	var/static/list/valid_extensions = list("jpg", "png", "jpeg") // Regex works fine, if you know how it works

/datum/preference/text/headshot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target?.dna.features["headshot"] = value

/datum/preference/text/headshot/is_valid(value)
	if(!length(value)) // Just to get blank ones out of the way
		usr?.client?.prefs?.headshot = null
		return TRUE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		to_chat(usr, alert_boxed_message(RED, "Your headshot link must be https!"))
		return

	if(!findtext(value, "."))
		to_chat(usr, alert_boxed_message(RED, "Invalid headshot link!"))
		return
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(extension in valid_extensions))
		to_chat(usr, alert_boxed_message(RED, "Headshot image must be one of the following extensions: '[english_list(valid_extensions)]'"))
		return

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		to_chat(usr, alert_boxed_message(RED, "Headshot image must be hosted on one of the following sites: Effigy, Catbox, Imgbox, F-List, Lensdump, Gyazo"))
		return

	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Think of it as a headshot for your ID. Lastly, [span_bold("do not use a real life photo or use any image that is less than serious.")]"))
		to_chat(usr, span_notice("If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser."))
		to_chat(usr, span_notice("Keep in mind that the photo will be downsized to 250x250 pixels, so the more square the photo, the better it will look."))
		log_game("[usr] has set their Headshot image to '[value]'.")
	stored_link[usr?.ckey] = value
	usr?.client?.prefs.headshot = value
	return TRUE

/datum/preference/text/headshot/proc/apply_headshot(value)
	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Think of it as a headshot for your ID. Lastly, [span_bold("do not use a real life photo or use any image that is less than serious.")]"))
		to_chat(usr, span_notice("If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser."))
		to_chat(usr, span_notice("Keep in mind that the photo will be downsized to 250x250 pixels, so the more square the photo, the better it will look."))
		log_game("[usr] has set their Headshot image to '[value]'.")
	stored_link[usr.ckey] = value
	return TRUE

/datum/preference/text/headshot/is_accessible(datum/preferences/preferences)
	if(isnull(usr)) // Joining at roundstart
		return ..()
	return ..()

//This is literally just the same as the original headshot pref but for silicons :)
/datum/preference/text/headshot/silicon
	savefile_key = "headshot_silicon"

/datum/preference/text/headshot/silicon/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/headshot/silicon/apply_headshot(value)
	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Think of it as a headshot for your ID. Lastly, [span_bold("do not use a real life photo or use any image that is less than serious.")]"))
		log_game("[usr] has set their Silicon Headshot image to '[value]'.")
	stored_link[usr?.ckey] = value
	usr?.client?.prefs.headshot_silicon = value
