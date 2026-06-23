/obj/item/masquerade_contract
	name = "\improper elegant scroll"
	desc = "An elegant looking scroll."
	icon = 'modular_darkpack/modules/masquerade/icons/masquerade_contract.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/masquerade/icons/onfloor.dmi')
	icon_state = "masquerade"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/masquerade_contract
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/masquerade_contract
	fire = 100
	acid = 100

/obj/item/masquerade_contract/attack_self(mob/user, modifiers)
	. = ..()
	if(!get_vampire_splat(user))
		return
	var/turf/current_location = get_turf(user)
	// TFN EDIT CHANGE START - You Breach or You Don't
	to_chat(user, "[span_bold("YOU")], [get_area_name(user)]")
	for(var/mob/living/carbon/breacher in GLOB.masquerade_breakers_list)
		var/turf/turf = get_turf(breacher)
		var/direction = get_dir(current_location, turf)
		var/disttext = dir2text(direction)
		to_chat(user, span_info("[breacher.real_name], [get_area_name(turf)], [disttext]"))
	// TFN EDIT CHANGE END - You Breach or You Don't

	if(!GLOB.masquerade_breakers_list)
		to_chat(user, span_info("No available Masquerade breakers in city..."))

/obj/item/veil_contract
	name = "\improper brass pocketwatch"
	desc = "A posh looking pocketwatch."
	icon = 'modular_darkpack/modules/masquerade/icons/masquerade_contract.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/masquerade/icons/onfloor.dmi')
	icon_state = "pocketwatch"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/masquerade_contract
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/veil_contract/attack_self(mob/user, modifiers)
	. = ..()
	if(!get_werewolf_splat(user))
		return
	var/turf/current_location = get_turf(user)
	// TFN EDIT CHANGE START - You Breach or You Don't
	to_chat(user, "[span_bold("YOU")], [get_area_name(user)]")
	for(var/mob/living/breacher in GLOB.veil_breakers_list)
		var/turf/turf = get_turf(breacher)
		var/direction = get_dir(current_location, turf)
		var/disttext = dir2text(direction)
		to_chat(user, span_info("[breacher.real_name], [get_area_name(turf)], [disttext]"))
	// TFN EDIT CHANGE END - You Breach or You Don't

	if(!GLOB.veil_breakers_list)
		to_chat(user, span_info("No available Veil breakers in city..."))
