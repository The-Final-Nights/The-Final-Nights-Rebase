/obj/machinery/mineral/equipment_vendor/fastfood
	name = "Clerk Catalogue"
	desc = "Order some fastfood here."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "menu"
	icon_deny = "menu"
	prize_list = list()
	var/dispenses_dollars = TRUE

/obj/machinery/mineral/equipment_vendor/fastfood/sodavendor
	name = "Drink Vendor"
	desc = "Order drinks here."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "vend_r"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/vending_product("cola",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	10),
		new /datum/data/vending_product("soda", /obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda, 5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/sodavendor/blue
	icon_state = "vend_c"
	prize_list = list(new /datum/data/vending_product("cola",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue,10),
		new /datum/data/vending_product("soda", /obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue, 5),
		new /datum/data/vending_product("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 5),
		new /datum/data/vending_product("thaw club soda", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club, 7)
	)
/obj/machinery/mineral/equipment_vendor/fastfood/coffeevendor
	name = "Coffee Vendor"
	desc = "For those sleepy mornings."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "vend_g"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/vending_product("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	10),
		new /datum/data/vending_product("strong coffee", /obj/item/reagent_containers/food/drinks/coffee/vampire/robust, 5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/AltClick(mob/user)
	. = ..()
	if(points && dispenses_dollars)
		for(var/i in 1 to points)
			new /obj/item/stack/dollar(loc)
		points = 0

/obj/machinery/mineral/equipment_vendor/fastfood/snacks
	name = "Snack Vendor"
	desc = "That candy bar better not get stuck this time..."
	icon_state = "vend_b"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/vending_product("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/vending_product("chips",	/obj/item/food/vampire/crisps,	5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/bacotell
	prize_list = list(new /datum/data/vending_product("square pizza",	/obj/item/food/vampire/pizza,	15),
		new /datum/data/vending_product("taco",	/obj/item/food/vampire/taco,	10),
		new /datum/data/vending_product("burger",	/obj/item/food/vampire/burger,	20),
		new /datum/data/vending_product("two liter cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	10),
		new /datum/data/vending_product("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5),
		new /datum/data/vending_product("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 5),
		new /datum/data/vending_product("thaw club soda", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club, 8),
	)

/obj/machinery/mineral/equipment_vendor/fastfood/bubway
	prize_list = list(new /datum/data/vending_product("donut",	/obj/item/food/vampire/donut,	5),
		new /datum/data/vending_product("burger",	/obj/item/food/vampire/burger,	10),
		new /datum/data/vending_product("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	5),
		new /datum/data/vending_product("robust coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire/robust,	10),
		new /datum/data/vending_product("thaw club soda", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club, 8)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/gummaguts
	prize_list = list(new /datum/data/vending_product("five-piece chicken wing box",	/obj/item/storage/fancy/nugget_box,	5),
		new /datum/data/vending_product("burger",	/obj/item/food/vampire/burger,	15),
		new /datum/data/vending_product("square pizza",	/obj/item/food/vampire/pizza,	10),
		new /datum/data/vending_product("two liter cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	10),
		new /datum/data/vending_product("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/products
	desc = "Purchase junkfood and crap."
	prize_list = list(new /datum/data/vending_product("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/vending_product("chips",	/obj/item/food/vampire/crisps,	5),
		new /datum/data/vending_product("water bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirewater,	3),
		new /datum/data/vending_product("soda can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda,	3),
		new /datum/data/vending_product("two liter cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	7),
		new /datum/data/vending_product("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5),
		new /datum/data/vending_product("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 5),
		new /datum/data/vending_product("milk",	/obj/item/reagent_containers/food/condiment/vampiremilk,	5),
		new /datum/data/vending_product("beer bottle",	/obj/item/reagent_containers/food/drinks/beer/vampire,	10),
		new /datum/data/vending_product("blue stripe", /obj/item/reagent_containers/food/drinks/beer/vampire/blue_stripe, 8),
		new /datum/data/vending_product("candle pack",	/obj/item/storage/fancy/candle_box,	12),
		new /datum/data/vending_product("bruise pack", /obj/item/stack/medical/bruise_pack, 100),
		new /datum/data/vending_product("respirator",	/obj/item/clothing/mask/vampire,	35)
	)
