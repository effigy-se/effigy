GLOBAL_LIST_INIT(scream_types, init_scream_types_list())

/proc/init_scream_types_list()
	var/list/screams = list()
	for(var/datum/scream_type/scream as anything in subtypesof(/datum/scream_type))
		screams[scream::name] = new scream()
	return screams

/datum/scream_type
	var/name
	var/list/scream_sounds

/datum/scream_type/none //Why would you want this?
	name = "No Scream"
	scream_sounds = null

/datum/scream_type/human_male
	name = "Human Scream (Male)"
	scream_sounds = list('local/sound/emotes/voice/scream_m1.ogg', 'local/sound/emotes/voice/scream_m2.ogg')

/datum/scream_type/human_female
	name = "Human Scream (Female)"
	scream_sounds = list('local/sound/emotes/voice/scream_f1.ogg', 'local/sound/emotes/voice/scream_f2.ogg')

/datum/scream_type/robotic
	name = "Robotic Scream"
	scream_sounds = list('local/sound/emotes/voice/scream_silicon.ogg')

/datum/scream_type/lizard
	name = "Lizard Scream"
	scream_sounds = list('sound/mobs/humanoids/lizard/lizard_scream_1.ogg', 'sound/mobs/humanoids/lizard/lizard_scream_3.ogg')

/datum/scream_type/lizard2
	name = "Lizard Scream 2"
	scream_sounds = list('local/sound/emotes/voice/scream_lizard.ogg')

/datum/scream_type/moth
	name = "Moth Scream"
	scream_sounds = list('local/sound/emotes/voice/scream_moth.ogg')

/datum/scream_type/jelly
	name = "Jelly Scream"
	scream_sounds = list('local/sound/emotes/generic/jelly_scream.ogg')

/datum/scream_type/vox
	name = "Vox Scream"
	scream_sounds = list('local/sound/emotes/generic/voxscream.ogg')

/datum/scream_type/tajaran
	name = "Cat Scream"
	scream_sounds = list('local/sound/emotes/generic/cat_scream.ogg')

/datum/scream_type/xeno
	name = "Xeno Scream"
	scream_sounds = list('sound/mobs/non-humanoids/hiss/hiss6.ogg')

/datum/scream_type/raptor //This is the Teshari scream ported from CitRP which was a cockatoo scream edited by BlackMajor.
	name = "Raptor Scream"
	scream_sounds = list('local/sound/emotes/generic/raptorscream.ogg')

/datum/scream_type/rodent //Ported from Polaris/Virgo.
	name = "Rodent Scream"
	scream_sounds = list('local/sound/emotes/generic/rodentscream.ogg')

/datum/scream_type/ethereal
	name = "Ethereal Scream"
	scream_sounds = list('sound/mobs/humanoids/ethereal/ethereal_scream_1.ogg', 'sound/mobs/humanoids/ethereal/ethereal_scream_2.ogg', 'sound/mobs/humanoids/ethereal/ethereal_scream_3.ogg')

//DONATOR SCREAMS
/datum/scream_type/zombie
	name = "Zombie Scream"
	scream_sounds = list('local/sound/emotes/generic/zombie_scream.ogg')

/datum/scream_type/monkey
	name = "Monkey Scream"
	scream_sounds = list('local/sound/emotes/voice/scream_monkey.ogg')

/datum/scream_type/gorilla
	name = "Gorilla Scream"
	scream_sounds = list('sound/mobs/non-humanoids/gorilla/gorilla.ogg')

/datum/scream_type/skeleton
	name = "Skeleton Scream"
	scream_sounds = list('local/sound/emotes/voice/scream_skeleton.ogg')

/datum/scream_type/slugcat
	name = "Slugcat Scream"
	scream_sounds = list('local/sound/emotes/voice/scugscream_1.ogg')
