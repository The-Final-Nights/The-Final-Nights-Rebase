/obj/item/toy/rubberpig
	name = "rubberpig"
	desc = "Klim Sanych, zdravstvuite."
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "rubberpig"
	inhand_icon_state = "rubberpig"
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0

/obj/item/toy/rubberpig/attack_hand(mob/user)
	var/hryuk = pick('modular_darkpack/modules/toys/sounds/pig1.ogg', 'modular_darkpack/modules/toys/sounds/pig2.ogg', 'modular_darkpack/modules/toys/sounds/pig3.ogg')
	playsound(src, hryuk, 70, TRUE)

/obj/item/toy/rubberpig/attack_self(mob/user)
	if(cooldown < world.time - 50)
		var/hryuk = pick('modular_darkpack/modules/toys/sounds/pig1.ogg', 'modular_darkpack/modules/toys/sounds/pig2.ogg', 'modular_darkpack/modules/toys/sounds/pig3.ogg')
		playsound(src, hryuk, 70, TRUE)
		user.visible_message(span_notice("[user] pushes the rubberpig."), span_notice("You push the rubberpig."))
		cooldown = world.time

/obj/item/toy/rubberpig/mouse_drop_receive(atom/over_object)
	. = ..()
	var/mob/living/M = usr
	if(!istype(M) || !(M.mobility_flags & MOBILITY_PICKUP))
		return
	if(Adjacent(usr))
		if(over_object == M && loc != M)
			M.put_in_hands(src)
			to_chat(usr, span_notice("You pick up the rubberpig."))
		else if(istype(over_object, /atom/movable/screen/inventory/hand))
			var/atom/movable/screen/inventory/hand/H = over_object
			if(M.putItemFromInventoryInHandIfPossible(src, H.held_index))
				to_chat(usr, span_notice("You pick up the rubberpig."))
	else
		return
