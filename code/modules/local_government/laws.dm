/datum/local_government_law
	var/name = "Placeholder Law Title"
	var/desc = "This is a description of what constitutes a breach of this law."
	var/explanation = "This is an explanation of why enforcing this law matters to the Government."
	var/fine_amount = 0
	var/punishable_by_death = FALSE
	var/punishable_by_extradition = FALSE

/datum/local_government_law/New()
	. = ..()
	desc = replacetext(desc, "$CREDITS$", "[fine_amount]")

/datum/local_government_law/test_fine_law
	name = "Fine Test"
	desc = "Testing incurs a fine of $CREDITS%."
	explanation = "A test law for showing fine rendering needs to exist."
	fine_amount = 5000

/datum/local_government_law/test_death_law
	name = "Execution Test"
	desc = "Testing incurs the death penalty, performed by the Government representatives via Firing Squad."
	explanation = "A test law for showing that the marker for being an execution worthy law needs to exist."
	punishable_by_death = TRUE

/datum/local_government_law/test_extradition_law
	name = "Extradition Test"
	desc = "Testing incurs extradition to the Home World for sentencing, performed by the Government representatives via the teleporter in their office."
	explanation = "A test law for showing that the marker for being an extradition worthy law needs to exist."
	punishable_by_death = TRUE

/datum/local_government_law/random
	name = "Random Law"

/datum/local_government_law/random/test_random_law
	name = "Fine Random Test"
	desc = "Testing incurs a fine of $CREDITS%."
	explanation = "A test law for showing fine rendering needs to exist."
	fine_amount = 5000

/datum/local_government_law/random/test_random_law_2
	name = "Execution Random Test"
	desc = "Testing incurs the death penalty, performed by the Government representatives via Firing Squad."
	explanation = "A test law for showing that the marker for being an execution worthy law needs to exist."
	punishable_by_death = TRUE

/datum/local_government_law/random/test_random_law_3
	name = "Extradition Random Test"
	desc = "Testing incurs extradition to the Home World for sentencing, performed by the Government representatives via the teleporter in their office."
	explanation = "A test law for showing that the marker for being an extradition worthy law needs to exist."
	punishable_by_death = TRUE
