/datum/preference_middleware/stats
	var/tainted = FALSE

/*
/datum/preference_middleware/stats/get_ui_static_data(mob/user)
	if (preferences.current_window != PREFERENCE_TAB_CHARACTER_PREFERENCES)
		return list()
*/

/datum/preference_middleware/stats/get_ui_data(mob/user)
	var/list/data = list()
	//if (tainted)
	//	tainted = FALSE
	data["stats"] = preferences.storyteller_stats
	return data
