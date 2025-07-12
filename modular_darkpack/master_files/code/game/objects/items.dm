/obj/item
	var/onflooricon
	var/onflooricon_state
	var/masquerade_violating

/obj/item/visual_equipped(mob/user, slot, initial)
	SEND_SIGNAL(src, COMSIG_ITEM_VISUAL_EQUIPPED, user, slot)
	SEND_SIGNAL(user, COMSIG_MOB_VISUAL_EQUIPPED_ITEM, src, slot)
