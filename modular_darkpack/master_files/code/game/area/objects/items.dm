/obj/item
	var/onflooricon
	var/onflooricon_state
	var/masquerade_violating

/obj/item/Initialize(mapload)
	. = ..()

	// Add element for swapping icon to onfloor_icon and back
	if (onflooricon)
		AddElement(/datum/element/dynamic_item_icon)

/obj/item/visual_equipped(mob/user, slot, initial)
	SEND_SIGNAL(src, COMSIG_ITEM_VISUAL_EQUIPPED, user, slot)
	SEND_SIGNAL(user, COMSIG_MOB_VISUAL_EQUIPPED_ITEM, src, slot)
