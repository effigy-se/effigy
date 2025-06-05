/// The defines of each animal type who have their respective organ and list of sprite accessories beholding to them
///	The string generally has to much the type name of the organ they represent, i.e. /obj/item/organ/tail/dog. Aquatic is an exception, it's pathed as 'fish'
#define NO_VARIATION "none"
#define AQUATIC_TYPE "aquatic"
#define CAT_TYPE "cat"
#define CYBERNETIC_TYPE "cybernetic"
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

#define ANTENNAE "antennae"
#define CYBER_FRAME "cyber_frame"
#define CYBER_ORGANS "cyber_organs"
#define EARS "ears"
#define FLUFF "fluff"
#define FRILLS "frills"
#define HORNS "horns"
#define DIGI_LEGS "digi_legs"
#define SNOUT "snout"
#define LIZARD_MARKING "lizard_marking"
#define MOTH_MARKING "moth_marking"
#define MUSHROOM_CAP "mush_cap"
#define SPINES "spines"
#define TAIL "tail"
#define WINGS "wings"

GLOBAL_LIST_INIT(bodypart_allowed_species, list(
	ANTENNAE = list(
		/datum/species/android,
		/datum/species/insectoid,
		/datum/species/moth,
	),
	CYBER_FRAME = list(
		/datum/species/android,
		/datum/species/animalid,
		/datum/species/human,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/plasmaman,
	),
	CYBER_ORGANS = list(
		/datum/species/animalid,
		/datum/species/human,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
		/datum/species/plasmaman,
	),
	EARS = list(
		/datum/species/android,
		/datum/species/animalid,
		/datum/species/insectoid,
	),
	FLUFF = list(
		/datum/species/moth,
	),
	FRILLS = list(
		/datum/species/android,
		/datum/species/animalid,
		/datum/species/lizard,
	),
	HORNS = list(
		/datum/species/android,
		/datum/species/animalid,
		/datum/species/lizard,
	),
	DIGI_LEGS = list(
		/datum/species/android,
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/lizard,
		/datum/species/moth,
	),
	SNOUT = list(
		/datum/species/animalid,
		/datum/species/android,
		/datum/species/insectoid,
		/datum/species/lizard,
	),
	TAIL = list(
		/datum/species/animalid,
		/datum/species/android,
		/datum/species/insectoid,
		/datum/species/lizard,
	),
	WINGS = list(
		/datum/species/android,
		/datum/species/animalid,
		/datum/species/insectoid,
		/datum/species/moth,
	),
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
