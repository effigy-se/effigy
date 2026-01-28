// Slash
// Fast to rise, but lower damage overall
// Also a bit easy to treat
/datum/wound/electrical_damage/slash
	simple_desc = "Wiring has been slashed open, resulting in a fault that <b>quickly</b> intensifies!"

/datum/wound/electrical_damage/slash/get_limb_examine_description()
	return span_warning("The wiring on this limb is slashed open.")

/datum/wound/electrical_damage/slash/moderate
	name = "Frayed Wiring"
	desc = "Internal wiring has suffered a slight abrasion, causing a slow electrical fault that will intensify over time."
	occur_text = "lets out a few sparks, as a few frayed wires stick out"
	examine_desc = "has a few frayed wires sticking out"
	treat_text = "Replacing of damaged wiring, though repairs via wirecutting instruments or sutures may suffice, albeit at limited efficiency. In case of emergency, \
				subject may be subjected to high temperatures to allow solder to reset."

	sound_effect = 'local/sound/effects/robotic_slash_T1.ogg'

	severity = WOUND_SEVERITY_MODERATE

	sound_volume = 30

	threshold_penalty = 20

	intensity = 10 SECONDS
	processing_full_shock_threshold = 3 MINUTES

	processing_shock_power_per_second_max = 0.5
	processing_shock_power_per_second_min = 0.4

	processing_shock_stun_chance = 0
	processing_shock_spark_chance = 30

	process_shock_spark_count_max = 1
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.1
	wire_repair_percent = 0.023

	initial_sparks_amount = 1

	status_effect_type = /datum/status_effect/wound/electrical_damage/slash/moderate

	a_or_from = "from"

	scar_keyword = "slashmoderate"

/datum/wound/electrical_damage/slash/severe
	name = "Severed Conduits"
	desc = "A number of wires have been completely cut, resulting in electrical faults that will intensify at a worrying rate."
	occur_text = "sends some electrical fiber in the direction of the blow, beginning to profusely spark"
	examine_desc = "has multiple severed wires visible to the outside"
	treat_text = "Containment of damaged wiring via gauze, then application of fresh wiring/sutures, or resetting of displaced wiring via wirecutter/retractor."

	sound_effect = 'local/sound/effects/robotic_slash_T2.ogg'

	severity = WOUND_SEVERITY_SEVERE

	sound_volume = 15

	threshold_penalty = 30

	intensity = 10 SECONDS
	processing_full_shock_threshold = 2 MINUTES

	processing_shock_power_per_second_max = 0.7
	processing_shock_power_per_second_min = 0.6

	processing_shock_stun_chance = 0
	processing_shock_spark_chance = 60

	process_shock_spark_count_max = 2
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.09
	wire_repair_percent = 0.015

	initial_sparks_amount = 3

	status_effect_type = /datum/status_effect/wound/electrical_damage/slash/severe

	a_or_from = "from"

	scar_keyword = "slashsevere"

/datum/wound/electrical_damage/slash/critical
	name = "Systemic Fault"
	desc = "A significant portion of the power distribution network has been cut open, resulting in massive power loss and runaway electrocution."
	occur_text = "lets out a violent \"zhwarp\" sound as angry electric arcs attack the surrounding air"
	examine_desc = "has lots of mauled wires sticking out"
	treat_text = "Immediate securing via gauze, followed by emergency cable replacement and securing via wirecutters or retractor. \
		If the fault has become uncontrollable, extreme heat therapy is recommended."

	severity = WOUND_SEVERITY_CRITICAL
	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|CAN_BE_GRASPED)

	sound_effect = 'local/sound/effects/robotic_slash_T3.ogg'

	sound_volume = 30

	threshold_penalty = 50

	intensity = 10 SECONDS
	processing_full_shock_threshold = 1.25 MINUTES

	processing_shock_power_per_second_max = 1.3
	processing_shock_power_per_second_min = 1.1

	processing_shock_stun_chance = 5
	processing_shock_spark_chance = 90

	process_shock_spark_count_max = 3
	process_shock_spark_count_min = 2

	wirecut_repair_percent = 0.08
	wire_repair_percent = 0.01

	initial_sparks_amount = 8

	status_effect_type = /datum/status_effect/wound/electrical_damage/slash/critical

	a_or_from = "a"

	scar_keyword = "slashcritical"

