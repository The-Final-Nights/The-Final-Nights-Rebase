/datum/job/vampire/bishop
	title = JOB_SABBAT_BISHOP
	description = "You are a Bishop of the Sabbat. Whilst your domain does not have an Archbishop, you and your fellow Bishops rule this place in a council. You must maintain the Sabbat's presence and interests without risking the end of its presence in San Francisco."
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_SABBAT
	minimal_player_age = 7
	minimum_immortal_age = 80
	config_tag = "BISHOP"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/bishop
	display_order = JOB_DISPLAY_ORDER_SABBAT_BISHOP
	department_for_prefs = /datum/job_department/true_sabbat
	departments_list = list(
		/datum/job_department/true_sabbat,
	)

	allowed_splats = list(SPLAT_KINDRED)
	disallowed_clans = list(VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_GIOVANNI)
	known_contacts = list("Ductus")

/datum/outfit/job/vampire/bishop
	name = "Bishop"
	jobtype = /datum/job/vampire/bishop

	id = /obj/item/card/noddist
	uniform = /obj/item/clothing/under/vampire/suit
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/trench/alt
	shoes = /obj/item/clothing/shoes/vampire
	glasses = /obj/item/clothing/glasses/vampire/sun
	r_pocket = /obj/item/vamp/keys/sabbat
	l_pocket = /obj/item/smartphone/bishop
	backpack_contents = list(/obj/item/masquerade_contract=1, /obj/item/card/credit=1)
