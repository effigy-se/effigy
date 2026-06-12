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
	return CONFIG_GET(flag/shift_extensions_enabled)

/datum/vote/shift_extension/toggle_votable()
	CONFIG_SET(flag/shift_extensions_enabled, !CONFIG_GET(flag/shift_extensions_enabled))
	message_admins("Shift extensions config changed to [CONFIG_GET(flag/shift_extensions_enabled) ? "ENABLED," : "DISABLED,"] set by [ADMIN_LOOKUP(usr)].")
	log_admin("Shift extensions config changed to [CONFIG_GET(flag/shift_extensions_enabled) ? "ENABLED," : "DISABLED,"] set by [key_name_admin(usr)].")

/datum/vote/shift_extension/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .

	if(!forced)
		return "Only admins can create extension votes."

	if(CONFIG_GET(flag/disable_auto_shuttle))
		return "Auto-shuttle is disabled in config!"

	if(!CONFIG_GET(flag/shift_extensions_enabled))
		return "Shift extensions are disabled! Press \[Active] button to toggle."

	return VOTE_AVAILABLE

/datum/vote/shift_extension/finalize_vote(winning_option)
	if(winning_option == CHOICE_EXTENSION)
		return

	if(winning_option == CHOICE_SHUTTLE)
		SSgamemode.call_auto_shuttle(reason = "crew vote")
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")
