GLOBAL_LIST_INIT(public_storyteller_stats, init_storyteller_stats())

/proc/init_storyteller_stats()
	var/list/stat_list = list()
	for(var/datum/st_stat/path as anything in subtypesof(/datum/st_stat))
		if(path == path.abstract_type)
			continue
		var/datum/st_stat/new_trait = new path
		stat_list[path] = new_trait
	return stat_list
