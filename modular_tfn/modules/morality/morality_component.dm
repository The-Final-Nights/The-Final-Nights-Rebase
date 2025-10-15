/datum/component/morality
	// TODO: Put SOMETHING here?

/datum/component/morality/Initialize()
	if(!iskindred(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_PATH_HIT, PROC_REF(adjust_morality))

/datum/component/morality/proc/adjust_morality(datum/source, type, limit)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/kindred = parent

	if(!iskindred(kindred))
		return
	if(!GLOB.canon_event)
		return
	/*
	if(is_special_character(kindred))
		return
	if(kindred.in_frenzy)
		return
	*/

	// Just call AdjustHumanity - let it handle all the logic
	kindred.AdjustHumanity(type, limit, FALSE)
