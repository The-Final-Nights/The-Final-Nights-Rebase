/obj/machinery/mineral/equipment_vendor/fastfood/illegal	// PSEUDO_M make this restricted and only available for triads
	prize_list = list(
		new /datum/data/vending_product("lighter",		/obj/item/lighter/greyscale,	10),
		new /datum/data/vending_product("zippo lighter",	/obj/item/lighter,	20),
		new /datum/data/vending_product("Bailer", /obj/item/bailer, 20),
		new /datum/data/vending_product("Weed Seed", /obj/item/weedseed, 20),
		new /datum/data/vending_product("cannabis puff",		/obj/item/clothing/mask/cigarette/rollie/cannabis,	40),
		new /datum/data/vending_product("bong",	/obj/item/bong,		50),
		new /datum/data/vending_product("lockpick",	/obj/item/vamp/keys/hack, 50),
		new /datum/data/vending_product("LSD pill bottle",		/obj/item/storage/pill_bottle/lsd,	50),
		new /datum/data/vending_product("knife",	/obj/item/knife/vamp,	85),
		new /datum/data/vending_product("switchblade",	/obj/item/switchblade/vamp, 85),
		new /datum/data/vending_product("stake",	/obj/item/vampire_stake,	100),
		new /datum/data/vending_product("Surgery dufflebag", /obj/item/storage/backpack/duffelbag/med/surgery, 100),
		new /datum/data/vending_product("snub-nose revolver",	/obj/item/gun/ballistic/vampire/revolver/snub,	100),
		new /datum/data/vending_product("cannabis package",		/obj/item/weedpack,	700),
		new /datum/data/vending_product("morphine syringe",	/obj/item/reagent_containers/syringe/contraband/morphine,	800),
		new	/datum/data/vending_product("meth package",	/obj/item/reagent_containers/food/drinks/meth,	800),
		new	/datum/data/vending_product("cocaine package",	/obj/item/reagent_containers/food/drinks/meth/cocaine,	800),
		new /datum/data/vending_product("silver 9mm ammo",	/obj/item/ammo_box/vampire/c9mm/silver,	5000),
		new /datum/data/vending_product("silver .45 ACP ammo",	/obj/item/ammo_box/vampire/c45acp/silver,	6000),
		new /datum/data/vending_product("silver .44 ammo",	/obj/item/ammo_box/vampire/c44/silver,	7000),
		new /datum/data/vending_product("silver 5.56 ammo",	/obj/item/ammo_box/vampire/c556/silver,	8000),
		new /datum/data/vending_product("incendiary 5.56 ammo",	/obj/item/ammo_box/vampire/c556/incendiary,	9000)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/pharmacy
	prize_list = list(
		new /datum/data/vending_product("bruise pack", /obj/item/stack/medical/bruise_pack, 100),
		new /datum/data/vending_product("burn ointment", /obj/item/stack/medical/ointment, 100),
		new /datum/data/vending_product("potassium iodide pill bottle", /obj/item/storage/pill_bottle/potassiodide, 100),
		new /datum/data/vending_product("latex gloves", /obj/item/clothing/gloves/vampire/latex, 150),
		new /datum/data/vending_product("iron pill bottle", /obj/item/storage/pill_bottle/iron, 150),
		new /datum/data/vending_product("ephedrine pill bottle", /obj/item/storage/pill_bottle/ephedrine, 200),
		new /datum/data/vending_product("box of syringes", /obj/item/storage/box/syringes, 300)
	)


/obj/machinery/mineral/equipment_vendor/fastfood/smoking
	prize_list = list(new /datum/data/vending_product("malboro",	/obj/item/storage/fancy/cigarettes/cigpack_robust,	50),
		new /datum/data/vending_product("newport",		/obj/item/storage/fancy/cigarettes/cigpack_xeno,	30),
		new /datum/data/vending_product("camel",	/obj/item/storage/fancy/cigarettes/dromedaryco,	30),
		new /datum/data/vending_product("zippo lighter",	/obj/item/lighter,	20),
		new /datum/data/vending_product("lighter",		/obj/item/lighter/greyscale,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/gas
	prize_list = list(new /datum/data/vending_product("full gas can",	/obj/item/gas_can/full,	250),
		new /datum/data/vending_product("tire iron",		/obj/item/melee/vamp/tire,	50),
		new /datum/data/vending_product("Spray Paint",		/obj/item/toy/crayon/spraycan,		25),
		new /datum/data/vending_product("Hair Spray",		/obj/item/dyespray,		10),
	)

/obj/machinery/mineral/equipment_vendor/fastfood/library

	prize_list = list(
		new /datum/data/vending_product("Bible",	/obj/item/storage/book/bible,  20),
		new /datum/data/vending_product("Quran",	/obj/item/vampirebook/quran,  20),
		new /datum/data/vending_product("black pen",	/obj/item/pen,  5),
		new /datum/data/vending_product("four-color pen",	/obj/item/pen/fourcolor,  10),
		new /datum/data/vending_product("fountain pen",	/obj/item/pen/fountain,  15),
		new /datum/data/vending_product("folder",	/obj/item/folder,  5)
	)
