GAME_VERB(/mob/living, layershift_up, "Layer Shift Up", "IC")
	if(incapacitated)
		to_chat(src, span_warning("You can't do that right now!"))
		return

	if(layer >= MOB_LAYER_SHIFT_MAX)
		to_chat(src, span_warning("You cannot increase your layer priority any further."))
		return

	layer += MOB_LAYER_SHIFT_INCREMENT
	var/layer_priority = (layer - MOB_LAYER) * 100 // Just for text feedback
	to_chat(src, span_notice("Your layer priority is now [layer_priority]."))

GAME_VERB(/mob/living, layershift_down, "Layer Shift Down", "IC")
	if(incapacitated)
		to_chat(src, span_warning("You can't do that right now!"))
		return

	if(layer <= MOB_LAYER_SHIFT_MIN)
		to_chat(src, span_warning("You cannot decrease your layer priority any further."))
		return

	layer -= MOB_LAYER_SHIFT_INCREMENT
	var/layer_priority = (layer - MOB_LAYER) * 100 // Just for text feedback
	to_chat(src, span_notice("Your layer priority is now [layer_priority]."))
