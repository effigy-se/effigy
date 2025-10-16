/proc/roundstart_captaincy_announcement(announcement)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(queue_captaincy_announcement), announcement), 7 SECONDS) // Delayed so we don't overlap with the roundstart sounds

/proc/queue_captaincy_announcement(announcement)
	minor_announce(announcement, "Welcome to [station_name()]", sound_override = 'sound/announcer/announcement/announce_dig.ogg')
