/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	mob_examine_panel = new(src) //create the datum
	//AddComponent(/datum/component/interactable)

/mob/living/carbon/human/Destroy()
	QDEL_NULL(mob_examine_panel)
	return ..()

/mob/living/carbon/human/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"])
		switch(href_list["lookup_info"])
			/*
			if("genitals")
				var/list/line = list()
				for(var/genital in GLOB.possible_genitals)
					if(!dna.species.mutant_bodyparts[genital])
						continue
					var/datum/sprite_accessory/genital/G = SSaccessories.sprite_accessories[genital][dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
					if(!G)
						continue
					if(G.is_hidden(src))
						continue
					var/obj/item/organ/genital/ORG = get_organ_slot(G.associated_organ_slot)
					if(!ORG)
						continue
					line += ORG.get_description_string(G)
				if(length(line))
					to_chat(usr, span_notice("[jointext(line, "\n")]"))
			*/
			if("open_examine_panel")
				mob_examine_panel.ui_interact(usr) //datum has a examine_panel component, here we open the window

			//if("open_character_ad")
			//	usr.client?.show_character_directory(specific_ad = real_name)

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(wear_neck && body_position == STANDING_UP && loc == NewLoc && has_gravity(loc))
		SEND_SIGNAL(wear_neck, COMSIG_NECK_STEP_ACTION)
