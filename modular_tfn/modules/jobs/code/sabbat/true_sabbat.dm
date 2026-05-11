/datum/job/vampire/true_sabbat
	title = JOB_TRUE_SABBAT
	description = "A Cainite properly inducted into the Sabbat, you are worthy to reside in their Domain. You must learn the ways of your Sect, and perhaps one night you will find true status within it."
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_SABBAT_BISHOP
	minimal_player_age = 7
	config_tag = "TRUE_SABBAT"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/true_sabbat

	display_order = JOB_DISPLAY_ORDER_TRUE_SABBAT
	department_for_prefs = /datum/job_department/true_sabbat
	departments_list = list(
		/datum/job_department/true_sabbat,
	)

	minimal_masquerade = 3
	allowed_splats = list(SPLAT_KINDRED)

	known_contacts = list("Bishop")

/datum/outfit/job/vampire/true_sabbat
	name = "True Sabbat"
	jobtype = /datum/job/vampire/true_sabbat

	uniform = /obj/item/clothing/under/vampire/homeless
	gloves = /obj/item/clothing/gloves/vampire/work
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/sabbat
	l_pocket = /obj/item/smartphone/true_sabbat
	backpack_contents = list(/obj/item/card/credit=1)
