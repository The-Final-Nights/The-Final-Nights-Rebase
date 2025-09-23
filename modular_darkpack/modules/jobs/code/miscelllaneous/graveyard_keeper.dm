
/datum/job/vamp/graveyard
	title = "Graveyard Keeper"
	department_head = list("Seneschal")
	faction = "Vampire"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#e3e3e3"
	exp_type_department = EXP_TYPE_SERVICES


	outfit = /datum/outfit/job/graveyard

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)
	minimal_access = list(ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_GRAVEYARD
	bounty_types = CIV_JOB_MINE

	v_duty = "A vile curse has gripped the dead of this city. You must keep the graveyard clean and the Masquerade intact."
	minimal_masquerade = 0

	allowed_species = list("Vampire", "Ghoul", "Kuei-Jin")
	allowed_bloodlines = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_FOLLOWERS_OF_SET, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_CAPPADOCIAN)

/datum/outfit/job/graveyard
	name = "Graveyard Keeper"
	jobtype = /datum/job/vamp/graveyard

	id = /obj/item/card/id/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
//	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/vampire/graveyard
	suit = /obj/item/clothing/suit/vampire/trench
	glasses = /obj/item/clothing/glasses/vampire/yellow
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/graveyard
	r_hand = /obj/item/shovel/vamp
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit=1, /obj/item/scythe/vamp=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/graveyardkeeper
	name = "Graveyard Keeper"
	icon_state = "Graveyard Keeper"
