#define CHOICE_EXTENSION "Shift Extension"
#define CHOICE_SHUTTLE "Dispatch Emergency Shuttle"

/datum/vote/shift_extension
	name = "Shift Extension"
	default_choices = list(
		CHOICE_EXTENSION,
		CHOICE_SHUTTLE,
	)
	default_message = "Vote to extend the length of the ongoing shift."

/datum/vote/shift_extension/is_config_enabled()
	return -CONFIG_GET(flag/disable_auto_shuttle)

/datum/vote/shift_extension/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .

	if(forced)
		return VOTE_AVAILABLE

	if(CONFIG_GET(flag/disable_auto_shuttle))
		return "Extension voting is disabled."

	return "Only admins can create extension votes."

/datum/vote/shift_extension/finalize_vote(winning_option)
	if(winning_option == CHOICE_EXTENSION)
		return

	if(winning_option == CHOICE_SHUTTLE)
		SSgamemode.call_auto_shuttle(reason = "crew vote")
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")
