// the polycule feature
#define COTERIES_SAVE_PATH "data/coteries.json"

GLOBAL_DATUM_INIT(coterie_controller, /datum/coterie_controller, new())

/datum/coterie_controller
	var/list/registry = list()
	var/datum/json_savefile/savefile

/datum/coterie_controller/proc/get_savefile()
	if(!savefile)
		savefile = new /datum/json_savefile(COTERIES_SAVE_PATH)
	return savefile

/datum/coterie_controller/proc/get(key)
	if(!key)
		return null
	if(registry[key])
		return registry[key]
	var/datum/json_savefile/coterie_savefile = get_savefile()
	var/list/saved = coterie_savefile.get_entry(key)
	if(!saved)
		return null
	var/datum/coterie/loaded_coterie = new()
	loaded_coterie.key = key
	loaded_coterie.name = saved["name"]
	loaded_coterie.leader = saved["leader"]
	loaded_coterie.members = saved["members"] || list()
	loaded_coterie.portraits = saved["portraits"] || list()
	loaded_coterie.clan_icons = saved["clan_icons"] || list()
	loaded_coterie.clan_names = saved["clan_names"] || list()
	loaded_coterie.join_dates = saved["join_dates"] || list()
	loaded_coterie.last_seen = saved["last_seen"] || list()
	registry[key] = loaded_coterie
	return loaded_coterie

/datum/coterie_controller/proc/create(key, display_name, leader_ckey, leader_real_name)
	var/datum/coterie/new_coterie = new()
	new_coterie.key = key
	new_coterie.name = display_name
	new_coterie.leader = leader_ckey
	new_coterie.members[leader_ckey] = leader_real_name
	registry[key] = new_coterie
	new_coterie.save()
	return new_coterie

/datum/preferences
	var/coterie_key = null

/datum/preferences/load_character(slot)
	. = ..()
	var/tree_key = "character[default_slot]"
	var/list/save_data = savefile.get_entry(tree_key)
	coterie_key = save_data?["coterie_key"]

/datum/preferences/save_character()
	. = ..()
	var/tree_key = "character[default_slot]"
	if(!(tree_key in savefile.get_entry()))
		savefile.set_entry(tree_key, list())
	var/save_data = savefile.get_entry(tree_key)
	save_data["coterie_key"] = coterie_key
	savefile.save()

/datum/coterie
	var/key = null // acts as kinda a unique id
	var/name = "Unnamed Coterie"
	var/leader = null
	var/list/members = list()
	var/list/portraits = list()
	var/list/clan_icons = list()
	var/list/clan_names = list()
	var/list/join_dates = list()
	var/list/last_seen = list()
	COOLDOWN_DECLARE(portrait_cooldown)

/datum/coterie/proc/capture_portrait(mob/target)
	var/icon/flat_icon = getFlatIcon(target, no_anim = TRUE)
	if(!flat_icon)
		return
	portraits[target.client.ckey] = icon2base64(flat_icon)

/datum/coterie/proc/save()
	var/datum/json_savefile/coterie_savefile = GLOB.coterie_controller.get_savefile()
	coterie_savefile.set_entry(key, list(
		"name" = name,
		"leader" = leader,
		"members" = members.Copy(),
		"portraits" = portraits.Copy(),
		"clan_icons" = clan_icons.Copy(),
		"clan_names" = clan_names.Copy(),
		"join_dates" = join_dates.Copy(),
		"last_seen" = last_seen.Copy()
	))
	coterie_savefile.save()

/datum/coterie/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Coterie", name)
		ui.open()

/datum/coterie/ui_state(mob/user)
	return GLOB.always_state

/datum/coterie/ui_data(mob/user)
	var/list/data = list()
	data["name"] = name
	data["leader_name"] = members[leader] || "Unknown"
	data["is_leader"] = user.client?.ckey == leader
	var/viewer_ckey = user.client?.ckey
	data["viewer_name"] = user.real_name
	data["can_retake"] = COOLDOWN_FINISHED(src, portrait_cooldown)
	var/list/member_list = list()
	var/needs_save = FALSE
	for(var/member_ckey in members)
		var/is_online = !!(GLOB.directory[member_ckey])
		if(is_online)
			last_seen[member_ckey] = server_timestamp("Month DD, YYYY", ic_time = TRUE)
			needs_save = TRUE
		member_list += list(list(
			"name" = members[member_ckey],
			"clan_icon" = clan_icons[member_ckey],
			"clan_name" = clan_names[member_ckey],
			"join_date" = join_dates[member_ckey],
			"last_seen" = last_seen[member_ckey],
			"is_online" = is_online,
			"portrait" = portraits[member_ckey],
			"is_viewer" = (member_ckey == viewer_ckey)
		))
	if(needs_save)
		save()
	data["members"] = member_list
	return data

