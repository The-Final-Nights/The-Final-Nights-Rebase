
/datum/splat/vampire/ghoul/on_lose_or_destroy()
	owner.remove_st_power(/datum/discipline/bloodheal)
	owner.remove_st_power(/datum/discipline/potence)

