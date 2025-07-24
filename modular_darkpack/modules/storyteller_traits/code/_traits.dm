
/datum/st_trait
	var/name = ""
	var/description = ""
	var/score = 0
	var/bonus_score = 0
	/// A dictionary of modifiers to this attribute.
	var/list/modifiers = list()

/datum/st_trait/proc/get_score(include_bonus = TRUE)
	if(include_bonus)
		return score + bonus_score
	else
		return score

/datum/st_trait/proc/set_score(amount)
	score = amount

/datum/st_trait/proc/update_modifiers()
	SHOULD_NOT_OVERRIDE(TRUE)
	bonus_score = initial(bonus_score)
	for(var/source in modifiers)
		bonus_score += modifiers[source]
	bonus_score = clamp(bonus_score, 0, 10)
