/obj/item/bodypart/proc/change_type(mob/living/user, obj/item/tool)
	if(brute_dam || burn_dam)
		user.balloon_alert(user, "limb damaged!")
		return NONE

	var/list/possible_appearances = list()
	for(var/types in GLOB.frame_types)
		if(types == "none")
			continue
		LAZYADDASSOC(possible_appearances, types, image(icon = BODYPART_ICON_SYNTH_BASE, icon_state = "[types]_[body_zone]"))
	//pick
	var/new_type = show_radial_menu(user, src, possible_appearances, require_near = TRUE, tooltips = TRUE, radius = 48)
	if(!new_type)
		return NONE
	//weld
	if(tool.use_tool(src, user, delay = 2 SECONDS, volume = 20))
		var/type_to_spawn = text2path("[type]/[new_type]")
		if(!type_to_spawn)
			type_to_spawn = text2path("[parent_type]/[new_type]")
		var/obj/item/bodypart/new_bodypart = new type_to_spawn(loc)
	//inherit detail
		for(var/obj/item/organ/to_transfer in contents)
			to_transfer.bodypart_insert(new_bodypart)
		new_bodypart.name = name
		new_bodypart.desc = desc
		qdel(src)
		return ITEM_INTERACT_SUCCESS
