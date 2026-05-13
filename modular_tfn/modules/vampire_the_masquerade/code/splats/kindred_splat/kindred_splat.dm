/datum/splat/vampire/kindred/on_kindred_death(mob/living/carbon/human/kindred, gibbed)
	if(gibbed)
		return

	var/mob/living/current_mob = kindred.mind
	if(istype(current_mob))
		current_mob.med_hud_set_status()
		SEND_SIGNAL(kindred, COMSIG_LIVING_DNR, src)
	to_chat(kindred, span_boldnotice("You have suffered final death, meaning you cannot re-enter your body even if someone tries to revive it. You are free to observe as a ghost, or respawn and join as another character to keep playing. If you believe this character's death happened without proper escalation, please use the Adminhelp verb in the Admin tab and explain the situation and list the parties involved. If there are no administrators online, you may escalate to a Discord ticket."))
	kindred.mind = null
	kindred.balloon_alert_to_viewers("suffered final death!") // QOL so people don't have to guess
	switch(kindred.chronological_age)
		if(18 to 50)
			return
		if(50 to 100)
			kindred.rot_body(1)
			kindred.visible_message(span_notice("[kindred]'s skin loses some of its colour."))
		if(100 to 150)
			kindred.rot_body(2)
			kindred.visible_message(span_notice("[kindred]'s skin rapidly decays."))
		if(150 to 200)
			kindred.rot_body(3)
			kindred.visible_message(span_warning("[kindred]'s body rapidly decomposes!"))
		if(200 to 250)
			kindred.rot_body(4)
			kindred.visible_message(span_warning("[kindred]'s body rapidly skeletonises!"))
		if(250 to 1000)
			playsound(kindred, 'modular_darkpack/modules/vampire_the_masquerade/sounds/burning_death.ogg', 80, TRUE)
			kindred.dust(just_ash = TRUE, drop_items = TRUE, force = TRUE)
