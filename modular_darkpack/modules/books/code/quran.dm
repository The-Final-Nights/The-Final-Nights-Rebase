/obj/item/quran
	name = "quran"
	desc = "Inshallah..."
	icon_state = "quran"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/quran/attack(mob/living/target, mob/living/user)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/pathof = target.client?.prefs?.enlightenment ? "Enlightenment" : "Humanity"
		to_chat(user, "<b>[pathof]: [H.humanity]</b>")
