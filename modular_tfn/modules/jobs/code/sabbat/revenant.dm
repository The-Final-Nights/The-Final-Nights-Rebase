/datum/job/vampire/revenant
	title = JOB_SABBAT_REVENANT
	description = "You are a Revenant of the Sabbat, a family maintained to serve their superiors within the manor. Born with vitae within your veins, your very existence is to serve."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_SABBAT_BISHOP
	minimal_player_age = 7
	config_tag = "REVENANT"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/revenant

	display_order = JOB_DISPLAY_ORDER_REVENANT
	department_for_prefs = /datum/job_department/true_sabbat
	departments_list = list(
		/datum/job_department/true_sabbat,
	)

	allowed_splats = list(SPLAT_GHOUL)

	known_contacts = list("Bishop")

/datum/outfit/job/vampire/revenant
	name = "Revenant"
	jobtype = /datum/job/vampire/revenant

	id = /obj/item/card/camarilla
	uniform = /obj/item/clothing/under/vampire/voivode
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/sabbat
	l_pocket = /obj/item/smartphone/revenant
	backpack_contents = list(/obj/item/vampire_stake=1, /obj/item/masquerade_contract=1, /obj/item/card/credit=1)
