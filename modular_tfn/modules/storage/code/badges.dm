/obj/item/storage/box/hound_badges
	name = "security badge box"
	desc = "A box of badges to deputize people with."

/obj/item/storage/box/hound_badges/PopulateContents()
	generate_items_inside(list(
		/obj/item/card/camarilla = 5
	),src)
