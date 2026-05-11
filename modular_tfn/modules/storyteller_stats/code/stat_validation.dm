/datum/st_stat/proc/get_initial_points()
	SHOULD_NOT_OVERRIDE(TRUE)
	return initial(points)

// prevents people joining with saved stats higher than they could possibly have
/datum/preference_middleware/stats/proc/get_stat_validation_error()
	var/list/stats = preferences.preference_storyteller_stats
	if(!stats || !length(stats))
		return null

	for(var/stat_typepath in stats)
		var/datum/st_stat/stat = stats[stat_typepath]
		if(stat.get_score(include_bonus = FALSE) < stat.min_score || stat.get_score(include_bonus = FALSE) > stat.max_score) // accounts for exploited higher-than-max scores (like 12 strength)
			return "Your character has an invalid '[stat.name]' score of [stat.get_score(include_bonus = FALSE)] (allowed: [stat.min_score]-[stat.max_score]). Please reset your stats."

	var/list/levels_by_abstract = list()
	for(var/stat_typepath in stats)
		var/datum/st_stat/stat = stats[stat_typepath]
		if(!stat.editable || stat.type == stat.abstract_type)
			continue
		var/levels_above = max(0, stat.get_score(include_bonus = FALSE) - stat.starting_score)
		if(!levels_above)
			continue
		if(!(stat.abstract_type in levels_by_abstract))
			levels_by_abstract[stat.abstract_type] = 0
		levels_by_abstract[stat.abstract_type] += levels_above

	var/total_freebie_needed = 0
	for(var/abstract_typepath in levels_by_abstract)
		var/datum/st_stat/abstract_stat = stats[abstract_typepath]
		if(!abstract_stat)
			continue
		var/pool_size = abstract_stat.get_initial_points()
		var/freebie_cost = initial(abstract_stat.freebie_point_cost)
		var/levels_above = levels_by_abstract[abstract_typepath]
		var/overflow = max(0, levels_above - pool_size)
		if(!overflow || !freebie_cost)
			continue
		total_freebie_needed += overflow * freebie_cost

	var/datum/st_stat/freebie/freebie_stat = stats[STAT_FREEBIE_POINTS]
	var/base_freebie = freebie_stat ? freebie_stat.get_initial_points() : 15
	var/quirk_balance = 0
	for(var/quirk_name in preferences.all_quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		if(quirk_type)
			quirk_balance -= quirk_type.value
	var/available_freebie = max(0, base_freebie + quirk_balance)

	if(total_freebie_needed > available_freebie)
		return "Your character's stat allocation exceeds your points budget. Please reset and re-allocate this character's stats and quirks before attempting to join. If you believe your stats to be correct despite this error, screenshot your stats and quirks pages and tag a maintainer in Discord."
	return null

/datum/preferences/proc/validate_stats()
	for(var/datum/preference_middleware/M as anything in middleware)
		if(istype(M, /datum/preference_middleware/stats))
			var/datum/preference_middleware/stats/stats_middleware = M
			return stats_middleware.get_stat_validation_error()
	return null
