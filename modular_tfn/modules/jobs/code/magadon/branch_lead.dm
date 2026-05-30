/datum/job/vampire/branch_lead
	title = JOB_PENTEX_LEAD
	description = "You are the current branch leader for " + EVIL_PHARMA_COMPANY + " , operating out of San Francisco. Your job is to fuel production and keep your clowns in line."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	faction = FACTION_PENTEX
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Board"
	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 180
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL
	config_tag = "PENTEX_BRANCH_LEAD"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/branch_lead

	alt_titles = list(
		"Magadon Branch Lead",
		"Magadon Branch Director",
		"Magadon Regional Director",
		"Magadon Operations Director"
	)

	minimal_masquerade = 5
	// minimal_renown_rank = 4
	allowed_tribes = list(TRIBE_BLACK_SPIRAL_DANCERS, TRIBE_FORSWORN) // TFN EDIT CHANGE - Original: allowed_tribes = list(TRIBE_BLACK_SPIRAL_DANCERS, TRIBE_RONIN)
	display_order = JOB_DISPLAY_ORDER_BRANCH_LEAD
	department_for_prefs = /datum/job_department/pentex
	departments_list = list(
		/datum/job_department/pentex,
	)

	known_contacts = list(
		JOB_PENTEX_EXEC,
		JOB_PENTEX_AFFAIRS,
		JOB_PENTEX_SEC_CHIEF
	)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

/datum/outfit/job/vampire/branch_lead
	name = EVIL_PHARMA_COMPANY + " Branch Lead"
	jobtype = /datum/job/vampire/branch_lead

//	ears = /obj/item/p25radio
	id = /obj/item/card/pentex/branch_lead
	uniform =  /obj/item/clothing/under/vampire/magadon_executivesuit
	shoes = /obj/item/clothing/shoes/vampire/businessblack
	suit = /obj/item/clothing/suit/vampire/magadon_labcoat
	l_pocket = /obj/item/smartphone/magadon_lead
	r_pocket = /obj/item/vamp/keys/pentex/leader
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle=1, /obj/item/phone_book=1, /obj/item/card/credit/prince=1)
