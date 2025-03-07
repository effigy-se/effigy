/// ADDITIONAL DEFAULT JUKEBOX MUSIC TRACKS ///

/*
	Why do it this way? Long and short of it is this music was produced for Effigy specifically as-was.
	It would work fine in-config; but these tracks are largely part of the codebase and deserve a seat.
	For that reason; sounds shouldn't be added this way solely for the purpose of being played over the
	jukebox & should still follow the codebase's standards for sounds.
*/

/// [ RE: POWER RECOVERY ]

/datum/track/default/repr_your_job_is_simple // cover of tintin on the moon anyways
	song_path = 'local/sound/music/re_power_recovery/lobby.ogg'
	song_name = "Blue Rose Red Heart - Your Job Is Simple"
	song_length = 3 MINUTES
	song_beat = 1 SECONDS // BPM of 40

/datum/track/default/repr_our_rides_here
	song_path = 'local/sound/music/re_power_recovery/shuttledock.ogg'
	song_name = "Blue Rose Red Heart - Our Ride's Here"
	song_length = 1 MINUTES + 16 SECONDS
	song_beat = 2 SECONDS + 4 DECISECONDS // BPM of 100

/// RIMPOINT

/datum/track/default/rim_hotspring_have // ALSO a cover on tintin on the moon...
	song_path = 'local/sound/ambience/ambihotspring.ogg'
	song_name = "Blue Rose Red Heart - Hotspring Haze"
	song_length = 1 MINUTES + 27 SECONDS
	song_beat = 5 SECONDS + 4 DECISECONDS + 55 MILLISECONDS // BPM of 44
