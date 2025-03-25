#define PREF "PREF"
#define ICON "ICON"

/proc/debug_effigy(type, message)
	var/msg_type = type
	if(isnull(type))
		msg_type = "GAME"
	var/msg = span_debugcyan("\[[span_debugwhite("EF")]]\[[span_debugyellow(msg_type)]\] [message]")
	to_chat(world, msg)
	logger.Log(LOG_CATEGORY_DEBUG, message)

/proc/log_events(text, list/data, notify_admins = FALSE, notify_span = "adminnotice")
	logger.Log(LOG_CATEGORY_EVENTS, text, data)
	if(notify_admins)
		message_admins("<span class='[notify_span]'>[text]</span>")
