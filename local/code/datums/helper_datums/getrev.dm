/// Provides the local build revision data for issue report tracking
/proc/get_local_revdata()
	if(GLOB.revdata_local)
		return GLOB.revdata_local

	GLOB.revdata_local = copytext(GLOB.revdata.commit, 1, 8)
	return GLOB.revdata_local
