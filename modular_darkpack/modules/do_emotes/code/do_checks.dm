/mob/living/proc/doverb_checks(message)
	if(!length(message))
		return FALSE

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(src, span_danger("Speech is currently admin-disabled."))
		return FALSE

	//quickly calc our name stub again: duplicate this in say.dm override
	var/name_stub = " (<b>[name]</b>)"
	if(length(message) > (MAX_MESSAGE_LEN - length(name_stub)))
		to_chat(src, message)
		to_chat(src, span_warning("^^^----- The preceding message has been DISCARDED for being over the maximum length of [MAX_MESSAGE_LEN]. It has NOT been sent! -----^^^"))
		return FALSE

	if(stat != CONSCIOUS)
		to_chat(src, span_notice("You cannot send a Do in your current condition."))
		return FALSE

	return TRUE
