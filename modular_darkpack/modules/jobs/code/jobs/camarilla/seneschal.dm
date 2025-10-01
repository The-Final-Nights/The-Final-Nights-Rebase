/datum/job/vampire/clerk
	title = "Seneschal"
	description = "You are the right hand man or woman of the most powerful vampire in the city. The Camarilla trusts you to run the city, even in their stead."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = /datum/job/vampire/prince
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_PRINCE
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA
	config_tag = "SENESCHAL"

	outfit = /datum/outfit/job/clerk

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_CLERK
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)

	job_flags = CITY_JOB_FLAGS

	minimal_generation = 12
	minimal_masquerade = 5
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_FOLLOWERS_OF_SET, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_KIASYD)

	known_contacts = list("Prince","Sheriff","Tremere Regent","Dealer","Primogens")

/datum/outfit/job/clerk
	name = "Seneschal"
	jobtype = /datum/job/vampire/clerk

	//ears = /obj/item/p25radio
	id = /obj/item/card/clerk
	uniform = /obj/item/clothing/under/vampire/clerk
	shoes = /obj/item/clothing/shoes/vampire/brown
	//l_pocket = /obj/item/vamp/phone/clerk
	r_pocket = /obj/item/vamp/keys/clerk
	//backpack_contents = list(/obj/item/passport=1, /obj/item/phone_book=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit/seneschal=1)

/obj/effect/landmark/start/clerk
	name = "Seneschal"
	icon_state = "Clerk"
