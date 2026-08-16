/datum/techweb_node/customizable_limbs
	display_name = "Customizable Cybernetics"
	description = "Be all you can't be. Be a new you!"
	prerequisite_nodes = list(/datum/techweb_node/augmentation)
	unlocked_designs = list(
		/datum/design/customizable_head,
		/datum/design/customizable_chest,
		/datum/design/customizable_l_arm,
		/datum/design/customizable_r_arm,
		/datum/design/customizable_l_leg,
		/datum/design/customizable_r_leg,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/synth_organs
	node_flags = parent_type::node_flags | TECHWEB_NODE_STARTER
	display_name = "Synth Internal Components"
	description = "Internal Mechanisms for Synthetics."
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/synth_eyes,
		/datum/design/synth_tongue,
		/datum/design/synth_liver,
		/datum/design/synth_heatsink,
		/datum/design/synth_stomach,
		/datum/design/synth_charger,
		/datum/design/synth_ears,
		/datum/design/synth_heart,
	)