/datum/coterie/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return .
	switch(action)
		if("retake_headshot")
			var/user_ckey = usr.client?.ckey
			if(!members[user_ckey])
				return FALSE
			if(!COOLDOWN_FINISHED(src, portrait_cooldown))
				to_chat(usr, span_warning("You may only change your headshot once per minute."))
				return FALSE
			capture_portrait(usr)
			COOLDOWN_START(src, portrait_cooldown, 1 MINUTES)
			save()
			SStgui.update_uis(src)
			return TRUE
		if("rename")
			if(leader != usr.client?.ckey)
				return FALSE
			var/new_name = tgui_input_text(usr, "Enter a new name for your coterie.", "Rename Coterie", name, max_length = 64)
			if(!new_name || !length(new_name))
				return FALSE
			name = new_name
			save()
			SStgui.update_uis(src)
			return TRUE
		if("invite")
			if(leader != usr.client?.ckey)
				return FALSE
			var/list/nearby_mobs = list()
			for(var/mob/living/carbon/human/nearby_mob in oview(7, usr))
				if(nearby_mob.client && nearby_mob != usr && get_vampire_splat(nearby_mob))
					nearby_mobs += nearby_mob
			if(!length(nearby_mobs))
				to_chat(usr, span_warning("Noone nearby is eligible to join the coterie."))
				return FALSE
			var/mob/living/carbon/human/target = tgui_input_list(usr, "Who do you want to invite?", "Invite to Coterie", nearby_mobs)
			if(!target?.client)
				return FALSE
			var/response = tgui_alert(target, "[usr.real_name] is inviting you to join their coterie. Your character's full name, clan, phone number, and online status will be visible to other members if you accept.", "Coterie Invitation", list("Accept", "Decline"))
			if(response != "Accept")
				return FALSE
			target.client.prefs.coterie_key = key
			target.client.prefs.save_character()
			target.coterie = src
			members[target.client.ckey] = target.real_name
			var/datum/subsplat/vampire_clan/target_clan = get_vampire_clan(target.client.prefs.read_preference(/datum/preference/choiced/subsplat/vampire_clan))
			clan_icons[target.client.ckey] = target_clan?.icon
			clan_names[target.client.ckey] = target_clan?.name
			join_dates[target.client.ckey] = server_timestamp("Month DD, YYYY", ic_time = TRUE)
			last_seen[target.client.ckey] = server_timestamp("Month DD, YYYY", ic_time = TRUE)
			capture_portrait(target)
			save()
			to_chat(usr, span_notice("[target.real_name] has joined [name]."))
			to_chat(target, span_notice("You joined [name]."))
			return TRUE
		if("leave")
			if(leader == usr.client?.ckey)
				var/response = tgui_alert(usr, "You are the leader. Leaving will disband [name] for all members. Are you sure?", "Disband Coterie", list("Disband", "Cancel"))
				if(response != "Disband")
					return FALSE
				for(var/member_ckey in members)
					var/client/member_client = GLOB.directory[member_ckey]
					if(member_client)
						to_chat(member_client.mob, span_warning("[name] has been disbanded."))
						member_client.mob.coterie = null
						member_client.prefs.coterie_key = null
						member_client.prefs.save_character()
				var/datum/json_savefile/coterie_savefile = GLOB.coterie_controller.get_savefile()
				coterie_savefile.remove_entry(key)
				coterie_savefile.save()
				GLOB.coterie_controller.registry -= key
				SStgui.close_uis(src)
				return TRUE
			members -= usr.client?.ckey
			save()
			usr.coterie = null
			usr.client.prefs.coterie_key = null
			usr.client.prefs.save_character()
			to_chat(usr, span_notice("You have left [name]."))
			SStgui.close_user_uis(usr, src)
			return TRUE

/client/verb/create_coterie()
	set name = "Create Coterie"
	set category = "Character"
	set desc = "Form a new coterie."

	if(!get_vampire_splat(mob))
		to_chat(mob, span_warning("Only kindred and ghouls may form a coterie."))
		return

	if(mob.get_coterie())
		to_chat(mob, span_warning("You are already in a coterie."))
		return

	var/coterie_key = "[ckey]_[prefs.default_slot]"
	var/display_name = "[splittext(mob.real_name, " ")[1]]'s Coterie"
	mob.coterie = GLOB.coterie_controller.create(coterie_key, display_name, ckey, mob.real_name)
	var/datum/subsplat/vampire_clan/clan = get_vampire_clan(prefs.read_preference(/datum/preference/choiced/subsplat/vampire_clan))
	mob.coterie.clan_icons[ckey] = clan?.icon
	mob.coterie.clan_names[ckey] = clan?.name
	mob.coterie.join_dates[ckey] = server_timestamp("Month DD, YYYY", ic_time = TRUE)
	mob.coterie.last_seen[ckey] = server_timestamp("Month DD, YYYY", ic_time = TRUE)
	mob.coterie.capture_portrait(mob)
	mob.coterie.save()
	prefs.coterie_key = coterie_key
	prefs.save_character()
	mob.coterie.ui_interact(mob)

/client/verb/view_coterie()
	set name = "View Coterie"
	set category = "Character"
	set desc = "View coterie information."
	var/datum/coterie/coterie = mob.get_coterie()
	if(!coterie)
		to_chat(mob, span_warning("You are not in a coterie."))
		return
	coterie.ui_interact(mob)

/mob
	var/datum/coterie/coterie = null

/mob/proc/get_coterie()
	if(coterie)
		return coterie
	if(!client?.prefs?.coterie_key)
		return null
	coterie = GLOB.coterie_controller.get(client.prefs.coterie_key)
	if(!coterie)
		if(client.prefs.coterie_key)
			client.prefs.coterie_key = null
			client.prefs.save_character()
		return null
	if(client.ckey && real_name)
		coterie.members[client.ckey] = real_name
		coterie.save()
	return coterie
