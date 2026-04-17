/datum/job/vampire/setite/ward
	title = JOB_WARD
	total_positions = 3
	spawn_positions = 3
	supervisors = "the High Priest"
	config_tag = "WARD"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/setite/ward

	display_order = JOB_DISPLAY_ORDER_WARD

	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_HARBINGER, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_TRUE_BRUJAH)

	description = "You are a ward of the Followers of Set. Whilst you may not be one of their own, your interests align more than enough."

/datum/outfit/job/vampire/setite/ward
	name = "Ward"
	jobtype = /datum/job/vampire/setite/ward
	id = /obj/item/card/supplytech
	l_pocket = /obj/item/smartphone/supply_tech/faithful
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/card/credit=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/knife/vamp)
