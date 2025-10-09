SUBSYSTEM_DEF(stats)
	name = "Storyteller Stats"
	flags = SS_NO_FIRE
	// A list of every stat, indexed by its type.
	var/list/public_datums = list()

/datum/controller/subsystem/stats/Initialize()
	for(var/datum/st_stat/path as anything in subtypesof(/datum/st_stat))
		if(path == path.abstract_type)
			continue
		var/datum/st_stat/new_trait = new path
		public_datums[path] = new_trait

	return SS_INIT_SUCCESS

/datum/controller/subsystem/stats/proc/sanitize_stat_list(passed_stats)
	var/new_list = list()
	for(var/stat_path in public_datums)
		var/datum/st_stat/stat = public_datums[stat_path]
		var/score = stat.get_score(FALSE)
		if(stat_path in passed_stats)
			score = passed_stats[stat_path]
		new_list[stat_path] = score
	return new_list

/datum/controller/subsystem/stats/proc/apply_stats_from_prefs(mob/living/user, client/applied_client)
	for(var/stat_path in applied_client.prefs.storyteller_stats)
		user.storyteller_stat_holder.set_stat(stat_path, applied_client.prefs.storyteller_stats[stat_path])
