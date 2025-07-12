/obj/item/Initialize(mapload)
	. = ..()

	// Add element for swapping icon to onfloor_icon and back
	if (onflooricon)
		AddElement(/datum/element/dynamic_item_icon)
