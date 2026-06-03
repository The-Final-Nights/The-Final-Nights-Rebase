/datum/job/vampire/fight_club_worker
	title = JOB_FIGHT_CLUB_WORKER
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = /datum/job/vampire/primogen_brujah
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/fight_club_worker
	config_tag = "FIGHT_CLUB_WORKER"
	display_order = JOB_DISPLAY_ORDER_FIGHT
	exp_required_type_department = EXP_TYPE_FIGHT_CLUB
	department_for_prefs = /datum/job_department/fight_club
	departments_list = list(
		/datum/job_department/fight_club
	)

	alt_titles = list(
		"Fight Club Worker",
		"Personal Trainer",
		"Personal Nutritionist",
		"Gym Janitor",
	)

	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL, SPLAT_KINFOLK, SPLAT_NONE)

	description = "You are employed by the body shop gym, providing it's services to the public."
	minimal_masquerade = 3

/datum/outfit/job/vampire/fight_club_worker
	name = "Body Shop Worker"
	jobtype = /datum/job/vampire/fight_club_worker
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/fight
	id = /obj/item/card/fight_club_worker
	backpack_contents = list(/obj/item/card/credit=1)
	uses_default_clan_clothes = TRUE
