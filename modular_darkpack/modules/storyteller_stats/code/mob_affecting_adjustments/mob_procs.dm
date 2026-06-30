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

// Procs to relatively easily set all physical/social/mental stats and talents/skills/knowledges without sticking them all into one huge proc.

// STATS

// Sets a mob's physical stats
/mob/living/proc/st_set_physical_stats(strength_amount, dexterity_amount, stamina_amount)
	if(strength_amount)
		st_set_stat(STAT_STRENGTH, strength_amount)
	if(dexterity_amount)
		st_set_stat(STAT_DEXTERITY, dexterity_amount)
	if(stamina_amount)
		st_set_stat(STAT_STAMINA, stamina_amount)

// Sets a mob's social stats
/mob/living/proc/st_set_social_stats(charisma_amount, manipulation_amount, appearance_amount)
	if(charisma_amount)
		st_set_stat(STAT_CHARISMA, charisma_amount)
	if(manipulation_amount)
		st_set_stat(STAT_MANIPULATION, manipulation_amount)
	if(appearance_amount)
		st_set_stat(STAT_APPEARANCE, appearance_amount)

// Sets a mob's mental stats
/mob/living/proc/st_set_mental_stats(perception_amount, intelligence_amount, wits_amount)
	if(perception_amount)
		st_set_stat(STAT_PERCEPTION, perception_amount)
	if(intelligence_amount)
		st_set_stat(STAT_INTELLIGENCE, intelligence_amount)
	if(wits_amount)
		st_set_stat(STAT_WITS, wits_amount)

// TRAITS

/mob/living/proc/st_set_talents_traits(alertness_amount, athletics_amount, awareness_amount, brawl_amount, empathy_amount, expression_amount, intimidation_amount, leadership_amount, streetwise_amount, subterfuge_amount)
	if(alertness_amount)
		st_set_stat(STAT_ALERTNESS, alertness_amount)
	if(athletics_amount)
		st_set_stat(STAT_ATHLETICS, athletics_amount)
	if(awareness_amount)
		st_set_stat(STAT_AWARENESS, awareness_amount)
	if(brawl_amount)
		st_set_stat(STAT_BRAWL, brawl_amount)
	if(empathy_amount)
		st_set_stat(STAT_EMPATHY, empathy_amount)
	if(expression_amount)
		st_set_stat(STAT_EXPRESSION, expression_amount)
	if(intimidation_amount)
		st_set_stat(STAT_INTIMIDATION, intimidation_amount)
	if(leadership_amount)
		st_set_stat(STAT_LEADERSHIP, leadership_amount)
	if(streetwise_amount)
		st_set_stat(STAT_STREETWISE, streetwise_amount)
	if(subterfuge_amount)
		st_set_stat(STAT_SUBTERFUGE, subterfuge_amount)

/mob/living/proc/st_set_skills_traits(animal_ken_amount, crafts_amount, drive_amount, etiquette_amount, firearms_amount, larceny_amount, melee_amount, performance_amount, stealth_amount, survival_amount)
	if(animal_ken_amount)
		st_set_stat(STAT_ANIMAL_KEN, animal_ken_amount)
	if(crafts_amount)
		st_set_stat(STAT_CRAFTS, crafts_amount)
	if(drive_amount)
		st_set_stat(STAT_DRIVE, drive_amount)
	if(etiquette_amount)
		st_set_stat(STAT_ETIQUETTE, etiquette_amount)
	if(firearms_amount)
		st_set_stat(STAT_FIREARMS, firearms_amount)
	if(larceny_amount)
		st_set_stat(STAT_LARCENY, larceny_amount)
	if(melee_amount)
		st_set_stat(STAT_MELEE, melee_amount)
	if(performance_amount)
		st_set_stat(STAT_PERFORMANCE, performance_amount)
	if(stealth_amount)
		st_set_stat(STAT_STEALTH, stealth_amount)
	if(survival_amount)
		st_set_stat(STAT_SURVIVAL, survival_amount)

/mob/living/proc/st_set_knowledges_traits(academics_amount, computer_amount, finance_amount, investigation_amount, law_amount, medicine_amount, occult_amount, politics_amount, science_amount, technology_amount)
	if(academics_amount)
		st_set_stat(STAT_ACADEMICS, academics_amount)
	if(computer_amount)
		st_set_stat(STAT_COMPUTER, computer_amount)
	if(finance_amount)
		st_set_stat(STAT_FINANCE, finance_amount)
	if(investigation_amount)
		st_set_stat(STAT_INVESTIGATION, investigation_amount)
	if(law_amount)
		st_set_stat(STAT_LAW, law_amount)
	if(medicine_amount)
		st_set_stat(STAT_MEDICINE, medicine_amount)
	if(occult_amount)
		st_set_stat(STAT_OCCULT, occult_amount)
	if(politics_amount)
		st_set_stat(STAT_POLITICS, politics_amount)
	if(science_amount)
		st_set_stat(STAT_SCIENCE, science_amount)
	if(technology_amount)
		st_set_stat(STAT_TECHNOLOGY, technology_amount)
