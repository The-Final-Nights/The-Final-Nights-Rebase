/datum/job/vampire/setite/faithful/high_priest
	title = JOB_HIGH_PRIEST
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	total_positions = 1
	spawn_positions = 1
	supervisors = "Set and the Temple's doctrines"
	config_tag = "HIGH_PRIEST"
	outfit = /datum/outfit/job/vampire/setite/faithful/high_priest
	display_order = JOB_DISPLAY_ORDER_HIGH_PRIEST

	description = "You are the High Priest of San Francisco's Temple of Set. Guide your brothers and sisters in serving your Dark God. Enlighten the ignorant; corruption and vice are your tools of liberation."
	minimal_masquerade = 4
	minimum_immortal_age = 100

/datum/outfit/job/vampire/setite/faithful/high_priest
	name = "High Priest"
	jobtype = /datum/job/vampire/setite/faithful/high_priest
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/dealer
	l_pocket = /obj/item/smartphone/dealer/high_priest
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/card/credit/rich=1, /obj/item/hatchet)
