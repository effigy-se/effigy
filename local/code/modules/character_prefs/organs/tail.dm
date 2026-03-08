/// Monkey tail
/obj/item/organ/tail/monkey
	name = "monkey tail"

/// Mammal tail
/obj/item/organ/tail/mammal
	name = "mammal tail"
	dna_block = null
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/mammal

/datum/bodypart_overlay/mutant/tail/mammal
	feature_key = "tail_mammal"

/// Dog tail
/obj/item/organ/tail/dog
	dna_block = null
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/dog

/datum/bodypart_overlay/mutant/tail/dog
	feature_key = "tail_dog"

/// Fox tail
/obj/item/organ/tail/fox
	dna_block = null
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/fox

/datum/bodypart_overlay/mutant/tail/fox
	feature_key = "tail_fox"

/// Flying tail
/obj/item/organ/tail/flying
	dna_block = null
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/flying

/datum/bodypart_overlay/mutant/tail/flying
	feature_key = "tail_flying"

/// Fish tail
/obj/item/organ/tail/fish
	organ_traits = list(TRAIT_TACKLING_TAILED_DEFENDER, TRAIT_FLOPPING)

/// Humanoid tail
/obj/item/organ/tail/humanoid
	dna_block = null
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/humanoid

/datum/bodypart_overlay/mutant/tail/humanoid
	feature_key = "tail_humanoid"
