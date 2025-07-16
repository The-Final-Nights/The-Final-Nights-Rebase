/mob/living
	var/blood = 1

	var/additional_blood = 0


	var/more_companions = 0
	var/melee_professional = FALSE

/mob/living/proc/get_total_blood()
	return blood + additional_blood
