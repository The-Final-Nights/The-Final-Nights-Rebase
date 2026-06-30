//Darkpack specific changes to ERTs 
/datum/antagonist/ert/darkpack
	var/splat_used = SPLAT_NONE
	var/generation = 13
	var/clan = /datum/subsplat/vampire_clan/ventrue
	var/discipline_dot_rating = 1 //How many dots to give them. Ghouls belonging to low gen Vamps can use 2nd+ dots of disciplines.

/datum/antagonist/ert/darkpack/on_gain()
	. = ..()
	clear_splats()
	for (var/datum/quirk/darkpack/quirk_type in owner)
		quirk_type.remove_from_current_holder()
	switch(splat_used)
		if(SPLAT_KINDRED)
			owner.make_kindred(generation, clan)
			var/list/clan_disciplines = clan.clan_disciplines
			if(length(clan_disciplines))
				for(var/i in 1 to 3)
					var/discipline = clan_disciplines[i]
					if(!discipline)
						continue
					owner.give_st_power(discipline, discipline_dot_rating)
					if(ispath(discipline, /datum/discipline/dementation))
						owner.add_quirk(/datum/quirk/darkpack/derangement)
		if(SPLAT_GHOUL)
			owner.make_ghoul()
			var/list/clan_disciplines = clan.clan_disciplines
			if(length(clan_disciplines))
				for(var/i in 1 to 3)
					var/discipline = clan_disciplines[i]
					if(!discipline)
						continue
					owner.give_st_power(discipline, discipline_dot_rating)
					if(ispath(discipline, /datum/discipline/dementation))
						owner.add_quirk(/datum/quirk/darkpack/derangement)
		owner.st_set_physical_stats(strength_amount = 4, dexterity_amount = 4, stamina_amount = 4) //Pretty much every ERT is very physically fit. Keeping the full names of the values here to ease understanding and changes.
		owner.st_set_social_stats(charisma_amount = 2, manipulation_amount = 2, appearance_amount = 2)
		owner.st_set_mental_stats(perception_amount = 2, intelligence_amount = 2, wits_amount = 2)
		owner.st_set_talents_traits(alertness_amount = 1, athletics_amount = 4, awareness_amount = 2, brawl_amount = 3, empathy_amount = 1, expression_amount = 1, intimidation_amount = 1, leadership_amount = 1, streetwise_amount = 1, subterfuge_amount = 1)
		owner.st_set_skills_traits(animal_ken_amount = 1, crafts_amount = 2, drive_amount = 2, etiquette_amount = 2, firearms_amount = 4, larceny_amount = 3, melee_amount = 3, performance_amount = 1, stealth_amount = 1, survival_amount = 1)
		owner.st_set_knowledges_traits(academics_amount = 1, computer_amount = 1, finance_amount = 1, investigation_amount = 1, law_amount = 1, medicine_amount = 1, occult_amount = 1, politics_amount = 1, science_amount = 1, technology_amount = 1)
		owner.st_set_stat(STAT_COURAGE, 3)
		owner.st_set_stat(STAT_CONSCIENCE, 3)
		owner.st_set_stat(STAT_SELF_CONTROL, 3)
		owner.st_set_stat(STAT_MORALITY, 7)
		owner.st_set_stat(STAT_PERMANENT_WILLPOWER, 6)
		owner.st_set_stat(STAT_TEMPORARY_WILLPOWER, 6)
