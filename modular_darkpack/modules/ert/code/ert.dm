//Darkpack specific changes to ERTs
/datum/antagonist/ert/darkpack
	var/splat_used = SPLAT_NONE
	var/generation = 13
	var/clan = /datum/subsplat/vampire_clan/ventrue
	var/discipline_dot_rating = 1 //How many dots to give them. Ghouls belonging to low gen Vamps can use 2nd+ dots of disciplines.
	var/extra_bloodpool = 0 //Extra bloodpool capacity. Ghouls belonging to Elders, etc, can store a lot more BP.

/datum/antagonist/ert/darkpack/on_gain()
	. = ..()
	var/mob/living/carbon/human/H = owner.current
	H.clear_splats()
	for (var/datum/quirk/darkpack/quirk_type in H)
		quirk_type.remove_from_current_holder()
	switch(splat_used)
		if(SPLAT_KINDRED)
			H.make_kindred(generation, clan)
			var/datum/subsplat/vampire_clan/selected_clan = new clan
			var/list/clan_disciplines = get_vampire_clan(selected_clan).clan_disciplines
			if(length(clan_disciplines))
				for(var/i in 1 to 3)
					var/discipline = clan_disciplines[i]
					if(!discipline)
						continue
					H.give_st_power(discipline, discipline_dot_rating)
					if(ispath(discipline, /datum/discipline/dementation))
						H.add_quirk(/datum/quirk/darkpack/derangement)
			H.maxbloodpool += extra_bloodpool
			H.adjust_blood_pool(H.maxbloodpool - H.bloodpool)
		if(SPLAT_GHOUL)
			H.make_ghoul()
			var/datum/subsplat/vampire_clan/selected_clan = new clan
			var/list/clan_disciplines = get_vampire_clan(selected_clan).clan_disciplines
			if(length(clan_disciplines))
				for(var/i in 1 to 3)
					var/discipline = clan_disciplines[i]
					if(!discipline)
						continue
					H.give_st_power(discipline, discipline_dot_rating)
					if(ispath(discipline, /datum/discipline/dementation))
						H.add_quirk(/datum/quirk/darkpack/derangement)
			H.maxbloodpool += extra_bloodpool
			H.adjust_blood_pool(H.maxbloodpool - H.bloodpool)
	H.st_set_physical_stats(4, 4, 4) //Pretty much every ERT is very physically fit Strength, Dexterity, Stamina.
	H.st_set_social_stats(2, 2, 2) //Charisma, Manipulation, Appearance
	H.st_set_mental_stats(2, 2, 2) //Perception, Intelligence, Wits
	H.st_set_talents_traits(1, 4, 2, 3, 1, 1, 3, 1, 1, 1) //Alertness, Athletics, Awareness, Brawl, Empathy, Expression, Intimidation, Leadership, Streetwise, Subterfuge
	H.st_set_skills_traits(1, 2, 4, 2, 4, 3, 3, 1, 1, 1) //Animal Ken, Crafts, Drive, Etiquette, Firearms, Larceny, Melee, Performance, Stealth, Survival
	H.st_set_knowledges_traits(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) //Academics, Computer, Finance, Investigation, Law, Medicine, Occult, Politics, Science, Technology
	H.st_set_stat(STAT_COURAGE, 3)
	H.st_set_stat(STAT_CONSCIENCE, 3)
	H.st_set_stat(STAT_SELF_CONTROL, 3)
	H.st_set_stat(STAT_MORALITY, 7)
	H.st_set_stat(STAT_PERMANENT_WILLPOWER, 6)
	H.st_set_stat(STAT_TEMPORARY_WILLPOWER, 6)

