/datum/st_stat/proc/get_initial_points()
	SHOULD_NOT_OVERRIDE(TRUE)
	return initial(points)

// prevents people joining with saved stats higher than they could possibly have
/datum/preference_middleware/stats/proc/get_stat_validation_error()
	var/list/stats = preferences.preference_storyteller_stats
	if(!stats || !length(stats))
		return null

	var/list/score_violations = list()
	for(var/stat_typepath in stats)
		var/datum/st_stat/stat = stats[stat_typepath]
		var/score = stat.get_score(include_bonus = FALSE)
		if(score < stat.min_score || score > stat.max_score)
			score_violations += "[stat.name]: [score] (allowed [stat.min_score] to [stat.max_score])"

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

	var/list/budget_violations = list()
	var/total_freebie_needed = 0
	for(var/abstract_typepath in levels_by_abstract)
		var/datum/st_stat/abstract_stat = stats[abstract_typepath]
		if(!abstract_stat)
			continue
		var/pool_size = abstract_stat.get_initial_points()
		var/freebie_cost = initial(abstract_stat.freebie_point_cost)
		var/levels_above = levels_by_abstract[abstract_typepath]
		var/overflow = max(0, levels_above - pool_size)
		if(!overflow || !freebie_cost || !abstract_stat.name)
			continue
		budget_violations += "[abstract_stat.name]: [levels_above] spent, budget is [pool_size] ([overflow] over)"
		total_freebie_needed += overflow * freebie_cost

	var/datum/st_stat/freebie/freebie_stat = stats[STAT_FREEBIE_POINTS]
	var/base_freebie = freebie_stat ? freebie_stat.get_initial_points() : 15
	var/quirk_balance = 0
	for(var/quirk_name in preferences.all_quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		if(quirk_type)
			quirk_balance -= quirk_type.value
	var/available_freebie = max(0, base_freebie + quirk_balance)
	var/freebie_short = total_freebie_needed - available_freebie

	if(!length(score_violations) && freebie_short <= 0)
		return null

	var/msg = "HEY, LISTEN! Your character's stats are invalid! Please matrix out to the character selection screen and fix the following issues:\n"
	if(length(score_violations))
		msg += "\nStat scores out of range:\n"
		for(var/v in score_violations)
			msg += "  [v]\n"
	if(length(budget_violations))
		msg += "\nCategories over budget:\n"
		for(var/v in budget_violations)
			msg += "  [v]\n"
	if(freebie_short > 0)
		msg += "\nFreebie points: need [total_freebie_needed], have [available_freebie] ([freebie_short] short of what is needed to be valid)\n"
	return msg

/datum/preferences/proc/validate_stats()
	for(var/datum/preference_middleware/M as anything in middleware)
		if(istype(M, /datum/preference_middleware/stats))
			var/datum/preference_middleware/stats/stats_middleware = M
			return stats_middleware.get_stat_validation_error()
	return null
