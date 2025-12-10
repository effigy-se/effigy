#define STORYTELLER_LAST_FILEPATH "data/storyteller_last_round.txt"

/*
### PERSISTENCE SUBSYSTEM TRACKING BELOW ###
Basically, this keeps track of what we voted last time to prevent it being voted on again.
For this, we use the SSpersistence.last_storyteller_type variable

We then just check what the last one is in SSgamemode.storyteller_vote_choices()
*/

/datum/controller/subsystem/persistence
	var/last_storyteller_type = ""

/datum/controller/subsystem/persistence/Initialize()
	. = ..()
	load_storyteller_type()
	load_tagline()

/// Extends collect_data
/datum/controller/subsystem/persistence/collect_data()
	. = ..()
	collect_storyteller_type()
	save_tagline()

/// Loads last storyteller into last_storyteller_type
/datum/controller/subsystem/persistence/proc/load_storyteller_type()
	if(!fexists(STORYTELLER_LAST_FILEPATH))
		return
	last_storyteller_type = text2num(file2text(STORYTELLER_LAST_FILEPATH))

/// Collects current storyteller and stores it
/datum/controller/subsystem/persistence/proc/collect_storyteller_type()
	rustg_file_write("[SSgamemode.storyteller.storyteller_type]", STORYTELLER_LAST_FILEPATH)

#undef STORYTELLER_LAST_FILEPATH
