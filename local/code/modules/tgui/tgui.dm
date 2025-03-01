GLOBAL_LIST_EMPTY(tgui_cache_layout)
GLOBAL_LIST_EMPTY(tgui_cache_fancy)
GLOBAL_LIST_EMPTY(tgui_cache_locked)

/proc/get_cached_tgui_layout_pref(ckey)
	return "default"

/proc/get_cached_tgui_fancy_pref(ckey)
	return TRUE

/proc/get_cached_tgui_locked_pref(ckey)
	return TRUE
