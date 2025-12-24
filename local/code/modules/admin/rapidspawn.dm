/mob/dead/observer/CtrlClickOn(mob/target)
	rapidspawn(target, src)

/mob/dead/observer/proc/rapidspawn(mob/target, mob/user)
	if(!isobserver(target) || !check_rights(R_SPAWN))
		return

	/// Whether to spawn in with sparks or in a pod
	var/teleport_option
	/// Teleportation options
	var/list/teleport_options = list("Bluespace", "Pod", "Cancel")
	/// What style of pod to use, if the option was chosen
	var/pod_style
	/// Assoc list of pod UI names to style datums, static so it's only built once
	var/static/list/pod_styles
	/// Whether to spawn in as your current character or a random one
	var/character_option
	/// Character options
	var/list/character_options = list("Selected Character", "Random Character", "Cancel")
	/// Which outfit to use
	var/outfit_option
	/// Initial list of outfits
	var/list/outfit_options = list(
		"Admin Outfit" = /datum/outfit/admin,
		"Naked" = /datum/outfit,
		"Show All" = "Show All",
	)
	/// Whether to grant the return spell
	var/give_return
	/// Whether to spawn with quirks and/or loadout
	var/give_quirks_loadout
	/// Quirk/loadout options
	var/list/quirk_loadout_options = list("Include Quirks", "Include Loadout", "Include Both", "None")

	teleport_option = tgui_alert(user, "How would you like to be spawned in?", "RapidSpawn: Now 20% Faster!", teleport_options)
	if(!teleport_option || teleport_option == teleport_options[3])
		return

	if(teleport_option == teleport_options[2])
		if(!pod_styles)
			pod_styles = list()
			for(var/datum/pod_style/style as anything in typesof(/datum/pod_style))
				pod_styles[style::ui_name] = style

		pod_style = tgui_input_list(user, "Which style of pod?", "RapidSpawn: Now 20% Faster!", pod_styles)
		pod_style = pod_styles[pod_style]
		if(!pod_style)
			return

	character_option = tgui_alert(user, "Which character to spawn as?", "RapidSpawn: Now 20% Faster!", character_options)
	if(!character_option || character_option == character_options[3])
		return

	outfit_option = tgui_input_list(user, "Which outfit to use?", "RapidSpawn: Now 20% Faster!", outfit_options)
	if(outfit_option == outfit_options[3])
		outfit_option = user.client.robust_dress_shop()
	else
		outfit_option = outfit_options[outfit_option]
	if(!outfit_option)
		return

	// The give return option is only relevant if the user is spawning in someone else
	if(target != user)
		give_return = tgui_alert(user, "Do you want to give them the power to return? Not recommended for non-admins.", "RapidSpawn: Now 20% Faster!", list("No", "Yes"))
		if(!give_return)
			return

	if(character_option == character_options[1])
		give_quirks_loadout = tgui_input_list(user, "Include quirks/loadout?", "RapidSpawn: Now 20% Faster!", quirk_loadout_options)
		if(!give_quirks_loadout)
			return

	var/turf/current_turf = get_turf(target)
	var/mob/living/carbon/human/new_player = new(current_turf)
	if(character_option == character_options[1])
		new_player.name = target.name
		new_player.real_name = target.real_name
		target.client?.prefs.safe_transfer_prefs_to(new_player)
		new_player.dna.update_dna_identity()

	if(give_quirks_loadout == quirk_loadout_options[1])
		SSquirks.AssignQuirks(new_player, target.client)
		new_player.equipOutfit(outfit_option)
	else if(give_quirks_loadout == quirk_loadout_options[2])
		new_player.equip_outfit_and_loadout(outfit_option, target.client?.prefs)
	else if(give_quirks_loadout == quirk_loadout_options[3])
		SSquirks.AssignQuirks(new_player, target.client)
		new_player.equip_outfit_and_loadout(outfit_option, target.client?.prefs)
	else if(give_quirks_loadout == quirk_loadout_options[4] || !give_quirks_loadout) // null case matches if they chose random character
		new_player.equipOutfit(outfit_option)

	if(target.mind)
		target.mind.transfer_to(new_player, TRUE)
	else
		new_player.key = target.key
	qdel(target)

	if(give_return != "No")
		var/datum/action/cooldown/spell/return_back/return_spell = new
		return_spell.Grant(new_player)

	if(teleport_option == teleport_options[1])
		new_player.forceMove(current_turf)
		playsound(new_player, 'sound/effects/magic/Disable_Tech.ogg', 100, FALSE)
		var/datum/effect_system/spark_spread/quantum/sparks = new
		sparks.set_up(10, 1, new_player)
		sparks.attach(get_turf(new_player))
		sparks.start()
	else if(teleport_option == teleport_options[2])
		var/obj/structure/closet/supplypod/podspawn/empty_pod = new(null, pod_style)
		new_player.forceMove(empty_pod)
		new /obj/effect/pod_landingzone(current_turf, empty_pod)

/datum/action/cooldown/spell/return_back
	name = "Return"
	desc = "Activates your return beacon."
	sound = 'sound/effects/magic/Repulse.ogg'
	button_icon_state = "lightning"
	spell_requirements = NONE
	invocation = "Return on!"
	invocation_type = INVOCATION_WHISPER
	school = SCHOOL_EVOCATION

/datum/action/cooldown/spell/return_back/can_cast_spell(feedback)
	return TRUE

/datum/action/cooldown/spell/return_back/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/user = cast_on
	if(!istype(cast_on))
		return

	var/mob/dead/observer/ghost = user.ghostize(FALSE)

	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, user)
	sparks.attach(user.loc)
	sparks.start()

	qdel(user)

	// Get them back to their regular name.
	ghost.set_ghost_appearance()
	if(ghost.client && ghost.client.prefs)
		ghost.deadchat_name = ghost.client.prefs?.read_preference(/datum/preference/name/real_name)

/obj/item/gun/energy/taser/debug
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/debug)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_casing/energy/electrode/debug
	e_cost = 1
