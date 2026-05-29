/// Get a specific mob's stat from its stats list.
/mob/living/proc/st_get_stat(stat_path, include_bonus, include_auto_successes)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	return given_stat?.get_score(include_bonus, include_auto_successes)

/// Wrapper for st_get_stat to reduce copypaste. Get a specific mob's stat from its stats list.
/mob/living/proc/st_get_stats(list/stat_list, include_bonus, include_auto_successes)
	var/total_score = 0
	for(var/stat_path in stat_list)
		var/datum/st_stat/given_stat = storyteller_stats[stat_path]
		total_score += given_stat?.get_score(include_bonus, include_auto_successes)
	return total_score

/// Set a specific mob's stat from its stats list.
/mob/living/proc/st_set_stat(stat_path, amount)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	var/score = given_stat?.set_score(amount)
	update_modifiers_from_stats()
	return score

/// Changes a specific mob's stat from its stats list by the given amount.
/mob/living/proc/st_change_stat(stat_path, amount)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	var/score
	if(amount > 0)
		score = given_stat?.increase_score(amount)
	else
		score = given_stat?.decrease_score(amount)
	update_modifiers_from_stats()
	return score

/mob/living/proc/st_add_stat_mod(stat_path, amount, source)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	var/score = given_stat?.add_stat_mod(amount, source)
	update_modifiers_from_stats()
	return score

/mob/living/proc/st_remove_stat_mod(stat_path, source)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	var/score = given_stat?.remove_stat_mod(source)
	update_modifiers_from_stats()
	return score


/mob/living/proc/st_add_auto_successes(stat_path, amount, source)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	var/score = given_stat?.add_auto_successes(amount, source)
	update_modifiers_from_stats()
	return score

/mob/living/proc/st_remove_auto_successes(stat_path, source)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	var/score = given_stat?.remove_auto_successes(source)
	update_modifiers_from_stats()
	return score


/mob/living/proc/update_modifiers_from_stats(initial = FALSE)
	for(var/stat_typepath in storyteller_stats)
		var/datum/st_stat/stat_datum = storyteller_stats[stat_typepath]
		if(stat_datum.stat_flags & AFFECTS_HEALTH)
			recalculate_max_health(initial)
		if(stat_datum.stat_flags & AFFECTS_SPEED)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/dexterity, multiplicative_slowdown = -(st_get_stat(STAT_DEXTERITY) / 20))


/datum/preferences/proc/apply_stats_from_prefs(mob/living/carbon/human/character)
	// TFN EDIT START - attempting to patch the ghost -> respawn stat save exploit
	var/list/stats_copy = list()
	for(var/stat_path in preference_storyteller_stats)
		var/datum/st_stat/source_stat = preference_storyteller_stats[stat_path]
		var/datum/st_stat/new_stat = new stat_path()
		new_stat.set_score(source_stat.get_score(include_bonus = FALSE))
		new_stat.load_points(source_stat.get_points())
		new_stat.freebie_cost_spent = source_stat.freebie_cost_spent
		stats_copy[stat_path] = new_stat
	character.storyteller_stats = stats_copy
	var/morality_pref_type = read_preference(/datum/preference/choiced/vtm_morality)
	if(morality_pref_type)
		var/datum/st_stat/morality_path/morality/pref_morality = preference_storyteller_stats[STAT_MORALITY]
		var/datum/st_stat/morality_path/morality/char_morality = character.storyteller_stats[STAT_MORALITY]
		if(pref_morality && !pref_morality.morality_path)
			pref_morality.morality_path = new morality_pref_type()
		if(char_morality && !char_morality.morality_path)
			char_morality.morality_path = new morality_pref_type(character)
	update_middleware_stats(character.storyteller_stats)
	character.update_modifiers_from_stats(TRUE)
	// TFN EDIT END
