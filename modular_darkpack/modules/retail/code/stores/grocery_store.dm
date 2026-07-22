/obj/structure/retail/grocery_store
	desc = "A small grocery store."
	products_list = list(
		new /datum/data/vending_product("chocolate bar", /obj/item/food/chocolatebar),
	/* TFN EDIT REMOVE START - COOKING UPDATE
		new /datum/data/vending_product("chips", /obj/item/food/chips),
		new /datum/data/vending_product("water bottle", /obj/item/reagent_containers/cup/glass/vampirewater),
		new /datum/data/vending_product("soda can", /obj/item/reagent_containers/cup/soda_cans/vampiresoda),
		new /datum/data/vending_product("two liter cola bottle", /obj/item/reagent_containers/cup/glass/vampirecola),
		new /datum/data/vending_product("cola can", /obj/item/reagent_containers/cup/soda_cans/vampirecola),
		new /datum/data/vending_product("summer thaw", /obj/item/reagent_containers/cup/soda_cans/summer_thaw),
	*/ // TFN EDIT REMOVE END - COOKING UPDATE
		new /datum/data/vending_product("raisins", /obj/item/food/no_raisin, 3), // TFN EDIT ADD - COOKING UPDATE
		new /datum/data/vending_product("milk", /obj/item/reagent_containers/condiment/milk),
	// TFN EDIT ADD START - COOKING UPDATE
		new /datum/data/vending_product("soy milk", /obj/item/reagent_containers/condiment/soymilk, 8),
		new /datum/data/vending_product("creamer", /obj/item/reagent_containers/cup/glass/bottle/juice/cream, 10),
		new /datum/data/vending_product("butter", /obj/item/food/butter, 5),
	// TFN EDIT ADD END - COOKING UPDATE
		new /datum/data/vending_product("bread", /obj/item/food/bread/plain, 8),
		new /datum/data/vending_product("spaghetti", /obj/item/food/spaghetti/raw, 6),
		new /datum/data/vending_product("tomato", /obj/item/food/grown/tomato),
		new /datum/data/vending_product("potato", /obj/item/food/grown/potato), // TFN EDIT ADD - COOKING UPDATE
		new /datum/data/vending_product("cabbage", /obj/item/food/grown/cabbage),
		new /datum/data/vending_product("garlic", /obj/item/food/grown/garlic),
		new /datum/data/vending_product("onion", /obj/item/food/grown/onion),
		new /datum/data/vending_product("parsnip", /obj/item/food/grown/parsnip),
	// TFN EDIT ADD START - COOKING UPDATE
		new /datum/data/vending_product("olive", /obj/item/food/grown/olive),
		new /datum/data/vending_product("chili", /obj/item/food/grown/chili),
		new /datum/data/vending_product("bell pepper", /obj/item/food/grown/bell_pepper),
	// TFN EDIT ADD END - COOKING UPDATE
		new /datum/data/vending_product("peas", /obj/item/food/grown/peas),
		new /datum/data/vending_product("corn", /obj/item/food/grown/corn),
	// TFN EDIT ADD START - COOKING UPDATE
		new /datum/data/vending_product("soybeans", /obj/item/food/grown/soybeans),
		new /datum/data/vending_product("peanut", /obj/item/food/grown/peanut),
		new /datum/data/vending_product("cucumber", /obj/item/food/grown/cucumber),
	// TFN EDIT ADD END - COOKING UPDATE
		new /datum/data/vending_product("apple", /obj/item/food/grown/apple),
		new /datum/data/vending_product("berries", /obj/item/food/grown/berries),
		new /datum/data/vending_product("banana", /obj/item/food/grown/banana),
	// TFN EDIT ADD START - COOKING UPDATE
		new /datum/data/vending_product("orange", /obj/item/food/grown/citrus/orange),
		new /datum/data/vending_product("grapes", /obj/item/food/grown/grapes),
		new /datum/data/vending_product("cherries", /obj/item/food/grown/cherries),
		new /datum/data/vending_product("mushroom", /obj/item/food/grown/mushroom, 3),
		new /datum/data/vending_product("bundle of herbs", /obj/item/food/grown/herbs, 3),
		new /datum/data/vending_product("seaweed sheet", /obj/item/food/seaweedsheet, 3),
		new /datum/data/vending_product("cooking oil", /obj/item/reagent_containers/condiment/vegetable_oil, 12),
	// TFN EDIT ADD END - COOKING UPDATE
		new /datum/data/vending_product("cooking enzymes", /obj/item/reagent_containers/condiment/enzyme, 12),
		new /datum/data/vending_product("salt shaker", /obj/item/reagent_containers/condiment/saltshaker, 3),
		new /datum/data/vending_product("pepper mill", /obj/item/reagent_containers/condiment/peppermill, 3),
		new /datum/data/vending_product("honey", /obj/item/reagent_containers/condiment/honey, 3), // TFN EDIT ADD - COOKING UPDATE
	/* TFN EDIT REMOVE START - COOKING UPDATE
		new /datum/data/vending_product("bbq sauce", /obj/item/reagent_containers/condiment/bbqsauce, 3),
		new /datum/data/vending_product("soy sauce", /obj/item/reagent_containers/condiment/soysauce, 4),
	*/ // TFN EDIT REMOVE END - COOKING UPDATE
	// TFN EDIT ADD START - COOKING UPDATE
		new /datum/data/vending_product("red bay seasoning", /obj/item/reagent_containers/condiment/red_bay, 4),
		new /datum/data/vending_product("vinegar", /obj/item/reagent_containers/condiment/vinegar, 4),
	// TFN EDIT ADD END - COOKING UPDATE
		new /datum/data/vending_product("mayonnaise", /obj/item/reagent_containers/condiment/mayonnaise, 3),
		new /datum/data/vending_product("egg carton", /obj/item/storage/fancy/egg_box),
	/* TFN EDIT REMOVE START - COOKING UPDATE
		new /datum/data/vending_product("cream", /obj/item/reagent_containers/cup/glass/bottle/juice/cream),
		new /datum/data/vending_product("yoghurt", /obj/item/reagent_containers/condiment/yoghurt),
		new /datum/data/vending_product("vinegar", /obj/item/reagent_containers/condiment/vinegar),
		new /datum/data/vending_product("vegetable oil", /obj/item/reagent_containers/condiment/vegetable_oil),
		new /datum/data/vending_product("quality oil", /obj/item/reagent_containers/condiment/olive_oil),
		new /datum/data/vending_product("peanut butter", /obj/item/reagent_containers/condiment/peanut_butter),
		new /datum/data/vending_product("cherry jelly", /obj/item/reagent_containers/condiment/cherryjelly),
		new /datum/data/vending_product("honey", /obj/item/reagent_containers/condiment/honey),
	*/ // TFN EDIT REMOVE END - COOKING UPDATE
		new /datum/data/vending_product("flour bag", /obj/item/reagent_containers/condiment/flour, 3),
		new /datum/data/vending_product("sugar bag", /obj/item/reagent_containers/condiment/sugar),
		new /datum/data/vending_product("rice bag", /obj/item/reagent_containers/condiment/rice, 3),
	/* TFN EDIT REMOVE START - COOKING UPDATE
		new /datum/data/vending_product("cornmeal", /obj/item/reagent_containers/condiment/cornmeal),
		new /datum/data/vending_product("beer bottle", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire),
		new /datum/data/vending_product("blue stripe", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire/blue_stripe),
		new /datum/data/vending_product("candle pack", /obj/item/storage/fancy/candle_box),
		new /datum/data/vending_product("bruise pack", /obj/item/stack/medical/bruise_pack),
	*/ // TFN EDIT REMOVE END - COOKING UPDATE
	// TFN EDIT ADD START - COOKING UPDATE
		new /datum/data/vending_product("drinking glass", /obj/item/reagent_containers/cup/glass/drinkingglass, 10),
		new /datum/data/vending_product("colo cup", /obj/item/reagent_containers/cup/glass/colocup, 2),
		new /datum/data/vending_product("bowl", /obj/item/reagent_containers/cup/bowl, 15),
		new /datum/data/vending_product("appetizer plate", /obj/item/plate/small, 10),
		new /datum/data/vending_product("plate", /obj/item/plate, 15),
		new /datum/data/vending_product("buffet plate", /obj/item/plate/large, 20),
		new /datum/data/vending_product("soup pot", /obj/item/reagent_containers/cup/soup_pot, 25),
	// TFN EDIT ADD END - COOKING UPDATE
		new /datum/data/vending_product("kitchen knife", /obj/item/knife, 26),
		new /datum/data/vending_product("rolling pin", /obj/item/kitchen/rollingpin, 8),
		new /datum/data/vending_product("mixing bowl", /obj/item/reagent_containers/cup/mixing_bowl),
	// TFN EDIT ADD START - COOKING UPDATE
		new /datum/data/vending_product("fork", /obj/item/kitchen/fork, 5),
		new /datum/data/vending_product("spoon", /obj/item/kitchen/spoon, 5),
		new /datum/data/vending_product("plastic fork", /obj/item/kitchen/fork/plastic, 2),
		new /datum/data/vending_product("plastic spoon", /obj/item/kitchen/spoon/plastic, 2),
		new /datum/data/vending_product("plastic knife", /obj/item/knife/plastic, 2),
	// TFN EDIT ADD END - COOKING UPDATE
	)

/obj/structure/retail/deli
	desc = "Meats and cheese!"
	products_list = list(
		new /datum/data/vending_product("deli cut beef", /obj/item/food/meat/slab, 4),
		new /datum/data/vending_product("cutlet", /obj/item/food/meat/rawcutlet, 1),
		new /datum/data/vending_product("bacon", /obj/item/food/meat/rawbacon, 1),
		new /datum/data/vending_product("meatball", /obj/item/food/raw_meatball, 1),
		new /datum/data/vending_product("patty", /obj/item/food/raw_patty, 1),
		new /datum/data/vending_product("sausage", /obj/item/food/raw_sausage, 1),
		new /datum/data/vending_product("salami", /obj/item/food/salami, 1),
		new /datum/data/vending_product("chicken breast", /obj/item/food/meat/slab/chicken, 3),
		new /datum/data/vending_product("fish fillet", /obj/item/food/fishmeat, 3),
		new /datum/data/vending_product("cheese wheel", /obj/item/food/cheese/wheel, 12),
		new /datum/data/vending_product("sandwich", /obj/item/food/sandwich, 3),
	)
