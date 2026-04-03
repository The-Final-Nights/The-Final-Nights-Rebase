/datum/job/vampire/setite
	title = JOB_ASSOCIATE
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Supply Manager"
	config_tag = "ASSOCIATE"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/setite

	display_order = JOB_DISPLAY_ORDER_ASSOCIATE
	exp_required_type_department = EXP_TYPE_WAREHOUSE
	department_for_prefs = /datum/job_department/supply
	departments_list = list(
		/datum/job_department/supply,
	)

	allowed_splats = list(SPLAT_NONE, SPLAT_GHOUL, SPLAT_KINDRED)
	disallowed_clans = list(VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_NAGARAJA, VAMPIRE_CLAN_HEALER_SALUBRI, VAMPIRE_CLAN_WARRIOR_SALUBRI)

	description = "You work at the warehouse, moving boxes and selling not-quite legal goods to anyone who has the money. Your seniors and employers here are eccentric to say the least - it is best to look the other way."
	minimal_masquerade = 0

/datum/outfit/job/vampire/setite
	name = "Associate"
	jobtype = /datum/job/vampire/setite
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/supplytech
	l_pocket = /obj/item/smartphone/supply_tech/associate
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/card/credit=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/knife/vamp)
