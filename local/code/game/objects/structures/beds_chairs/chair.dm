/obj/structure/chair
	icon = 'local/icons/obj/chairs.dmi'

/obj/item/chair
	icon = 'local/icons/obj/chairs.dmi'

/obj/structure/chair/post_buckle_mob(mob/living/M)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_OVERSIZED) && !HAS_TRAIT(M, TRAIT_LIGHT_STEP))
		visible_message(span_warning("[src] buckles under the weight of [M] causing it to break!"))
		playsound(src, 'local/sound/effects/chair_break.ogg', 70, TRUE)
		deconstruct()
