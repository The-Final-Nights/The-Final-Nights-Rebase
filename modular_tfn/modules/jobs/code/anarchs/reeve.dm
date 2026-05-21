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
	allowed_clans = list(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_BANU_HAQIM_VIZIER, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_DOMINATE_MALKAVIAN, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_NAGARAJA, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_CAPPADOCIAN)
	allowed_splats = list(SPLAT_KINDRED)
	description = "A Keeper of order within Anarch domains. The Baron's enforcer, maintain the masquerade by obtaining warrents from the Baron before persuing those who break it, either on your lonesome or by gathering a posse of fellow Anarchs."
	minimal_masquerade = 3

/datum/outfit/job/vampire/reeve
	name = "Reeve"
	jobtype = /datum/job/vampire/reeve

	id = /obj/item/card/reeve
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/bar
	suit = /obj/item/clothing/suit/vampire/jacket/better
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/smartphone/reeve
	r_pocket = /obj/item/vamp/keys/baron
	r_hand = /obj/item/gun/ballistic/shotgun/vampire/doublebarrel
	backpack_contents = list(/obj/item/vampire_stake=2, /obj/item/card/credit=1, /obj/item/clothing/gloves/vampire/tfn/brassknuckles/spiked=1, /obj/item/masquerade_contract=1, /obj/item/ammo_box/darkpack/c12g/buck=1)
