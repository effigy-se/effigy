#define PREF "PREF"
#define ICON "ICON"
#define TGUI "TGUI"

/proc/debug_effigy(message, type)
	var/msg_type = type
	if(isnull(type))
		msg_type = "GAME"
	var/msg = span_cyan("\[[span_white("DEBUG")]]\[[span_yellow(msg_type)]\] [message]")
	to_chat(world, msg)
	logger.Log(LOG_CATEGORY_DEBUG, message)

/proc/log_events(text, list/data, notify_admins = FALSE, notify_span = "adminnotice")
	logger.Log(LOG_CATEGORY_EVENTS, text, data)
	if(notify_admins)
		message_admins("<span class='[notify_span]'>[text]</span>")
