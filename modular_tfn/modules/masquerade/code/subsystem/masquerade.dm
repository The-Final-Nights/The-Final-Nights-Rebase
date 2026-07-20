/datum/controller/subsystem/masquerade/get_description()
	var/return_list = ""
	switch(masquerade_level)
		if(0)
			return_list += "MASQUERADE FAILURE: "
		if(1 to 2)
			return_list += "MASSIVE BREACH: "
		if(3 to 5)
			return_list += "MODERATE VIOLATION: "
		if(6 to 8)
			return_list += "SUSPICIOUS: "
		else
			return_list += "STABLE: "
	return_list += "[masquerade_level]/[MASQUERADE_MAX_LEVEL]"
	return return_list

/datum/controller/subsystem/masquerade/masquerade_reinforce(atom/source, mob/living/player_breacher, reason)
	. = FALSE
	for(var/masquerade_breach in masquerade_breachers)
		var/breach_sources = masquerade_breach[2]
		var/breach_reasons = masquerade_breach[3]

		var/source_matches = FALSE
		// breach_sources can be a list if there is more than one blood skull, handle for that
		if(islist(breach_sources))
			source_matches = (source in breach_sources)
		else
			source_matches = (source == breach_sources)

		if(source_matches)
			if(!reason || (reason in masquerade_breach) || (reason == MASQUERADE_REASON_PREFERENCES))
				// Only require blood hunt skull for "Preferences" (round-persistent) breaches
				if(breach_reasons == MASQUERADE_REASON_PREFERENCES && !istype(source, /obj/item/blood_hunt))
					continue

				masquerade_breachers -= list(masquerade_breach)
				masquerade_level = min(MASQUERADE_MAX_LEVEL, masquerade_level + 1)
				player_breacher.masquerade_score = min(2, player_breacher.masquerade_score + 1)
				. = TRUE
				break
	if(player_breacher.masquerade_score == 2) //Doesn't matter if they weren't in one of these lists.
		GLOB.veil_breakers_list -= player_breacher
		GLOB.masquerade_breakers_list -= player_breacher
		GLOB.supernatural_breakers_list -= player_breacher

/datum/controller/subsystem/masquerade/masquerade_breach(atom/source, mob/living/player_breacher, reason)
	log_game("[player_breacher] has caused a masquerade breach in front of [source] by [reason]")
	var/pre_breach_score = player_breacher.masquerade_score
	if(pre_breach_score == 0)
		return
	player_breacher.masquerade_score = max(0, player_breacher.masquerade_score - 1)
	masquerade_breachers += list(list(player_breacher, source, reason))
	if(get_vampire_splat(player_breacher))
		GLOB.masquerade_breakers_list |= player_breacher
		GLOB.supernatural_breakers_list |= player_breacher
	else if(get_werewolf_splat(player_breacher))
		GLOB.veil_breakers_list |= player_breacher
		GLOB.supernatural_breakers_list |= player_breacher
	//Only lower the global masq if the player's breach score is actually reduced by 1
	if(pre_breach_score > player_breacher.masquerade_score)
		masquerade_level = max(0, masquerade_level - 1)

/datum/controller/subsystem/masquerade/matrix_masquerade_breacher(mob/living/player_breacher, update_preferences)
	for(var/masquerade_breach in masquerade_breachers)
		if((player_breacher in masquerade_breach))
			masquerade_breachers -= list(masquerade_breach)
			masquerade_level = min(MASQUERADE_MAX_LEVEL, masquerade_level + 1)
	GLOB.masquerade_breakers_list -= player_breacher
	GLOB.veil_breakers_list -= player_breacher
	GLOB.supernatural_breakers_list -= player_breacher
	if(update_preferences)
		save_persistent_masquerade(player_breacher)

/datum/controller/subsystem/masquerade/masquerade_breacher_check(mob/living/player_breacher)
	if(player_breacher.masquerade_score == 1)
		if(get_vampire_splat(player_breacher))
			GLOB.masquerade_breakers_list |= player_breacher
			GLOB.supernatural_breakers_list |= player_breacher
		else if(get_werewolf_splat(player_breacher))
			GLOB.veil_breakers_list |= player_breacher
			GLOB.supernatural_breakers_list |= player_breacher
	else
		GLOB.masquerade_breakers_list -= player_breacher
		GLOB.veil_breakers_list -= player_breacher
		GLOB.supernatural_breakers_list |= player_breacher
