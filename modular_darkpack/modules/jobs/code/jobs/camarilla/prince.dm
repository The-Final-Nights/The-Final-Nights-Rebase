/datum/job/prince
	title = JOB_PRINCE
	description = "You are the top dog of this city. You hold Praxis over San Francisco, and your word is law. Make sure the Masquerade is upheld, and your status is respected."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Justicar")
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Camarilla and the Traditions"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA
	config_tag = "PRINCE"

	outfit = /datum/outfit/job/prince

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_PRINCE
	department_for_prefs = /datum/job_department/prince
	departments_list = list(
		/datum/job_department/camarilla,
	)

	job_flags = CITY_JOB_FLAGS

	minimal_generation = 10
	minimum_vampire_age = 75
	minimal_masquerade = 5
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_BANU_HAQIM)

	known_contacts = list(
		"Sheriff",
		"Seneschal",
		"Dealer",
		"Tremere Regent",
		"Primogens",
		"Baron",
		"Voivode"
	)

/datum/job/prince/get_captaincy_announcement(mob/living/captain)
	return "Prince [captain.real_name] is in the city!"

/datum/outfit/job/prince
	name = "Prince"
	jobtype = /datum/job/prince

	//ears = /obj/item/p25radio
	id = /obj/item/card/prince
	glasses = /obj/item/clothing/glasses/vampire/sun
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform =  /obj/item/clothing/under/vampire/prince
	suit = /obj/item/clothing/suit/vampire/trench/alt
	shoes = /obj/item/clothing/shoes/vampire
	//l_pocket = /obj/item/vamp/phone/prince
	r_pocket = /obj/item/vamp/keys/prince
	//backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle=1, /obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/masquerade_contract=1, /obj/item/card/credit/prince=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/prince/pre_equip(mob/living/carbon/human/H)
	..()
	H.ignores_warrant = TRUE
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/prince/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/prince
	name = "Prince"
	icon_state = "Prince"
