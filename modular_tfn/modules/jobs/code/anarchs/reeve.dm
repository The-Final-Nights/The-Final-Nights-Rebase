/datum/job/vampire/reeve
	title = JOB_REEVE
	faction = FACTION_ANARCHS
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_BARON
	config_tag = "REEVE"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/reeve

	display_order = JOB_DISPLAY_ORDER_REEVE
	department_for_prefs = /datum/job_department/anarch
	departments_list = list(
		/datum/job_department/anarch,
	)

	known_contacts = list("Bouncer", "Baron", "Sweeper", "Legate", "Sheriff")
	disallowed_clans = list(VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_HARBINGER, VAMPIRE_CLAN_HEALER_SALUBRI, VAMPIRE_CLAN_NAGARAJA, VAMPIRE_CLAN_OLD_CLAN_TZIMISCE, VAMPIRE_CLAN_WARRIOR_SALUBRI)
	allowed_splats = list(SPLAT_KINDRED)
	description = "A Keeper of order within Anarch domains. The Baron's enforcer, maintain the masquerade by obtaining warrents from the Baron before persuing those who break it, either on your lonesome or by gathering a posse of fellow Anarchs."
	minimal_masquerade = 3

/datum/outfit/job/vampire/reeve
	name = "Reeve"
	jobtype = /datum/job/vampire/reeve

	id = /obj/item/card/reeve
	uniform = /obj/item/clothing/under/vampire/bar
	suit = /obj/item/clothing/suit/vampire/jacket/better
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/brassknuckles/spiked
	l_pocket = /obj/item/smartphone/reeve
	r_pocket = /obj/item/vamp/keys/baron
	backpack_contents = list(/obj/item/vampire_stake=1, /obj/item/gun/ballistic/shotgun/vampire/doublebarrel/sawnoff=1, /obj/item/card/credit=1, /obj/item/masquerade_contract=1, /obj/item/ammo_box/darkpack/c12g/buck=1)
