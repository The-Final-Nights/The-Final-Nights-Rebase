/datum/job/vampire/sheriff
	title = JOB_SHERIFF
	description = "Protect the Prince and the Masquerade. You are their sword."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = /datum/job/vampire/prince
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_PRINCE
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 120
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA
	config_tag = "SHERIFF"

	outfit = /datum/outfit/job/sheriff

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_SHERIFF
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)

	job_flags = CITY_JOB_FLAGS

	minimal_generation = 12
	minimal_masquerade = 5
	allowed_species = list("Vampire")
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_FOLLOWERS_OF_SET, VAMPIRE_CLAN_LASOMBRA)

	known_contacts = list("Prince","Seneschal","Dealer")

/datum/outfit/job/sheriff
	name = "Sheriff"
	jobtype = /datum/job/vampire/sheriff

	//ears = /obj/item/p25radio
	id = /obj/item/card/sheriff
	uniform = /obj/item/clothing/under/vampire/sheriff
	belt = /obj/item/storage/belt/sheath/vamp/rapier
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest
	gloves = /obj/item/clothing/gloves/vampire/leather
	glasses = /obj/item/clothing/glasses/vampire/sun
	r_pocket = /obj/item/vamp/keys/sheriff
	//l_pocket = /obj/item/vamp/phone/sheriff
	//backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle=1, /obj/item/vampire_stake=3, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/masquerade_contract=1, /obj/item/card/credit/elder=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/sheriff/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.ignores_warrant = TRUE

/obj/effect/landmark/start/sheriff
	name = "Sheriff"
	icon_state = "Sheriff"
