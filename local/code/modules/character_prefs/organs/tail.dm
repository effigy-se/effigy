/// Monkey tail
/obj/item/organ/tail/monkey
	name = "monkey tail"
	wag_flags = WAG_ABLE

/// Mammal tail
/obj/item/organ/tail/mammal
	name = "mammal tail"
	dna_block = null
	wag_flags = WAG_ABLE
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/mammal

/datum/bodypart_overlay/mutant/tail/mammal
	feature_key = "tail_other"

/datum/bodypart_overlay/mutant/tail/mammal/get_global_feature_list()
	return SSaccessories.tails_list_mammal

/// Dog tail
/obj/item/organ/tail/dog
	dna_block = null
	wag_flags = WAG_ABLE
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/dog

/datum/bodypart_overlay/mutant/tail/dog
	feature_key = "tail_other"

/datum/bodypart_overlay/mutant/tail/dog/get_global_feature_list()
	return SSaccessories.tails_list_dog

/// Fox tail
/obj/item/organ/tail/fox
	dna_block = null
	wag_flags = WAG_ABLE
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/fox

/datum/bodypart_overlay/mutant/tail/fox
	feature_key = "tail_other"

/datum/bodypart_overlay/mutant/tail/fox/get_global_feature_list()
	return SSaccessories.tails_list_fox

/// Flying tail
/obj/item/organ/tail/flying
	dna_block = null
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/flying

/datum/bodypart_overlay/mutant/tail/flying
	feature_key = "tail_other"

/datum/bodypart_overlay/mutant/tail/flying/get_global_feature_list()
	return SSaccessories.tails_list_flying

/// Fish tail
/obj/item/organ/tail/fish
	organ_traits = list(TRAIT_TACKLING_TAILED_DEFENDER, TRAIT_FLOPPING)

/// Synth tail
/obj/item/organ/tail/cybernetic
	dna_block = null
	organ_flags = ORGAN_ROBOTIC
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/cybernetic

/datum/bodypart_overlay/mutant/tail/cybernetic
	feature_key = "tail_other"

/datum/bodypart_overlay/mutant/tail/cybernetic/get_global_feature_list()
	return SSaccessories.tails_list_synth

/// Humanoid tail
/obj/item/organ/tail/humanoid
	dna_block = null
	wag_flags = WAG_ABLE
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/humanoid

/datum/bodypart_overlay/mutant/tail/humanoid
	feature_key = "tail_other"

/datum/bodypart_overlay/mutant/tail/humanoid/get_global_feature_list()
	return SSaccessories.tails_list_humanoid
