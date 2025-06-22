/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	mob_examine_panel = new(src) //create the datum
	//AddComponent(/datum/component/interactable)

/mob/living/carbon/human/Destroy()
	QDEL_NULL(mob_examine_panel)
	selected_scream = null
	selected_laugh = null
	return ..()

/mob/living/carbon/human/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"] == "open_examine_panel")
		mob_examine_panel.ui_interact(usr) //datum has a examine_panel component, here we open the window

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(wear_neck && body_position == STANDING_UP && loc == NewLoc && has_gravity(loc))
		SEND_SIGNAL(wear_neck, COMSIG_NECK_STEP_ACTION)

/// From oldbase; the suit portion was flagged as being needed for the "latex straight jacket to behave". In practice commit history tells the story that it's, uh.
/// Closer to a load-bearing coconut?? Someone else can look at this later; right?
/mob/living/carbon/human/resist_restraints()
	if(wear_suit?.breakouttime)
		changeNext_move(wear_suit.resist_cooldown)
		last_special = world.time + wear_suit.resist_cooldown
		cuff_resist(wear_suit)
	if(gloves?.breakouttime)
		changeNext_move(gloves.resist_cooldown)
		last_special = world.time + gloves.resist_cooldown
		cuff_resist(gloves)
	else
		return ..()
