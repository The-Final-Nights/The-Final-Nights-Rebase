// TFN EDIT START
/datum/preference_middleware/stats/proc/ensure_morality_path()
	var/datum/st_stat/morality_path/morality/stat_morality = preferences.preference_storyteller_stats[STAT_MORALITY]
	if(stat_morality && !stat_morality.morality_path)
		var/morality_type = preferences.read_preference(/datum/preference/choiced/vtm_morality)
		if(morality_type)
			stat_morality.morality_path = new morality_type()
// TFN EDIT END

/datum/preference_middleware/stats
	action_delegations = list(
		"increase_stat" = PROC_REF(increase_stat),
		"decrease_stat" = PROC_REF(decrease_stat),
		"reset_stats" = PROC_REF(reset_stats)
	)

/datum/preference_middleware/stats/get_ui_data(mob/user)
	if(preferences.current_window != PREFERENCE_TAB_CHARACTER_PREFERENCES)
		return list()
	var/list/data = list()
	data["stats"] = list()
	for(var/typepath in preferences.preference_storyteller_stats)
		var/datum/st_stat/stat = preferences.preference_storyteller_stats[typepath]
		var/list/stat_data = list()
		stat_data["name"] = stat.name
		stat_data["desc"] = stat.description
		stat_data["editable"] = stat.editable
		stat_data["category"] = stat.category
		stat_data["subcategory"] = stat.subcategory
		stat_data["max_score"] = stat.max_score
		// TFN EDIT START
		if(stat.type == stat.abstract_type && !istype(stat, /datum/st_stat/freebie))
			var/initial = stat.get_initial_points()
			var/category_spent = 0
			for(var/sub_path in preferences.preference_storyteller_stats)
				var/datum/st_stat/sub_stat = preferences.preference_storyteller_stats[sub_path]
				if(sub_stat.abstract_type != stat.type || sub_stat.type == stat.type || !sub_stat.editable)
					continue
				var/levels_above = max(0, sub_stat.get_score(include_bonus = FALSE) - sub_stat.starting_score)
				var/freebie_levels = sub_stat.freebie_point_cost > 0 ? (sub_stat.freebie_cost_spent / sub_stat.freebie_point_cost) : 0
				category_spent += max(0, levels_above - freebie_levels)
			stat_data["points"] = initial - category_spent
		else
			stat_data["points"] = stat.get_points()
		stat_data["max_points"] = istype(stat, /datum/st_stat/freebie) ? (stat.get_points() + stat.freebie_cost_spent) : stat.get_initial_points()
		// TFN EDIT END
		stat_data["score"] = stat.get_score(include_bonus = FALSE)
		stat_data["bonus_score"] = max(stat.get_bonus_score(), 0) // Dont go below 0 as this is to display bonuses and doesnt have handling for negative bonus score atm
		stat_data["abstract_type"] = "[stat.abstract_type]"
		data["stats"]["[stat.type]"] = stat_data
	return data

/datum/preference_middleware/stats/proc/increase_stat(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)
	// TFN EDIT START
	/*
	if("[user.client.prefs.default_slot]" in user.persistent_client.joined_as_slots)
		to_chat(user, span_warning("You cannot be spawned in as this character to adjust its stats."))
		return FALSE
	*/
	// TFN EDIT END
	var/datum/st_stat/stat_path = preferences.preference_storyteller_stats[text2path(params["stat"])]
	var/datum/st_stat/abstract_stat = preferences.preference_storyteller_stats[stat_path.abstract_type]
	var/datum/st_stat/freebie_point_stat = preferences.preference_storyteller_stats[STAT_FREEBIE_POINTS]
	var/old_value = stat_path.get_score(include_bonus = FALSE)


	if(!stat_path.can_increase_score(1)) // Have we reached the max_score of the stat?
		return FALSE // If we have, then return early.

	if((stat_path.get_score(include_bonus = FALSE) + 1) > stat_path.starting_score)
		if(abstract_stat.can_decrease_points(1)) // Can we spend points on this stat?
			abstract_stat.decrease_points(1) // Spend a point.
		else
			if(freebie_point_stat.can_decrease_freebie_points(stat_path.freebie_point_cost)) // Can we spend freebie points instead?
				freebie_point_stat.decrease_freebie_points(stat_path.freebie_point_cost) // If we can spend freebie points, decrease them.
				stat_path.freebie_cost_spent += stat_path.freebie_point_cost // TFN EDIT
			else
				return FALSE // If we can't spend freebie points, then return early.

	stat_path.increase_score(1) // By this point we know we have spend either a point, or the appropriate freebie cost for this stat, and it is not max_score. So increase it by one.

	if(stat_path.stat_flags & AFFECTS_STATS)
		ensure_morality_path() // TFN EDIT
		update_middleware_stats(preferences.preference_storyteller_stats)


	var/new_value = stat_path.get_score(include_bonus = FALSE)
	var/real_name = user.client.prefs.read_preference(/datum/preference/name/real_name)
	user.log_message("increased stat '[stat_path.name]' from [old_value] to [new_value] on [real_name]", LOG_STATS)
	return TRUE

/datum/preference_middleware/stats/proc/decrease_stat(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)

	if(!isnewplayer(user))
		to_chat(user, span_warning("You have to be in the main menu to adjust your stats."))
		return FALSE

	var/datum/st_stat/stat_path = preferences.preference_storyteller_stats[text2path(params["stat"])]
	var/datum/st_stat/abstract_stat = preferences.preference_storyteller_stats[stat_path.abstract_type]
	var/datum/st_stat/freebie_point_stat = preferences.preference_storyteller_stats[STAT_FREEBIE_POINTS]
	var/old_value = stat_path.get_score(include_bonus = FALSE)

	if(!stat_path.can_decrease_score(1))
		return FALSE
	// TFN EDIT START
	if((stat_path.get_score(include_bonus = FALSE) - 1) >= stat_path.starting_score)
		if(stat_path.freebie_cost_spent > 0) // Was freebie spent on this specific stat? Refund it.
			freebie_point_stat.increase_freebie_points(stat_path.freebie_point_cost)
			stat_path.freebie_cost_spent -= stat_path.freebie_point_cost
		else
			abstract_stat.increase_points(1) // No freebie spent here; refund to category pool.
	// TFN EDIT END
	stat_path.decrease_score(1) // By this point we know we have regained either a point, or the appropriate freebie cost for this stat, and it is not min_score. So decrease it by one.

	if(stat_path.stat_flags & AFFECTS_STATS)
		ensure_morality_path() // TFN EDIT
		update_middleware_stats(preferences.preference_storyteller_stats)

	var/new_value = stat_path.get_score(include_bonus = FALSE)
	var/real_name = user.client.prefs.read_preference(/datum/preference/name/real_name)
	user.log_message("decreased stat '[stat_path.name]' from [old_value] to [new_value] on '[real_name]'", LOG_STATS)
	return TRUE

/datum/preference_middleware/stats/proc/reset_stats(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)

	if(!isnewplayer(user))
		to_chat(user, span_warning("You have to be in the main menu to adjust your stats."))
		return FALSE

	var/real_name = user.client.prefs.read_preference(/datum/preference/name/real_name)
	user.log_message("reset all stats to default values on '[real_name]'", LOG_STATS)

	preferences.preference_storyteller_stats = list()
	preferences.preference_storyteller_stats = create_new_stat_prefs(preferences.preference_storyteller_stats)
	return TRUE
