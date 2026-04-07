/datum/job/vampire/primogen_brujah
	title = JOB_PRIMOGEN_BRUJAH
	description = "Offer your infinite knowledge to the Prince of the City. Monitor those of your Clan, and represent your interests as best you can despite the faltering of your fellows."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
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
	config_tag = "PRIMOGEN_BRUJAH"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/brujahprim

	display_order = JOB_DISPLAY_ORDER_BRUJAH
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla
	)

	minimal_generation = 12
	minimum_immortal_age = 100
	minimal_masquerade = 5
	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_BRUJAH)

	known_contacts = list("Prince")

/datum/outfit/job/vampire/brujahprim
	name = "Primogen Brujah"
	jobtype = /datum/job/vampire/primogen_brujah

	id = /obj/item/card/primogen
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/brujah
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/smartphone/brujah_primo
	backpack_contents = list(/obj/item/vamp/keys/brujah/primogen=1, /obj/item/card/credit/elder=1, /obj/item/card/whip, /obj/item/card/steward, /obj/item/card/myrmidon)
