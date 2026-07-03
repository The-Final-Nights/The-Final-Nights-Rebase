/datum/antagonist/ert/darkpack/camarilla_ert/leader
	name = "Whiterock Private Security Officer"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/leader
	role = "Whiterock Private Security Officer"
	splat_used = SPLAT_KINDRED
	generation = 7 //No issues currently as you can't actually lower your generation below 8 via Diablerie.
	discipline_dot_rating = 5
	clan = /datum/subsplat/vampire_clan/brujah

/datum/antagonist/ert/darkpack/camarilla_ert/medic
	name = "Whiterock Private Security Medic"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/medic
	role = "Whiterock Private Security Medic"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 3
	clan = /datum/subsplat/vampire_clan/malkavian
	extra_bloodpool = 5

/datum/antagonist/ert/darkpack/camarilla_ert/rifleman
	name = "Whiterock Private Security Rifleman"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/rifleman
	role = "Whiterock Private Security Rifleman"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 3
	clan = /datum/subsplat/vampire_clan/gangrel/city
	extra_bloodpool = 5

/datum/antagonist/ert/darkpack/camarilla_ert/melee
	name = "Whiterock Private Security CQB"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/melee
	role = "Whiterock Private Security CQB"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 3
	clan = /datum/subsplat/vampire_clan/brujah
	extra_bloodpool = 5

/datum/antagonist/ert/darkpack/camarilla_ert/marksman
	name = "Whiterock Private Security Marksman"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/marksman
	role = "Whiterock Private Security Marksman"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 3
	clan = /datum/subsplat/vampire_clan/banu_haqim
	extra_bloodpool = 5

/datum/antagonist/ert/darkpack/camarilla_ert/on_gain()
	. = ..()
	var/mob/living/carbon/human/H = owner.current
	H.st_set_physical_stats(6, 6, 6, TRUE) //Sculpting the Perfect Servant? In my Camarilla? It's more likely than you'd think!
	H.st_set_talents_traits(athletics_amount = 6, brawl_amount = 6, ignore_limits = TRUE) //Alertness, Athletics, Awareness, Brawl, Empathy, Expression, Intimidation, Leadership, Streetwise, Subterfuge
	H.st_set_skills_traits(firearms_amount = 6, larceny_amount = 6, melee_amount = 6, ignore_limits = TRUE)
	
/datum/antagonist/ert/darkpack/camarilla_ert/leader/on_gain()
	. = ..()
	var/mob/living/carbon/human/H = owner.current
	H.give_st_power(/datum/discipline/fortitude, 5)
	H.st_set_physical_stats(7, 7, 7, TRUE) //No 6th dots for Cel, Pot, and Fort currently, so treating it as 1 dot higher than it is to compensate.
	H.st_set_social_stats(6, 6, 6, TRUE)
	H.st_set_talents_traits(empathy_amount = 6, intimidation_amount = 6, subterfuge_amount = 6, ignore_limits = TRUE)
	H.st_set_skills_traits(performance_amount = 6, survival_amount = 6, ignore_limits = TRUE)
	H.AddElement(/datum/element/wall_smasher, ENVIRONMENT_SMASH_WALLS) //Potence 6.
	H.st_set_stat(STAT_PERMANENT_WILLPOWER, 8)
	H.st_set_stat(STAT_TEMPORARY_WILLPOWER, 8)

/datum/antagonist/ert/darkpack/camarilla_ert/medic/on_gain()
	. = ..()
	var/mob/living/carbon/human/H = owner.current
	var/obj/item/organ/cyberimp/brain/surgical_processor/pre_loaded/surgery = new()
	surgery.Insert(H)

/datum/antagonist/ert/darkpack/camarilla_ert/melee/on_gain()
	. = ..()
	var/mob/living/carbon/human/H = owner.current
	H.st_set_physical_stats(8, 6, 6, TRUE) //Ghoul hopped up on SO MANY combat drugs.
	H.st_set_talents_traits(brawl_amount = 8, ignore_limits = TRUE) //Alertness, Athletics, Awareness, Brawl, Empathy, Expression, Intimidation, Leadership, Streetwise, Subterfuge
	H.st_set_skills_traits(firearms_amount = 3,melee_amount = 8, ignore_limits = TRUE) //Animal Ken, Crafts, Drive, Etiquette, Firearms, Larceny, Melee, Performance, Stealth, Survival
	H.AddElement(/datum/element/wall_smasher, ENVIRONMENT_SMASH_STRUCTURES)
	H.give_st_power(/datum/discipline/fortitude, 3)
	var/obj/item/organ/cyberimp/brain/anti_drop/drop = new()
	drop.Insert(H)
