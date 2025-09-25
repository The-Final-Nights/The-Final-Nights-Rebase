/datum/job/vampire/hound
	title = JOB_HOUND
	description = "You are the Prince's enforcer. You report to the Sheriff and uphold the Traditions."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = /datum/job/vampire/sheriff
	faction = FACTION_CITY
	total_positions = 7
	spawn_positions = 7
	supervisors = SUPERVISOR_SHERIFF

	minimal_player_age = 7
	exp_requirements = 20
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA
	config_tag = "HOUND"

	outfit = /datum/outfit/job/hound

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_HOUND
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)


	minimal_masquerade = 3
	allowed_species = list("Vampire", "Ghoul")
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_FOLLOWERS_OF_SET, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_CAPPADOCIAN)

	known_contacts = list("Prince", "Sheriff")

/datum/outfit/job/hound
	name = "Hound"
	jobtype = /datum/job/vampire/hound

	//ears = /obj/item/p25radio
	id = /obj/item/card/camarilla
	uniform = /obj/item/clothing/under/vampire/hound
	gloves = /obj/item/clothing/gloves/vampire/work
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	r_pocket = /obj/item/vamp/keys/camarilla
	//l_pocket = /obj/item/vamp/phone/camarilla
	//backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/vampire_stake=3, /obj/item/flashlight=1, /obj/item/masquerade_contract=1, /obj/item/vamp/keys/hack=1, /obj/item/card/credit=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/obj/effect/landmark/start/hound
	name = "Hound"
	icon_state = "Hound"
