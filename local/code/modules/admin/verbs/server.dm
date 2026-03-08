/datum/admins/proc/announce_round_discord()
	set category = "Server"
	set desc = "Manually send a new round Discord announcement."
	set name = "Announce Round to Discord"
	SSticker.announce_new_round_to_discord(admin_forced = TRUE)
	log_admin("[key_name(usr)] manually triggered a Discord round announcement.")
	message_admins("[key_name_admin(usr)] manually triggered a Discord round announcement.")

/datum/admins/proc/toggledchat()
	set category = "Server"
	set desc = "Toggle dis bitch"
	set name = "Toggle Dead Chat"
	toggle_dchat()
	log_admin("[key_name(usr)] toggled dead chat.")
	message_admins("[key_name_admin(usr)] toggled dead chat.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle DCHAT", "[GLOB.dchat_allowed ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/toggle_dchat(toggle = null)
	if(toggle != null) // if we're specifically en/disabling dead chat
		if(toggle != GLOB.dchat_allowed)
			GLOB.dchat_allowed = toggle
		else
			return
	else // otherwise just toggle it
		GLOB.dchat_allowed = !GLOB.dchat_allowed
	to_chat(world, alert_boxed_message(YELLOW, "The dead chat channel has been globally [GLOB.dchat_allowed ? "enabled" : "disabled"]."))
