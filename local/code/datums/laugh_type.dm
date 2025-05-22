GLOBAL_LIST_INIT(laugh_types, init_laugh_types_list())

/proc/init_laugh_types_list()
	var/list/laughs = list()
	for(var/datum/laugh_type/laugh as anything in subtypesof(/datum/laugh_type))
		laughs[laugh::name] = new laugh()
	return laughs

/datum/laugh_type
	var/name
	var/list/laugh_sounds

/datum/laugh_type/none //Why would you want this?
	name = "No Laugh"
	laugh_sounds = null

/datum/laugh_type/human_male
	name = "Human Laugh (Male)"
	laugh_sounds = list('sound/mobs/humanoids/human/laugh/manlaugh1.ogg', 'sound/mobs/humanoids/human/laugh/manlaugh2.ogg')

/datum/laugh_type/human_female
	name = "Human Laugh (Female)"
	laugh_sounds = list('local/sound/emotes/generic/female/female_giggle_1.ogg', 'local/sound/emotes/generic/female/female_giggle_2.ogg')

/datum/laugh_type/felinid
	name = "Felinid Laugh"
	laugh_sounds = list('local/sound/emotes/generic/nyahaha1.ogg', 'local/sound/emotes/generic/nyahaha2.ogg', 'local/sound/emotes/generic/nyaha.ogg', 'local/sound/emotes/generic/nyahehe.ogg')

/datum/laugh_type/moth
	name = "Moth Laugh"
	laugh_sounds = list('local/sound/emotes/generic/mothlaugh.ogg')

/datum/laugh_type/slugcat
	name = "Slugcat Laugh"
	laugh_sounds = list('local/sound/emotes/voice/scuglaugh_1.ogg')
