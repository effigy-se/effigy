/**
* Shows a location blurb to our client, a little popup of text showing the current area's name.
* Arguments:
* * duration - How long we're going to show this blurb. Does not include fadein and fadeout.
* * extended_info - Whether or not we append the player's name; station name, and current time.
* * uppercase - Do we force the text to uppercase?
* * typewriter_esque - Whether we individually punch in each character rather than show each line at once.
* * custom_facility_name - Replaces the station name in extended_info.
* * custom_year - Replaces the year in extended_info.
**/
/client/proc/show_location_blurb(duration = 3 SECONDS, extended_info = FALSE, uppercase = FALSE, typewriter_esque = FALSE, custom_facility_name, custom_year)
	set waitfor = FALSE // Client shouldn't wait on this

	if(HAS_TRAIT(src, LOCATIONBLURB_ONSCREEN))
		return // We already have a blurb on-screen, let's just not stack them.

	ADD_TRAIT(src, LOCATIONBLURB_ONSCREEN, INNATE_TRAIT)
	var/our_blurb_text = get_area(mob)
	if(!our_blurb_text)
		return // No mob or area somehow; can this whole shebang
	if(extended_info)
		var/station_name = (custom_facility_name ? "[custom_facility_name]" : GLOB.station_name)
		our_blurb_text = "[time2text(world.realtime, "Day, MMM DD")] - [custom_year ? "[custom_year]" : CURRENT_STATION_YEAR], [station_time_timestamp("hh:mm")]\n[station_name], [our_blurb_text]"
	if(uppercase)
		our_blurb_text = uppertext(our_blurb_text)

	var/atom/movable/screen/text_movable = new /atom/movable/screen{
		maptext_height = 64;
		maptext_width = 512;
		layer = FLOAT_LAYER;
		plane = HUD_PLANE;
		appearance_flags = APPEARANCE_UI_IGNORE_ALPHA;
		screen_loc = "LEFT+0.1,BOTTOM+4.5";
		alpha = 0;
	}
	screen += text_movable
	animate(text_movable, alpha = 255, time = 1 SECONDS)
	if(typewriter_esque)
		for(var/i = 1 to length_char(our_blurb_text) + 1) // Animate each character rolling in like this is a typewriter
			text_movable.maptext = MAPTEXT_GRAND9K(copytext_char(our_blurb_text, 1, i))
			sleep(1)
	else
		text_movable.maptext = MAPTEXT_GRAND9K(our_blurb_text)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(fade_location_blurb), src, text_movable), duration)

/// Global proc so it can be forcefully called by anything that wants to dispel any open blurbs
/proc/fade_location_blurb(client/target_client, atom/movable/location_blurb)
	animate(location_blurb, alpha = 0, time = 0.5 SECONDS)
	sleep(0.5 SECONDS)
	if(target_client)
		target_client.screen -= location_blurb
		REMOVE_TRAIT(target_client, LOCATIONBLURB_ONSCREEN, INNATE_TRAIT)
	qdel(location_blurb)
