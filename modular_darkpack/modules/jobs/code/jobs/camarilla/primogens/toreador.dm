/datum/job/vamp/primogen_toreador
	title = JOB_PRIMOGEN_TOREADOR
	description = "Offer your infinite knowledge to Prince of the City. Take care of the Strip Club and its Elysium, for it is your domain and a social center within the city."
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
	config_tag = "PRIMOGEN_TOREADOR"

	outfit = /datum/outfit/job/toreador

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_TOREADOR
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)

	job_flags = CITY_JOB_FLAGS

	minimal_generation = 12
	minimum_vampire_age = 50
	minimal_masquerade = 5
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TOREADOR)

	known_contacts = list("Prince")

/datum/outfit/job/toreador
	name = "Primogen Toreador"
	jobtype = /datum/job/vamp/primogen_toreador

	//ears = /obj/item/p25radio
	id = /obj/item/card/primogen
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/primogen_toreador
	suit = /obj/item/clothing/suit/vampire/trench/alt
	shoes = /obj/item/clothing/shoes/vampire
	//l_pocket = /obj/item/vamp/phone/toreador_primo
	r_pocket = /obj/item/cockclock
	//backpack_contents = list(/obj/item/vamp/keys/toreador/primogen=1, /obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/elder=1, /obj/item/card/id/whip, /obj/item/card/id/steward, /obj/item/card/id/myrmidon, /obj/item/gun/ballistic/automatic/vampire/beretta/toreador=1, /obj/item/ammo_box/magazine/semi9mm/toreador=1)
