/datum/job/vampire/setite/faithful
	title = JOB_FAITHFUL
	total_positions = 4
	spawn_positions = 4
	supervisors = "the High Priest"
	config_tag = "FAITHFUL"
	outfit = /datum/outfit/job/vampire/setite/faithful

	display_order = JOB_DISPLAY_ORDER_FAITHFUL

	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_SETITE) //Locked to the clan in lieu of having the ability to check merits e.g. Setite Initiate from Lore of the Clans

	description = "You are a member of San Francisco's Temple of Set. You serve to further your Temple's interests and help the blind to see."

/datum/outfit/job/vampire/setite/faithful
	name = "Faithful"
	jobtype = /datum/job/vampire/setite/faithful
	id = /obj/item/card/supplytech
	l_pocket = /obj/item/smartphone/supply_tech/faithful
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/card/credit=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/knife/vamp)
