/datum/component/interactable
	var/list/datum/emote/emotes

/datum/component/interactable/Initialize(...)
	. = ..()
	if(QDELETED(parent) || !ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	rebuild_emote_list()

/datum/component/interactable/Destroy(force)
	emotes.Cut()
	. = ..()

/datum/component/interactable/proc/rebuild_emote_list()
	emotes = list()
	for(var/key as anything in GLOB.emote_list)
		for(var/datum/emote/emote_iterator in GLOB.emote_list[key])
			if(emote_iterator.targets_person)
				emotes |= emote_iterator

/datum/component/interactable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(open_interaction_menu))

/datum/component/interactable/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT)

/datum/component/interactable/proc/open_interaction_menu(mob/clicked, mob/living/carbon/human/clicker)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(ui_interact), clicker)

/datum/component/interactable/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		var/mob/living/carbon/human/holder = parent
		ui = new(user, src, "InteractionMenu", "Interact - [holder.name]")
		ui.open()

/datum/component/interactable/ui_status(mob/user, datum/ui_state/state)
	if(!ishuman(user))
		return UI_CLOSE

	return UI_INTERACTIVE

/datum/component/interactable/ui_data(mob/user)
	. = ..()

	var/list/emote_data = list()
	for(var/datum/emote/emote_instance as anything in emotes)
		emote_data[emote_instance.key] = emote_instance.can_run_emote(user)
	.["emotes"] = emote_data

/datum/component/interactable/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(params["emote"])
		var/mob/living/carbon/human/holder = parent
		ui.user.emote(params["emote"], message = holder.name, intentional = TRUE)
		return TRUE
