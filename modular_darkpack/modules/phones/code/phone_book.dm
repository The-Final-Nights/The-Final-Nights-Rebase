/obj/item/phone_book
	name = "phone book"
	desc = "See the actual numbers in the city."
	icon_state = "phonebook"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/phone_book/attack_self(mob/user)
	. = ..()
	for(var/i in GLOB.phone_numbers_list)
		to_chat(user, "- [i]")
