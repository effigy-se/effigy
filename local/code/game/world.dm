/world/update_status()
	var/features
	var/discord = CONFIG_GET(string/discordlink)
	var/new_status = "<a href=\"[CONFIG_GET(string/tagline_url)]\"><b>[CONFIG_GET(string/tagline_name)]</b></a>] [discord ? "\[<a href=\"[discord]\">Discord</a>\]" : ""]<br/>\[[CONFIG_GET(string/tagline_desc)]]<br/>"

	if(SSmapping.current_map)
		features += "\[Map: <b>[SSmapping.current_map.map_name]</b>]"

	if(features)
		new_status += features

	status = new_status
