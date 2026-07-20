/datum/job/vampire/reporter
	title = JOB_RED_NEWS
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	maximum_immortal_age = 99
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/reporter
	config_tag = "RED_NEWS"
	display_order = JOB_DISPLAY_ORDER_REDNEWS
	exp_required_type_department = EXP_TYPE_REDNEWS
	department_for_prefs = /datum/job_department/citizen
	departments_list = list(
		/datum/job_department/citizen
	)

	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL, SPLAT_KINFOLK, SPLAT_GAROU, SPLAT_CORAX, SPLAT_NONE)
	allowed_tribes = list(TRIBE_BLACK_SPIRAL_DANCERS, TRIBE_FORSWORN)

	description = "You are a reporter for Red News Network working out of San-Francisco to find the next headline. Use your broadcast camera and badge to get the next big scoop."
	minimal_masquerade = 3

/datum/outfit/job/vampire/reporter
	name = "Red News Reporter"
	jobtype = /datum/job/vampire/reporter
	uniform = /obj/item/clothing/under/costume/buttondown/slacks
	neck = /obj/item/clothing/neck/tie/red
	head = /obj/item/clothing/head/fedora/beige/press
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/rednews
	id = /obj/item/card/red_news
	backpack_contents = list(
		/obj/item/card/credit=1,
		/obj/item/clothing/suit/hazardvest/press = 1,
		/obj/item/radio/entertainment/microphone/physical = 1,
		/obj/item/radio/entertainment/speakers/physical = 1,
		/obj/item/clipboard = 1,
		/obj/item/taperecorder = 1,
		/obj/item/camera = 1,
		/obj/item/wallframe/telescreen/entertainment = 1,
		/obj/item/broadcast_camera = 1,

	)



