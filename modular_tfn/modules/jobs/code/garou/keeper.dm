/datum/job/vampire/keeper
	title = JOB_GAROU_KEEPER
	description = "You are a Keeper, finding yourself at the bottom of the Sept's hierarchy doing the dirty work. Help out your fellow kin as best you can and follow orders."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = "everyone else in the Sept"
	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 50
	exp_required_type = EXP_TYPE_GAIA
	exp_required_type_department = EXP_TYPE_GAIA
	exp_granted_type = EXP_TYPE_GAIA
	config_tag = "KEEPER"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/keeper

	allowed_splats = list(SPLAT_GAROU, SPLAT_KINFOLK)
//	allowed_tribes = list(TRIBE_GAIA)

	display_order = JOB_DISPLAY_ORDER_KEEPER
	department_for_prefs = /datum/job_department/gaia
	departments_list = list(
		/datum/job_department/gaia,
	)

	known_contacts = list(
		"Councillor",
		"Truthcatcher",
		"Keeper",
		"Guardian"
	)

/datum/outfit/job/vampire/keeper
	name = "Sept Keeper"
	jobtype = /datum/job/vampire/keeper

	id = /obj/item/card/park_ranger
	uniform =  /obj/item/clothing/under/vampire/biker
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/baseballcap
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/jacket
	l_pocket = /obj/item/smartphone
	backpack_contents = list(/obj/item/card/credit=1)
