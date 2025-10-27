/world/update_status()
	var/features
	var/tagline_name = CONFIG_GET(string/tagline_name)
	var/tagline_desc = CONFIG_GET(string/tagline_desc)
	var/tagline_url = CONFIG_GET(string/tagline_url)
	var/discord = CONFIG_GET(string/discordlink)
	var/new_status = "<a href=\"[tagline_url]\"><b>[tagline_name]</b></a>] \[<a href=\"[discord]\">Discord</a>]<br/>\[[tagline_desc]]<br/>"

	if(SSmapping.current_map)
		features += "\[Map: <b>[SSmapping.current_map.map_name]</b>[SSticker.HasRoundStarted() ? " - [time2text(STATION_TIME_PASSED(), "hh:mm", NO_TIMEZONE)]" : ""]"

	if(features)
		new_status += features

	status = new_status
