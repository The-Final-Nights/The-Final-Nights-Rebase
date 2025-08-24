/obj/structure/retail
	name = "retail outlet"
	desc = "A counter for partaking in wretched capitalism. Takes cash or card."
	icon = 'modular_darkpack/modules/retail/icons/vendors_shops.dmi'
	icon_state = "menu"
	density = FALSE
	anchored = TRUE
	var/owner_needed = TRUE //Does an npc need to be here for this
	var/mob/living/carbon/human/npc/my_owner //tracks existence of owner
	var/is_gun_store = FALSE

	var/list/products_list = list(
		new /datum/data/vending_product("Plain Donut", /obj/item/food/donut/plain),
		new /datum/data/vending_product("Plain Jelly Donut", /obj/item/food/donut/jelly/plain),
		new /datum/data/vending_product("Berry Donut", /obj/item/food/donut/berry),
		new /datum/data/vending_product("Frosted Jelly Donut", /obj/item/food/donut/jelly/berry),
		new /datum/data/vending_product("Purple Donut", /obj/item/food/donut/trumpet),
		new /datum/data/vending_product("Frosted Purple-Jelly Donut", /obj/item/food/donut/jelly/trumpet),
		new /datum/data/vending_product("Apple Donut", /obj/item/food/donut/apple),
		new /datum/data/vending_product("Apple Jelly Donut", /obj/item/food/donut/jelly/apple),
		new /datum/data/vending_product("Caramel Donut", /obj/item/food/donut/caramel),
		new /datum/data/vending_product("Caramel Jelly Donut", /obj/item/food/donut/jelly/caramel),
		new /datum/data/vending_product("Chocolate Donut", /obj/item/food/donut/choco),
		new /datum/data/vending_product("Chocolate Custard Donut", /obj/item/food/donut/jelly/choco),
		new /datum/data/vending_product("Matcha Donut", /obj/item/food/donut/matcha),
		new /datum/data/vending_product("Matcha Jelly Donut", /obj/item/food/donut/jelly/matcha),
		new /datum/data/vending_product("Blueberry Muffin", /obj/item/food/muffin/berry),
	)

/obj/structure/retail/Initialize()
	. = ..()
	if(owner_needed == TRUE)
		//Im 99% sure this can be a locate instead.
		for(var/mob/living/carbon/human/npc/NPC in range(2, src))
			my_owner = NPC
			break
	build_inventory()

//whether or not the user can shop at this store.
/obj/structure/retail/proc/can_shop(mob/user)
	return TRUE

/obj/structure/retail/can_interact(mob/user)
	. = ..()
	if(!. || !can_shop(user))
		return FALSE

/obj/structure/retail/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(can_shop(user))
		if(owner_needed == TRUE && (!my_owner || (get_dist(src, my_owner) > 4) || (my_owner.stat >= HARD_CRIT)))
			to_chat(user, span_alert("There's no teller here to sell you things..."))
			return
		ui_interact(user)

/obj/structure/retail/proc/build_inventory()
	for(var/datum/data/vending_product/product in products_list)
		if(!product)
			CRASH("Null retail product loaded in initialization of [src]. This should not happen!")
		//GLOB.vending_products[product.product_path] = 1

/obj/structure/retail/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet_batched/vending),
	)
//yea
/obj/structure/retail/ui_interact(mob/user, datum/tgui/ui)
	if(owner_needed == TRUE)
		if(!my_owner)
			return
		if(get_dist(src, my_owner) > 4)
			return
		if(my_owner.stat >= HARD_CRIT)
			return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RetailVendor", name)
		ui.open()

/obj/structure/retail/ui_static_data(mob/user)
	. = list()
	.["product_records"] = list()
	for(var/datum/data/vending_product/product in products_list)
		var/list/product_data = list(
			path = replacetext(replacetext("[product.product_path]", "/obj/item/", ""), "/", "-"),
			name = product.name,
			price = product.price,
			stock = product.amount,
			dimensions = product.icon_dimension,
			ref = REF(product)
		)
		.["product_records"] += list(product_data)

/obj/structure/retail/ui_data(mob/user)
	. = list()
	.["user"] = list()
	.["user"]["money"] = 0
	.["user"]["is_card"] = 0

	var/list/held_items = list()
	if(user.get_active_held_item())
		held_items += user.get_active_held_item()
	if(user.get_inactive_held_item())
		held_items += user.get_inactive_held_item()

	for(var/obj/item/held_item in held_items)
		if(is_creditcard(held_item))
			.["user"]["is_card"] = 1
			.["user"]["payment_item"] = REF(held_item)
			break
		if(iscash(held_item))
			var/obj/item/money = held_item
			.["user"]["money"] = money.get_item_credit_value()
			.["user"]["payment_item"] = REF(held_item)
			break
	return

/obj/structure/retail/ui_act(action, params)
	. = ..()
	if(.)
		return

	if(owner_needed == TRUE && (!my_owner || (get_dist(src, my_owner) > 4) || (my_owner.stat >= HARD_CRIT)))
		to_chat(usr, span_alert("There's no teller here to sell you things..."))
		return

	switch(action)
		if("purchase")
			if(!isliving(usr))
				return
			var/mob/living/user = usr

			var/datum/data/vending_product/product = locate(params["ref"]) in products_list
			if(!product)
				to_chat(usr, span_alert("Error: Invalid choice!"))
				return

			var/obj/item/held_item = locate(params["payment_item"]) in user
			if(!held_item)
				to_chat(usr, span_alert("Error: Payment method not found!"))
				return

			if(product.amount == 0)
				to_chat(usr, span_alert("Error: Product is out of stock!"))
				return

			//get the money
			if(is_creditcard(held_item))
				var/obj/item/card/credit/creditcard = held_item
				var/datum/bank_account/used_account = creditcard.registered_account
				if(!used_account)
					to_chat(user, span_alert("The [creditcard] has no linked account."))
					return
				if(!used_account.check_pin(user, product.price, creditcard))
					return
				if(!used_account.adjust_money(-1 * product.price))
					to_chat(user, span_alert("The transaction is declined - Insufficient funds."))
					return
				//used_account.process_credit_fraud(user, product.price)

			else if(istype(held_item, /obj/item/stack/dollar) && !held_item.use(product.price))
				to_chat(user, span_alert("You don't have enough money in your hand."))
				return
			playsound(get_turf(src), 'sound/effects/cashregister.ogg', 50, TRUE)
			new product.product_path(loc)
			if(product.amount > 0)
				--product.amount
				update_static_data(usr)
			SSblackbox.record_feedback("nested tally", "retail_item_bought", 1, list("[type]", "[product.product_path]"))
			. = TRUE
