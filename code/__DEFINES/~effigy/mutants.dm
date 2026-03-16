/// The defines of each animal type who have their respective organ and list of sprite accessories beholding to them
///	The string generally has to much the type name of the organ they represent, i.e. /obj/item/organ/tail/dog. Aquatic is an exception, it's pathed as 'fish'
#define NO_VARIATION "none"
#define AQUATIC_TYPE "aquatic"
#define CAT_TYPE "cat"
#define DOG_TYPE "dog"
#define FLYING_TYPE "flying"
#define FOX_TYPE "fox"
#define HUMANOID_TYPE "humanoid"
#define LIZARD_TYPE "lizard"
#define MONKEY_TYPE "monkey"
#define MAMMAL_TYPE "mammal"

///	This list gets read by the dropdown pref when a player chooses what type of sprite accessory to access
GLOBAL_LIST_INIT(mutant_variations, list(
	AQUATIC_TYPE,
	CAT_TYPE,
	DOG_TYPE,
	FLYING_TYPE,
	FOX_TYPE,
	HUMANOID_TYPE,
	LIZARD_TYPE,
	MAMMAL_TYPE,
))

GLOBAL_LIST_INIT(tail_variations, list(
	NO_VARIATION = null,
	AQUATIC_TYPE = /obj/item/organ/tail/fish,
	CAT_TYPE = /obj/item/organ/tail/cat,
	DOG_TYPE = /obj/item/organ/tail/dog,
	FLYING_TYPE = /obj/item/organ/tail/flying,
	FOX_TYPE = /obj/item/organ/tail/fox,
	HUMANOID_TYPE = /obj/item/organ/tail/humanoid,
	LIZARD_TYPE = /obj/item/organ/tail/lizard,
	MAMMAL_TYPE = /obj/item/organ/tail/mammal,
))

GLOBAL_LIST_INIT(ear_variations, list(
	NO_VARIATION = null,
	AQUATIC_TYPE = /obj/item/organ/ears/fish,
	CAT_TYPE = /obj/item/organ/ears/cat,
	DOG_TYPE = /obj/item/organ/ears/dog,
	FLYING_TYPE = /obj/item/organ/ears/flying,
	FOX_TYPE = /obj/item/organ/ears/fox,
	HUMANOID_TYPE = /obj/item/organ/ears/humanoid,
	LIZARD_TYPE = /obj/item/organ/ears/lizard,
	MAMMAL_TYPE = /obj/item/organ/ears/mammal,
))

#define FEATURE_CYBER_FRAME "cyber_frame"
#define FEATURE_CYBER_ORGANS "cyber_organs"
#define FEATURE_FLUFF "fluff"
#define FEATURE_DIGI_LEGS "digi_legs"
#define FEATURE_TAIL "tail"
#define FEATURE_EARS_AQUATIC "ears_fish"
#define FEATURE_EARS_CAT "ears_cat"
#define FEATURE_EARS_DOG "ears_dog"
#define FEATURE_EARS_FLYING "ears_flying"
#define FEATURE_EARS_FOX "ears_fox"
#define FEATURE_EARS_HUMANOID "ears_humanoid"
#define FEATURE_EARS_LIZARD "ears_lizard"
#define FEATURE_EARS_MAMMAL "ears_mammal"
#define FEATURE_EARS_MONKEY "ears_monkey"

#define FEATURE_TAIL_DOG "tail_dog"
#define FEATURE_TAIL_FLYING "tail_flying"
#define FEATURE_TAIL_FOX "tail_fox"
#define FEATURE_TAIL_HUMANOID "tail_humanoid"
#define FEATURE_TAIL_MAMMAL "tail_mammal"

GLOBAL_LIST_INIT(bodypart_allowed_species, list(
	FEATURE_MOTH_ANTENNAE = typecacheof(list(
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/moth,
		/datum/species/synth,
	)),
	FEATURE_CYBER_FRAME = typecacheof(list(
		/datum/species/animalid,
		/datum/species/human,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/plasmaman,
		/datum/species/synth,
	)),
	FEATURE_CYBER_ORGANS = typecacheof(list(
		/datum/species/animalid,
		/datum/species/human,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/plasmaman,
	)),
	FEATURE_EARS = typecacheof(list(
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/synth,
	)),
	FEATURE_FLUFF = typecacheof(list(
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/synth,
	)),
	FEATURE_FRILLS = typecacheof(list(
		/datum/species/animalid,
		/datum/species/lizard,
		/datum/species/synth,
	)),
	FEATURE_HORNS = typecacheof(list(
		/datum/species/animalid,
		/datum/species/lizard,
		/datum/species/synth,
	)),
	FEATURE_DIGI_LEGS = typecacheof(list(
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/synth,
	)),
	FEATURE_LIZARD_MARKINGS = typecacheof(list(
		/datum/species/animalid,
		/datum/species/lizard,
		/datum/species/synth,
	)),
	FEATURE_SNOUT = typecacheof(list(
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/synth,
	)),
	FEATURE_TAIL = typecacheof(list(
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/synth,
	)),
	FEATURE_WINGS = typecacheof(list(
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/synth,
	)),
))

// length of the dna feature marking list
#define MARKING_LIST_LEN 24

// dna feature marking list item locations
#define MARKING_HEAD 1
#define MARKING_HEAD2 2
#define MARKING_HEAD3 3
#define MARKING_CHEST 4
#define MARKING_CHEST2 5
#define MARKING_CHEST3 6
#define MARKING_RARM 7
#define MARKING_RARM2 8
#define MARKING_RARM3 9
#define MARKING_LARM 10
#define MARKING_LARM2 11
#define MARKING_LARM3 12
#define MARKING_LHAND 13
#define MARKING_LHAND2 14
#define MARKING_LHAND3 15
#define MARKING_RHAND 16
#define MARKING_RHAND2 17
#define MARKING_RHAND3 18
#define MARKING_LLEG 19
#define MARKING_LLEG2 20
#define MARKING_LLEG3 21
#define MARKING_RLEG 22
#define MARKING_RLEG2 23
#define MARKING_RLEG3 24
