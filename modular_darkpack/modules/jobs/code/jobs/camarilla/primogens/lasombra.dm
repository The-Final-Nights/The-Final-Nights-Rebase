/datum/job/vamp/primogen_lasombra
	title = "Primogen Lasombra"
	description = "Offer your infinite knowledge to Prince of the City. Monitor those of your Clan and your lesser cousins, while holding a Court of Blood as need be, for all it takes for the Camarilla to turn on you is one mistake. You and Your Clan were given a domain in the local Church and in the vicinity of a swarm of Lupines, keep matters under control."
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
	config_tag = "PRIMOGEN_LASOMBRA"

	outfit = /datum/outfit/job/lasombraprim

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_LASOMBRA
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)

	job_flags = CITY_JOB_FLAGS

	minimal_generation = 12
	minimum_vampire_age = 50
	minimal_masquerade = 5
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_LASOMBRA)

	known_contacts = list("Prince")

/datum/outfit/job/lasombraprim
	name = "Primogen Lasombra"
	jobtype = /datum/job/vamp/primogen_lasombra

	//ears = /obj/item/p25radio
	id = /obj/item/card/primogen
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/turtleneck_black
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	//l_pocket = /obj/item/vamp/phone/lasombra_primo
	r_pocket = /obj/item/cockclock
	//backpack_contents = list(/obj/item/vamp/keys/lasombra/primogen=1,/obj/item/passport=1, /obj/item/vamp/creditcard/elder=1, /obj/item/card/id/whip, /obj/item/card/id/steward, /obj/item/card/id/myrmidon)

/obj/effect/landmark/start/primogen_lasombra
	name = "Primogen Lasombra"
	icon_state = "Assistant"
