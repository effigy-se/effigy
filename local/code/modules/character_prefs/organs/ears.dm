/// Cat ears
/obj/item/organ/ears/cat
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/cat_ears

/datum/bodypart_overlay/mutant/ears/cat_ears/get_global_feature_list()
	return SSaccessories.ears_list

/// Lizard ears
/obj/item/organ/ears/lizard
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/lizard_ears

/datum/bodypart_overlay/mutant/ears/lizard_ears/get_global_feature_list()
	return SSaccessories.ears_list_lizard

/// Fox ears
/obj/item/organ/ears/fox
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/fox_ears

/datum/bodypart_overlay/mutant/ears/fox_ears/get_global_feature_list()
	return SSaccessories.ears_list_fox

/// Dog ears
/obj/item/organ/ears/dog
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/dog_ears
	restyle_flags = EXTERNAL_RESTYLE_FLESH

/datum/bodypart_overlay/mutant/ears/dog_ears/get_global_feature_list()
	return SSaccessories.ears_list_dog

/// Flying ears
/obj/item/organ/ears/flying
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/flying_ears
	restyle_flags = EXTERNAL_RESTYLE_FLESH

/datum/bodypart_overlay/mutant/ears/flying_ears/get_global_feature_list()
	return SSaccessories.ears_list_flying

/// Mammal ears
/obj/item/organ/ears/mammal
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/mammal_ears
	restyle_flags = EXTERNAL_RESTYLE_FLESH

/datum/bodypart_overlay/mutant/ears/mammal_ears/get_global_feature_list()
	return SSaccessories.ears_list_mammal

/// Monkey ears
/obj/item/organ/ears/monkey
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/monkey_ears
	restyle_flags = EXTERNAL_RESTYLE_FLESH

/datum/bodypart_overlay/mutant/ears/monkey_ears/get_global_feature_list()
	return SSaccessories.ears_list_monkey

/// Aquatic ears
/obj/item/organ/ears/fish
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/fish_ears
	restyle_flags = EXTERNAL_RESTYLE_FLESH

/datum/bodypart_overlay/mutant/ears/fish_ears/get_global_feature_list()
	return SSaccessories.ears_list_fish

/// Humanoid ears
/obj/item/organ/ears/humanoid
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/humanoid_ears
	restyle_flags = EXTERNAL_RESTYLE_FLESH

/datum/bodypart_overlay/mutant/ears/humanoid_ears/get_global_feature_list()
	return SSaccessories.ears_list_humanoid

/// Synth ears
/obj/item/organ/ears/cybernetic
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/cybernetic

/datum/bodypart_overlay/mutant/ears/cybernetic/get_global_feature_list()
	return SSaccessories.ears_list_synthetic
