#define SEVERITY_STUN 1
#define SEVERITY_SNEEZE 2
#define SEVERITY_KNOCKDOWN 3
#define SEVERITY_BLEP 4

GLOBAL_LIST_INIT(possible_snout_sensitivities, list(
	"Stun" = SEVERITY_STUN,
	"Sneeze" = SEVERITY_SNEEZE, //Includes a stun
	"Collapse" = SEVERITY_KNOCKDOWN,
	"Blep" = SEVERITY_BLEP,
))

/datum/quirk/sensitivesnout
	name = "Sensitive Snout"
	desc = "Your face has always been sensitive, and it really hurts when someone pokes it!"
	gain_text = span_notice("Your face is awfully sensitive.")
	lose_text = span_notice("Your face feels numb.")
	medical_record_text = "Patient's nose seems to have a cluster of nerves in the tip, would advise against direct contact."
	value = 0
	mob_trait = TRAIT_SENSITIVESNOUT
	icon = FA_ICON_FINGERPRINT
	var/severity = SEVERITY_KNOCKDOWN
	COOLDOWN_DECLARE(emote_cooldown)

/datum/quirk_constant_data/sensitive_snout
	associated_typepath = /datum/quirk/sensitivesnout
	customization_options = list(/datum/preference/choiced/snout_sensitivity)

/datum/quirk/sensitivesnout/add(client/client_source)
	var/desired_severity = GLOB.possible_snout_sensitivities[client_source?.prefs?.read_preference(/datum/preference/choiced/snout_sensitivity)]
	severity = isnum(desired_severity) ? desired_severity : 1

/datum/quirk/sensitivesnout/proc/get_booped(attacker)
	var/can_emote = FALSE
	if(COOLDOWN_FINISHED(src, emote_cooldown))
		can_emote = TRUE
		COOLDOWN_START(src, emote_cooldown, 5 SECONDS)
	if (ishuman(quirk_holder) && can_emote)
		var/mob/living/carbon/human/human_holder = quirk_holder
		human_holder.force_say()
	switch(severity)
		if(SEVERITY_STUN)
			to_chat(quirk_holder, span_warning("[attacker] boops you on your sensitive nose, freezing you in place!"))
			quirk_holder.Stun(1 SECONDS)
		if(SEVERITY_SNEEZE)
			quirk_holder.Stun(1 SECONDS)
			if(can_emote)
				to_chat(quirk_holder, span_warning("[attacker] boops you on your sensitive nose! You can't hold back a sneeze!"))
				quirk_holder.emote("sneeze")
		if(SEVERITY_KNOCKDOWN)
			to_chat(quirk_holder, span_warning("[attacker] boops you on your sensitive nose, sending you to the ground!"))
			quirk_holder.Knockdown(1 SECONDS)
			quirk_holder.apply_damage(30, STAMINA)
		if(SEVERITY_BLEP)
			if(can_emote)
				to_chat(quirk_holder, span_warning("[attacker] boops you on your sensitive nose! You stick your tongue out on reflex!"))
				quirk_holder.emote("blep")

#undef SEVERITY_STUN
#undef SEVERITY_SNEEZE
#undef SEVERITY_KNOCKDOWN
#undef SEVERITY_BLEP
