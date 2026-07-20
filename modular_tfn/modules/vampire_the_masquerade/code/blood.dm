/mob/living/carbon/human/adjust_blood_volume(amount, minimum = 0, maximum = BLOOD_VOLUME_MAXIMUM)
	var/old_volume = blood_volume
	. = ..()
	if(amount <= 0 || get_kindred_splat(src) || bloodpool >= maxbloodpool)
		return
	var/pool_per_volume = BLOOD_VOLUME_NORMAL / maxbloodpool
	var/old_expected = round(min(old_volume, BLOOD_VOLUME_NORMAL) / pool_per_volume)
	var/new_expected = round(min(blood_volume, BLOOD_VOLUME_NORMAL) / pool_per_volume)
	var/pool_delta = clamp(new_expected - old_expected, 0, maxbloodpool - bloodpool)
	if(pool_delta > 0)
		adjust_blood_pool(pool_delta)

/mob/living/carbon/human/proc/update_bloodquality_from_appearance()
	bloodquality = clamp(st_get_stat(STAT_APPEARANCE), bloodquality, BLOOD_QUALITY_HIGH)

/datum/preferences/apply_stats_from_prefs(mob/living/carbon/human/character)
	. = ..()
	character.update_bloodquality_from_appearance()
