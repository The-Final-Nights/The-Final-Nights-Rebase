// TODO: Repath these to remove keys. They have no real relation to them.
/obj/item/vamp/keys/hack
	name = "\improper lockpick"
	desc = "These can open some doors. Illegally...<br>Looking at a door with these in your hand should give you an estimate of the lock strength and start to case the building if applicable."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "hack"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/keys
	resistance_flags = FIRE_PROOF | ACID_PROOF
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

