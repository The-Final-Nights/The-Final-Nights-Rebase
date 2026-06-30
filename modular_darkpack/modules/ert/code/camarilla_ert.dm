/datum/antagonist/ert/darkpack/camarilla_ert/leader
	name = "Whiterock Private Security Officer"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/leader
	role = "Whiterock Private Security Officer"
	splat_used = SPLAT_KINDRED
	generation = 8
	discipline_dot_rating = 5
	var/rand_clan = pick(VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_VENTRUE)//High clans only.
	clan = rand_clan

/datum/antagonist/ert/darkpack/camarilla_ert/medic
	name = "Whiterock Private Security Medic"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/medic
	role = "Whiterock Private Security Medic"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 2
	var/rand_clan = pick(VAMPIRE_CLAN_BANU_HAQIM_VIZIER, VAMPIRE_CLAN_MALKAVIAN)
	clan = rand_clan

/datum/antagonist/ert/darkpack/camarilla_ert/rifleman
	name = "Whiterock Private Security Rifleman"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/rifleman
	role = "Whiterock Private Security Rifleman"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 2
	var/rand_clan = pick(VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_NOSFERATU)
	clan = rand_clan

/datum/antagonist/ert/darkpack/camarilla_ert/melee
	name = "Whiterock Private Security CQB"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/melee
	role = "Whiterock Private Security CQB"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 2
	var/rand_clan = pick(VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_GANGREL)
	clan = rand_clan

/datum/antagonist/ert/darkpack/camarilla_ert/marksman
	name = "Whiterock Private Security Marksman"
	outfit = /datum/outfit/job/vampire/ert/camarilla_ert/marksman
	role = "Whiterock Private Security Marksman"
	splat_used = SPLAT_GHOUL
	discipline_dot_rating = 2
	clan = VAMPIRE_CLAN_BANU_HAQIM_VIZIER
