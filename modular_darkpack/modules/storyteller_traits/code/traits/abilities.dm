/mob/living
	var/lockpicking = 0
	var/athletics = 0

	var/additional_lockpicking = 0
	var/additional_athletics = 0

/mob/living/proc/trait_holder.get_stat(ST_TRAIT_ATHLETICS)
	return athletics + additional_athletics

// Talents
/datum/st_trait/ability/athletics

// Skills
/datum/st_trait/ability/firearms

/datum/st_trait/ability/lockpicking

/datum/st_trait/ability/melee

//Knowledges
