/mob/living
	var/strength = 1
	var/dexterity = 1
	var/social = 1
	var/mentality = 1

	var/additional_strength = 0
	var/additional_dexterity = 0
	var/additional_mentality = 0
	var/additional_social = 0

/mob/living/proc/get_total_strength()
	return strength + additional_strength

/mob/living/proc/get_total_dexterity()
	return dexterity + additional_dexterity

/mob/living/proc/get_total_social()
	return social + additional_social

/mob/living/proc/get_total_mentality()
	return mentality + additional_mentality
