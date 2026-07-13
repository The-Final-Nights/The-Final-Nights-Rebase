#define PERSISTENT_PHONES_SAVE_PATH "data/tfn_data/persistent_phones.json"

/datum/controller/subsystem/phones
	var/list/persistent_phone_numbers = null

/datum/controller/subsystem/phones/proc/load_persistent_numbers()
	if(persistent_phone_numbers)
		return
	persistent_phone_numbers = list()
	var/datum/json_savefile/phone_savefile = new /datum/json_savefile(PERSISTENT_PHONES_SAVE_PATH)
	var/list/saved = phone_savefile.get_entry("taken")
	if(saved)
		for(var/number in saved)
			persistent_phone_numbers[number] = TRUE

/datum/controller/subsystem/phones/proc/reserve_persistent_number(number)
	load_persistent_numbers()
	persistent_phone_numbers[number] = TRUE
	var/datum/json_savefile/phone_savefile = new /datum/json_savefile(PERSISTENT_PHONES_SAVE_PATH)
	phone_savefile.set_entry("taken", persistent_phone_numbers)
	phone_savefile.save()

/datum/controller/subsystem/phones/proc/generate_persistent_number()
	load_persistent_numbers()
	for(var/attempt in 1 to 50)
		var/candidate = random_number()
		if(persistent_phone_numbers[candidate])
			continue
		if(candidate in assigned_phone_numbers)
			continue
		reserve_persistent_number(candidate)
		return candidate
	CRASH("Failed to generate a unique persistent phone number after 50 attempts.")

/datum/preferences
	var/persistent_phone_number = null
	var/list/persistent_contacts = list()

/datum/preferences/load_character(slot)
	. = ..()
	var/tree_key = "character[default_slot]"
	var/list/save_data = savefile.get_entry(tree_key)
	persistent_phone_number = save_data?["persistent_phone_number"]
	persistent_contacts = save_data?["persistent_contacts"] || list()

/datum/preferences/save_character()
	. = ..()
	var/tree_key = "character[default_slot]"
	if(!(tree_key in savefile.get_entry()))
		savefile.set_entry(tree_key, list())
	var/save_data = savefile.get_entry(tree_key)
	save_data["persistent_phone_number"] = persistent_phone_number
	save_data["persistent_contacts"] = persistent_contacts
	savefile.save()

/obj/item/sim_card/proc/apply_persistent_number(new_number)
	SSphones.assigned_phone_numbers.Remove(src)
	phone_number = new_number
	SSphones.assigned_phone_numbers[src] = new_number

/datum/outfit/job/post_equip(mob/living/carbon/human/user, visuals_only = FALSE)
	. = ..()
	if(visuals_only || !user?.client?.ckey || !user?.client?.prefs)
		return
	var/obj/item/smartphone/phone = locate(/obj/item/smartphone) in user
	if(!phone?.sim_card)
		return
	var/datum/preferences/prefs = user.client.prefs
	if(!prefs.persistent_phone_number)
		prefs.persistent_phone_number = SSphones.generate_persistent_number()
		prefs.save_character()
	else
		SSphones.load_persistent_numbers()
		if(!SSphones.persistent_phone_numbers[prefs.persistent_phone_number])
			SSphones.reserve_persistent_number(prefs.persistent_phone_number)
	phone.sim_card.apply_persistent_number(prefs.persistent_phone_number)
	for(var/list/entry in prefs.persistent_contacts)
		var/datum/phonecontact/contact = new()
		contact.name = entry["name"]
		contact.number = entry["number"]
		phone.contacts += contact

/obj/item/smartphone/proc/save_contacts_to_prefs()
	var/mob/living/carbon/human/owner = owner_weakref?.resolve()
	if(!owner?.client?.prefs)
		return
	var/list/network_numbers = list()
	for(var/datum/contact_network/contact_network in contact_networks)
		for(var/datum/contact/network_contact in contact_network.contacts)
			network_numbers[network_contact.number] = TRUE
	var/list/saved_contacts = list()
	for(var/datum/phonecontact/contact in contacts)
		if(!network_numbers[contact.number])
			saved_contacts += list(list("name" = contact.name, "number" = contact.number))
	owner.client.prefs.persistent_contacts = saved_contacts
	owner.client.prefs.save_character()

/obj/item/smartphone/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(. && (action == "add_contact" || action == "remove_contact"))
		save_contacts_to_prefs()

#undef PERSISTENT_PHONES_SAVE_PATH
