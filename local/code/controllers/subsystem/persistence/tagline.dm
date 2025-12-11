#define TAGLINE_FILEPATH "data/world_tagline.txt"

/// Loads tagline into GLOB.world_tagline for Hub entry
/datum/controller/subsystem/persistence/proc/load_tagline()
	if(!fexists(TAGLINE_FILEPATH))
		return
	GLOB.world_tagline = file2text(TAGLINE_FILEPATH)
	log_game("Server tagline is: [GLOB.world_tagline]")
	world.update_status()

/// Saves tagline
/datum/controller/subsystem/persistence/proc/save_tagline()
	rustg_file_write("[GLOB.world_tagline]", TAGLINE_FILEPATH)

#undef TAGLINE_FILEPATH

ADMIN_VERB(update_tagline, R_SERVER, "Update Server Tagline", "Update the server tagline displayed on Hub entry.", ADMIN_CATEGORY_SERVER)
	var/new_tagline = tgui_input_text(user, "How do you want to present yourself to the world?", "Update Tagline", max_length = 112)
	if(isnull(new_tagline))
		if(tgui_alert(user, "Are you cancelling your action, or do you want to clear the tagline?", "Update Tagline", list("Cancel", "Clear Tagline")) != "Clear Tagline")
			return

	GLOB.world_tagline = new_tagline
	log_admin_private("Admin [key_name_admin(user)] has updated the server tagline to: [new_tagline]")
	log_game("Server tagline is: [GLOB.world_tagline]")
	message_admins("Admin [key_name_admin(user)] has updated the server tagline to: [new_tagline]")
	BLACKBOX_LOG_ADMIN_VERB("Update Server Tagline")
