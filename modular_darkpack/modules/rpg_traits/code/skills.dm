/mob/living
	var/lockpicking = 0
	var/athletics = 0

	var/additional_lockpicking = 0
	var/additional_athletics = 0

/mob/living/proc/get_total_lockpicking()
	return lockpicking + additional_lockpicking

/mob/living/proc/get_total_athletics()
	return athletics + additional_athletics
