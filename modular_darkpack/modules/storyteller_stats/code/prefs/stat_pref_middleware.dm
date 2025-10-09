/datum/preference_middleware/stats
	var/tainted = FALSE

/datum/preference_middleware/stats/get_ui_static_data(mob/user)
	var/list/data = list()
	data["staticStats"] = list()
	for(var/datum/st_stat/stat in GLOB.public_storyteller_stats)
		var/list/stat_data = list()
		stat_data["name"] = stat.name
		stat_data["desc"] = stat.description
		stat_data["category"] = stat.category
		stat_data["maxScore"] = stat.max_score
		data["staticStats"][stat.type] = stat_data
	return data

/datum/preference_middleware/stats/get_ui_data(mob/user)
	var/list/data = list()
	//if (tainted)
	//	tainted = FALSE
	data["stats"] = preferences.storyteller_stats
	return data
