/obj/item/ritual_tome/necromancy/ui_data(mob/user)
	. = list()
	.["user"] = list()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		.["user"]["souls"] = H.collected_souls
		.["user"]["name"] = "[H.name]"
		.["user"]["job"] = "[H.mind?.assigned_role?.title]"
		.["user"]["has_necromancy"] = !!H.get_discipline(/datum/discipline/necromancy)
	else if(isliving(user))
		var/mob/living/L = user
		.["user"]["souls"] = L.collected_souls
		.["user"]["name"] = "[L.name]"
		.["user"]["job"] = "Unknown"
		.["user"]["has_necromancy"] = FALSE
	else
		.["user"]["souls"] = 0
		.["user"]["name"] = "Unknown"
		.["user"]["job"] = "Unknown"
		.["user"]["has_necromancy"] = FALSE

/obj/item/ritual_tome/necromancy/ui_act(action, params)
	if(action != "purchase")
		return ..()

	var/mob/living/user = astype(usr)
	if(!user || !user.get_discipline(/datum/discipline/necromancy))
		return FALSE

	var/datum/data/vending_product/prize = locate(params["ref"]) in products_list

	user.collected_souls -= prize.price
	to_chat(user, span_notice("The necromancy tome resonates with dark energy as it dispenses [prize.name]!"))
	new prize.product_path(get_turf(user))
	return TRUE

/obj/machinery/mineral/equipment_vendor/fastfood/necromancy
	name = "Ominous Gravestone"
	desc = "A sinister looking gravestone, the air around it is cold to the touch."
	icon = 'modular_darkpack/modules/graveyard/icons/graves.dmi'
	icon_state = "tombstone1"
	var/list/products_list = list(
	new /datum/data/vending_product("bat corpse",	/mob/living/basic/corpsestore/corpse1,	1,),
	new /datum/data/vending_product("dog corpse",	/mob/living/basic/corpsestore/corpse2,	2),
	new /datum/data/vending_product("pile of bones",	/mob/living/basic/corpsestore/corpse3,	3),
	new /datum/data/vending_product("rotting corpse",	/mob/living/basic/corpsestore/corpse4,	4),
	new /datum/data/vending_product("skull",	/obj/item/corspestore/skull,	2,),
	new /datum/data/vending_product("ripped arm",	/obj/item/melee/baseball_bat/vamp/hand,	2,),
	new /datum/data/vending_product("scythe",	/obj/item/scythe/vamp,	3,),
	new /datum/data/vending_product("oboli",	/obj/item/coin/oboli,	1,),
	)

// NecromancyVendor.jsx in tgui/interfaces
/obj/machinery/mineral/equipment_vendor/fastfood/necromancy/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NecromancyVendor", name)
		ui.open()

/obj/machinery/mineral/equipment_vendor/fastfood/necromancy/ui_data(mob/user)
	. = list()
	.["user"] = list()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		.["user"]["souls"] = H.collected_souls
		.["user"]["name"] = "[H.name]"
		.["user"]["job"] = "[H.mind?.assigned_role?.title]"
		.["user"]["has_necromancy"] = !!H.get_discipline(/datum/discipline/necromancy)
	else if(isliving(user))
		var/mob/living/L = user
		.["user"]["souls"] = L.collected_souls
		.["user"]["name"] = "[L.name]"
		.["user"]["job"] = "Unknown"
		.["user"]["has_necromancy"] = FALSE
	else
		.["user"]["souls"] = 0
		.["user"]["name"] = "Unknown"
		.["user"]["job"] = "Unknown"
		.["user"]["has_necromancy"] = FALSE


/obj/machinery/mineral/equipment_vendor/fastfood/necromancy/ui_act(action, params)
	if(action != "purchase")
		return ..()

	var/mob/living/user = astype(usr)
	if(!user || !user.get_discipline(/datum/discipline/necromancy))
		return FALSE

	var/datum/data/vending_product/prize = locate(params["ref"]) in products_list

	user.collected_souls -= prize.price
	to_chat(user, span_notice("The necromancy tome resonates with dark energy as it dispenses [prize.name]!"))
	new prize.product_path(get_turf(user))
	return TRUE

	// Deduct souls from purchase
	L.collected_souls -= prize.cost
	to_chat(usr, span_notice("The Bone Codex resonates with dark energy as it dispenses [prize.equipment_name]!"))
	new prize.equipment_path(loc)
	SSblackbox.record_feedback("nested tally", "necromancy_equipment_bought", 1, list("[type]", "[prize.equipment_path]"))
	return TRUE
