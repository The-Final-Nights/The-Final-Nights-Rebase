/datum/loadout_item/proc/insert_into_loadout_bag(mob/living/carbon/human/equipper)
	var/obj/item/storage/backpack/duffelbag/loadout/bag = locate(/obj/item/storage/backpack/duffelbag/loadout) in equipper.held_items

	if(!bag) // this must be the first item being processed, so create the bag thatll hold it and the rest
		bag = new /obj/item/storage/backpack/duffelbag/loadout(equipper)
		equipper.put_in_hands(bag)

	new item_path(bag)

/datum/loadout_item/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(!visuals_only && equipper)
		insert_into_loadout_bag(equipper)

/datum/loadout_item/accessory/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(!visuals_only && equipper)
		insert_into_loadout_bag(equipper)

/datum/loadout_item
	loadout_flags = LOADOUT_FLAG_ALLOW_NAMING // let people name their loadout items!

/obj/item/kit/customization_kit
	name = "Customization kit"
	desc = "Has all the things needed to customize to your hearts content! The logo on the side pictures a woman wearing a red beret."
	icon = 'icons/obj/antags/eldritch.dmi'
	base_icon_state = "ogbook"
	icon_state = "ogbook"
	worn_icon_state = "ogbook"

/obj/item/kit/customization_kit/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!istype(target, /obj/item) && !istype(target, /obj/structure/showcase) && !istype(target, /obj/weapon_showcase))
		return FALSE
	if(!Adjacent(user))
		return FALSE
	var/original_name = target.name
	var/original_desc = target.desc

	var/new_name = tgui_input_text(user, "Enter a new name, or cancel to leave the name as it is.", "Customize Name", target.name, max_length = MAX_NAME_LEN)
	var/new_desc = tgui_input_text(user, "Enter a new description, or cancel to leave the description as it is.", "Customize Description", target.desc, max_length = MAX_DESC_LEN, multiline = TRUE)
	if(!do_after(user, 10 SECONDS))
		user.balloon_alert_to_viewers("interrupted!")
		return TRUE
	if(new_name)
		target.name = new_name
		to_chat(user, span_notice("You updated the name from: [original_name] to [new_name]"))
	if(new_desc)
		target.desc = new_desc
		to_chat(user, span_notice("You updated the description from: [original_desc] to [new_desc]"))
	message_admins("[ADMIN_LOOKUPFLW(user)] customized [original_name]: Name: [new_name] Description: [new_desc]")
	return TRUE

/datum/loadout_item/pocket_items/customization_kit
	name = "Item Renaming Kit"
	item_path = /obj/item/kit/customization_kit
