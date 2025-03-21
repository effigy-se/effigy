/mob/living/silicon
	/// The Examine Panel datum for the mob.
	var/datum/examine_panel/mob_examine_panel
	/// The scream emote selected in prefs
	var/selected_scream

/mob/living/silicon/Initialize(mapload)
	. = ..()
	mob_examine_panel = new(src)

/mob/living/silicon/Destroy()
	QDEL_NULL(mob_examine_panel)
	return ..()

/**
 *  Returns a list of lines containing silicon flavour text and a link to "look closer" and open the examine panel.
 *  Intended to be appended at the end of examine() result.
 */
/mob/living/silicon/proc/get_silicon_flavour_text()
	. = list()
	var/flavour_text_link
	/// The first 1-FLAVOR_PREVIEW_LIMIT characters in the mob's client's silicon_flavour_text preference datum. FLAVOR_PREVIEW_LIMIT is defined in flavor_defines.dm.
	var/silicon_preview_text = copytext_char((client?.prefs.read_preference(/datum/preference/text/silicon_flavour_text)), 1, FLAVOUR_TEXT_PREVIEW_LIMIT)

	flavour_text_link = span_notice("[silicon_preview_text]... <a href='?src=[REF(src)];lookup_info=open_examine_panel'>Look closer?</a>")

	if (flavour_text_link)
		. += flavour_text_link
