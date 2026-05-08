/obj/structure/retail/clothing_store/Initialize()
	. = ..()
	products_list += new /datum/data/vending_product("umbrella", /obj/item/umbrella, 25)
	products_list += new /datum/data/vending_product("parasol", /obj/item/umbrella/parasol, 25)
