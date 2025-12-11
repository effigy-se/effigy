/datum/vote/var/has_desc = FALSE

/datum/vote/proc/return_desc(vote_name)
	return ""

/datum/vote/storyteller
	name = "Game Mode"
	default_message = "Vote for the game mode!"
	has_desc = TRUE
	count_method = VOTE_COUNT_METHOD_MULTI
	winner_method = VOTE_WINNER_METHOD_SIMPLE
	vote_reminder = TRUE

/datum/vote/storyteller/New()
	. = ..()
	default_choices = list()
	default_choices = SSgamemode.storyteller_vote_choices()


/datum/vote/storyteller/return_desc(vote_name)
	return SSgamemode.storyteller_desc(vote_name)

/datum/vote/storyteller/create_vote()
	. = ..()
	if((length(choices) == 1)) // Only one choice, no need to vote.
		var/de_facto_winner = choices[1]
		SSgamemode.storyteller_vote_result(de_facto_winner)
		to_chat(world, span_boldannounce("The game mode vote has been skipped because there is only one game mode left to vote for. The game mode has been changed to [de_facto_winner]."))
		return FALSE

/datum/vote/storyteller/can_be_initiated(mob/by_who, forced = FALSE)
	. = ..()
	if(forced)
		return TRUE

	if(SSgamemode.storyteller_voted)
		default_message = "The next game mode has already been selected."
		return FALSE

/datum/vote/storyteller/finalize_vote(winning_option)
	SSgamemode.storyteller_vote_result(winning_option)
	SSgamemode.storyteller_voted = TRUE
