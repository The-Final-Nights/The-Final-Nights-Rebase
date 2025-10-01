/datum/job/vamp/primogen_malkavian
	title = JOB_PRIMOGEN_MALKAVIAN
	description = "Offer your infinite knowledge to Prince of the City. You likely have a hold over the local hospital, make good use of it and ensure the blood bags remain available."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Justicar")
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_TRADITIONS
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA
	config_tag = "PRIMOGEN_MALKAVIAN"

	outfit = /datum/outfit/job/malkav

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_MALKAVIAN
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)

	job_flags = CITY_JOB_FLAGS

	minimal_generation = 12
	minimum_vampire_age = 5 // Actually Malkavian Primo is whoever showed for work that day. Crazy bunch.
	minimal_masquerade = 5
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_MALKAVIAN)

	known_contacts = list("Prince")

/datum/outfit/job/malkav
	name = "Primogen Malkavian"
	jobtype = /datum/job/vamp/primogen_malkavian

	//ears = /obj/item/p25radio
	id = /obj/item/card/primogen
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/primogen_malkavian
	suit = /obj/item/clothing/suit/vampire/trench/malkav
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/malkav
	//l_pocket = /obj/item/vamp/phone/malkavian_primo
	r_pocket = /obj/item/cockclock
	//backpack_contents = list(/obj/item/vamp/keys/malkav/primogen=1, /obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/elder=1, /obj/item/card/id/whip, /obj/item/card/id/steward, /obj/item/card/id/myrmidon)
