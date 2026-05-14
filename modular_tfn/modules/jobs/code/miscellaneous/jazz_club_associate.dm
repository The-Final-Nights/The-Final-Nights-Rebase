/datum/job/vampire/jazz_club_associate
	title = JOB_JAZZ_CLUB_ASSOCIATE
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = /datum/job/vampire/primogen_ventrue
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/jazz_club_associate
	config_tag = "JAZZ_CLUB_ASSOCIATE"
	display_order = JOB_DISPLAY_ORDER_JAZZ
	exp_required_type_department = EXP_TYPE_JAZZ_CLUB
	department_for_prefs = /datum/job_department/jazz_club
	departments_list = list(
		/datum/job_department/jazz_club
	)

	alt_titles = list(
		"Jazz Associate",
		"Jazz Attendant",
		"Jazz Coordinator",
		"Jazz Culinary",
		"Jazz Mixologist",
		"Jazz Performer",
		"Jazz Safety Supervisor"
	)

	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL, SPLAT_KINFOLK, SPLAT_NONE)

	description = "You are employed by the jazz club, providing it's services to the public and it's special clients. You are either clueless, paid well enough not to talk, or bound to secrecy by other means."
	minimal_masquerade = 3

/datum/outfit/job/vampire/jazz_club_associate
	name = "Jazz Club Associate"
	jobtype = /datum/job/vampire/jazz_club_associate
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/jazz
	id = /obj/item/card/jazz_club_associate
	backpack_contents = list(/obj/item/card/credit=1)
	uses_default_clan_clothes = TRUE
