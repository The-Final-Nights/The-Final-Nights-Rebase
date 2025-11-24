/datum/action/basic_vicissitude
	name = "Vicissitude Shapeshfting"
	desc = "Shapeshift your body."
	button_icon_state = "basic"
	check_flags = AB_CHECK_CONSCIOUS
	vampiric = TRUE

/datum/action/basic_vicissitude/Trigger()
	. = ..()


// Malleable Visage - Transform your own appearance or voice to someone you've saved before
/datum/action/basic_viscissitude/proc/copy_voice(mob/target)
	owner.override_voice = target.real_name
	to_chat(owner, span_notice("We shape our glands to take the voice of <b>[mimic_voice]</b>."))

/datum/action/basic_viscissitude/proc/return_voice()
	owner.override_voice = ""
	to_chat(owner, span_notice("Our vocal glands return to their original position."))
