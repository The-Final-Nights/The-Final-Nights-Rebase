/datum/job/vamp/primogen_banu
	title = JOB_PRIMOGEN_BANU_HAQIM
	description = "Offer your infinite knowledge to Prince of the City, while overseeing the Banu Haqim in the city. Monitor their contracts and ensure they remain true to the ways of the Clan. You have an official cover with the Police Department as a local civilian consultant, ensure things run smoothly, on either end."
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
	config_tag = "PRIMOGEN_BANU_HAQIM"

	outfit = /datum/outfit/job/banuprim

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_BANU
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)

	job_flags = CITY_JOB_FLAGS

	minimal_generation = 12
	minimum_vampire_age = 50
	minimal_masquerade = 5
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_BANU_HAQIM)

	known_contacts = list("Prince")

/datum/outfit/job/banuprim
	name = "Primogen Banu Haqim"
	jobtype = /datum/job/vamp/primogen_banu

	//ears = /obj/item/p25radio
	id = /obj/item/card/primogen
	glasses = /obj/item/clothing/glasses/vampire/yellow
	uniform = /obj/item/clothing/under/vampire/turtleneck_navy
	//suit = /obj/item/clothing/suit/vampire/jacket/banu
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	//l_pocket = /obj/item/vamp/phone/banu_primo
	r_pocket = /obj/item/cockclock
	//backpack_contents = list(/obj/item/vamp/keys/banuhaqim/primogen=1, /obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/elder=1, /obj/item/card/id/whip, /obj/item/card/id/steward, /obj/item/card/id/myrmidon)

/obj/effect/landmark/start/primogen_banu
	name = "Primogen Banu Haqim"
	icon_state = "Assistant"
