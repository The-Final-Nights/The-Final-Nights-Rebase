/mob/living/proc/getAggLoss()
	return aggloss

/mob/living/proc/can_adjust_agg_loss(amount, forced, required_bodytype)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_LIVING_ADJUST_AGGRAVATED_DAMAGE, AGGRAVATED, amount, forced) & COMPONENT_IGNORE_CHANGE)
		return FALSE
	return TRUE

/mob/living/proc/adjustAggLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(!can_adjust_fire_loss(amount, forced, required_bodytype))
		return 0
	. = aggloss
	aggloss = clamp((aggloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	. -= aggloss
	if(. == 0) // no change, no need to update
		return
	if(updating_health)
		updatehealth()

/mob/living/proc/setAggLoss(amount, updating_health = TRUE, forced = FALSE, required_bodytype = ALL)
	if(!forced && HAS_TRAIT(src, TRAIT_GODMODE))
		return 0
	. = aggloss
	aggloss = amount
	. -= aggloss
	if(. == 0) // no change, no need to update
		return 0
	if(updating_health)
		updatehealth()
