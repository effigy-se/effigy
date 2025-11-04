/datum/techweb_node/customizable_limbs
	id = TECHWEB_NODE_CUSTOMIZABLE_LIMBS
	display_name = "Customizable Cybernetics"
	description = "Be all you can't be. Be a new you!"
	prereq_ids = list(TECHWEB_NODE_AUGMENTATION)
	design_ids = list(
		"customizable_head",
		"customizable_chest",
		"customizable_l_arm",
		"customizable_r_arm",
		"customizable_l_leg",
		"customizable_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/synth_organs
	id = TECHWEB_NODE_SYNTH_ORGANS
	starting_node = TRUE
	display_name = "Synth Internal Components"
	description = "Internal Mechanisms for Synthetics."
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"synth_eyes",
		"synth_tongue",
		"synth_liver",
		"synth_lungs",
		"synth_stomach",
		"synth_charger",
		"synth_ears",
		"synth_heart",
	)
