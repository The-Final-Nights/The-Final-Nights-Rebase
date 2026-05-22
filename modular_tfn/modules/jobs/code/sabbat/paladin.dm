/datum/job/vampire/paladin
	title = JOB_SABBAT_PALADIN
	description = "A Paladin of the Sabbat, you must serve your Bishops loyally. Having distinguished yourself in the art of war, you must defend your Bishops and your Domain."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_SABBAT_BISHOP
	minimal_player_age = 7
	minimum_immortal_age = 10
	config_tag = "PALADIN"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/paladin

	display_order = JOB_DISPLAY_ORDER_SABBAT_PALADIN
	department_for_prefs = /datum/job_department/true_sabbat
	departments_list = list(
		/datum/job_department/true_sabbat,
	)

	allowed_splats = list(SPLAT_KINDRED)
	disallowed_clans = list(VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_GIOVANNI)
	known_contacts = list("Bishop", "Ductus")

/datum/outfit/job/vampire/paladin
	name = "Paladin"
	jobtype = /datum/job/vampire/paladin

	id = /obj/item/card/paladin
	uniform = /obj/item/clothing/under/vampire/turtleneck_black
	gloves = /obj/item/clothing/gloves/vampire/leather
	shoes = /obj/item/clothing/shoes/vampire
	glasses = /obj/item/clothing/glasses/vampire/sun
	r_pocket = /obj/item/vamp/keys/sabbat
	l_pocket = /obj/item/smartphone/paladin
	backpack_contents = list(/obj/item/vampire_stake=1, /obj/item/masquerade_contract=1, /obj/item/card/credit=1)
