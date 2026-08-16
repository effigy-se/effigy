/datum/techweb_node/bluespace_miner
	display_name = "Bluespace Miner"
	description = "The future is here, where we can mine ores from the great bluespace sea."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	node_flags = parent_type::node_flags | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL
	prerequisite_nodes = list(/datum/techweb_node/applied_bluespace)
	unlocked_designs = list(/datum/design/board/bluespace_miner)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_ENGINEERING, RADIO_CHANNEL_SUPPLY)
