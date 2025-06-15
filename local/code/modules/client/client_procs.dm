/client/proc/check_admin_devtools()
	if(!CONFIG_GET(flag/enable_localhost_devtools) || !src.is_localhost())
		return

	if(SSticker.current_state < GAME_STATE_PREGAME)
		RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(enable_admin_devtools))
		return

/client/proc/enable_admin_devtools()
	SIGNAL_HANDLER

	winset(src, null, list("browser-options" = "+devtools"))
	to_chat(src, span_medradio("DEBUG: TGUI DevTools are enabled!"))
	UnregisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME)
