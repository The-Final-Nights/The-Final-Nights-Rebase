// the polycule feature
#define COTERIES_SAVE_PATH "data/tfn_data/coteries.json"

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
	loaded_coterie.phone_numbers = saved["phone_numbers"] || list()
	registry[key] = loaded_coterie
	return loaded_coterie

/datum/coterie_controller/proc/create(key, display_name, leader_ckey, leader_real_name)
	var/datum/coterie/new_coterie = new()
	new_coterie.key = key
	new_coterie.name = display_name
	new_coterie.leader = leader_ckey
	new_coterie.members[leader_ckey] = leader_real_name
	registry[key] = new_coterie
	new_coterie.save_coterie()
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
	var/list/phone_numbers = list()
	COOLDOWN_DECLARE(portrait_cooldown)

/datum/coterie/proc/capture_portrait(mob/target)
	var/icon/flat_icon = getFlatIcon(target, no_anim = TRUE)
	if(!flat_icon)
		return
	portraits[target.client.ckey] = icon2base64(flat_icon)

/datum/coterie/proc/save_coterie()
	var/datum/json_savefile/coterie_savefile = GLOB.coterie_controller.get_savefile()
	coterie_savefile.set_entry(key, list(
		"name" = name,
		"leader" = leader,
		"members" = members.Copy(),
		"portraits" = portraits.Copy(),
		"clan_icons" = clan_icons.Copy(),
		"clan_names" = clan_names.Copy(),
		"join_dates" = join_dates.Copy(),
		"last_seen" = last_seen.Copy(),
		"phone_numbers" = phone_numbers.Copy()
	))
	coterie_savefile.save()

/datum/coterie/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		var/title = user.client?.holder ? "[name] (Admin View)" : name
		ui = new(user, src, "Coterie", title)
		ui.open()

/datum/coterie/ui_state(mob/user)
	return GLOB.always_state

/datum/coterie/ui_data(mob/user)
	var/list/data = list()
	data["name"] = name
	data["leader_name"] = members[leader] || "Unknown"
	data["is_admin"] = !!(user.client?.holder)
	data["is_leader"] = (user.client?.ckey == leader) || !!(user.client?.holder)
	var/viewer_ckey = user.client?.ckey
	data["viewer_name"] = user.real_name
	data["can_retake"] = COOLDOWN_FINISHED(src, portrait_cooldown)
	var/list/member_list = list()
	for(var/member_ckey in members)
		var/is_online = !!(GLOB.directory[member_ckey])
		if(is_online)
			var/client/member_client = GLOB.directory[member_ckey]
			var/needs_save = FALSE
			var/phone = member_client?.prefs?.persistent_phone_number
			if(phone && phone_numbers[member_ckey] != phone)
				phone_numbers[member_ckey] = phone
				needs_save = TRUE
			var/today = server_timestamp("Month DD, YYYY", ic_time = TRUE)
			if(last_seen[member_ckey] != today)
				last_seen[member_ckey] = today
				needs_save = TRUE
			if(needs_save)
				save_coterie()
		member_list += list(list(
			"ckey" = member_ckey,
			"name" = members[member_ckey],
			"clan_icon" = clan_icons[member_ckey],
			"clan_name" = clan_names[member_ckey],
			"join_date" = join_dates[member_ckey],
			"last_seen" = last_seen[member_ckey],
			"phone_number" = phone_numbers[member_ckey],
			"is_online" = is_online,
			"portrait" = portraits[member_ckey],
			"is_viewer" = (member_ckey == viewer_ckey),
			"is_leader" = (member_ckey == leader)
		))
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
			save_coterie()
			SStgui.update_uis(src)
			return TRUE
		if("rename")
			if(leader != usr.client?.ckey && !usr.client?.holder)
				return FALSE
			var/new_name = tgui_input_text(usr, "Enter a new name for your coterie.", "Rename Coterie", name, max_length = 64)
			if(!new_name || !length(new_name))
				return FALSE
			name = new_name
			save_coterie()
			SStgui.update_uis(src)
			return TRUE
		if("invite")
			if(leader != usr.client?.ckey && !usr.client?.holder)
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
			var/datum/subsplat/vampire_clan/target_clan = get_vampire_clan(target.client.prefs.read_preference(/datum/preference/choiced/subsplat/vampire_clan))
			var/datum/subsplat/vampire_clan/displayed_clan = target_clan
			if(target_clan?.hidden)
				var/list/clan_choices = list()
				for(var/clan_name in GLOB.vampire_clan_list)
					var/datum/subsplat/vampire_clan/option = get_vampire_clan(GLOB.vampire_clan_list[clan_name])
					if(option && option.hidden != TRUE) // no, you cannot disguise one shunned clan as another, vampire
						clan_choices += clan_name
				var/chosen_name = tgui_input_list(target, "You have been invited to join a coterie. Your clan will be visible to other members. You may select a clan to display in place of your own, or cancel to decide whether to reveal your true clan.", "Disguise Clan", clan_choices)
				if(!chosen_name)
					var/reveal_response = tgui_alert(target, "You did not choose a disguise. Do you want other members to see that you are Baali?", "Reveal Clan?", list("Yes", "No"))
					if(reveal_response != "Yes")
						to_chat(target, span_notice("You declined the invitation to join [name]."))
						to_chat(usr, span_notice("[target.real_name] declined the invitation to join [name]."))
						return FALSE
				else
					displayed_clan = get_vampire_clan(GLOB.vampire_clan_list[chosen_name])
			var/response = tgui_alert(target, "[usr.real_name] is inviting you to join their coterie. Your character's full name, [target_clan?.hidden ? "disguised clan of [displayed_clan?.name]" : "clan"], phone number, and online status will be visible to other members if you accept.", "Coterie Invitation", list("Accept", "Decline"))
			if(response != "Accept")
				to_chat(target, span_notice("You declined the invitation to join [name]."))
				to_chat(usr, span_notice("[target.real_name] declined the invitation to join [name]."))
				return FALSE
			target.client.prefs.coterie_key = key
			target.client.prefs.save_character()
			target.coterie = src
			members[target.client.ckey] = target.real_name
			clan_icons[target.client.ckey] = displayed_clan?.icon
			clan_names[target.client.ckey] = displayed_clan?.name
			join_dates[target.client.ckey] = server_timestamp("Month DD, YYYY", ic_time = TRUE)
			last_seen[target.client.ckey] = server_timestamp("Month DD, YYYY", ic_time = TRUE)
			phone_numbers[target.client.ckey] = target.client.prefs.persistent_phone_number
			capture_portrait(target)
			save_coterie()
			to_chat(usr, span_notice("[target.real_name] has joined [name]."))
			to_chat(target, span_notice("You joined [name]."))
			return TRUE
		if("kick")
			if(leader != usr.client?.ckey && !usr.client?.holder)
				return FALSE
			var/target_ckey = params["ckey"]
			if(!target_ckey || !members[target_ckey] || target_ckey == leader)
				return FALSE
			var/client/target_client = GLOB.directory[target_ckey]
			if(target_client)
				to_chat(target_client.mob, span_warning("You have been removed from [name]."))
				target_client.mob.coterie = null
				target_client.prefs.coterie_key = null
				target_client.prefs.save_character()
			members -= target_ckey
			portraits -= target_ckey
			clan_icons -= target_ckey
			clan_names -= target_ckey
			join_dates -= target_ckey
			last_seen -= target_ckey
			phone_numbers -= target_ckey
			save_coterie()
			SStgui.update_uis(src)
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
			save_coterie()
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
	mob.coterie.phone_numbers[ckey] = prefs.persistent_phone_number
	mob.coterie.capture_portrait(mob)
	mob.coterie.save_coterie()
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

/datum/coterie_admin_panel

/datum/coterie_admin_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CoterieAdmin", "Admin Coterie Viewer")
		ui.open()

/datum/coterie_admin_panel/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/coterie_admin_panel/ui_data(mob/user)
	var/list/data = list()
	var/list/coterie_list = list()
	for(var/key in GLOB.coterie_controller.registry)
		var/datum/coterie/C = GLOB.coterie_controller.registry[key]
		coterie_list += list(list(
			"key" = key,
			"name" = C.name,
			"leader_name" = C.members[C.leader] || "Unknown",
			"member_count" = length(C.members)
		))
	data["coteries"] = coterie_list
	return data

/datum/coterie_admin_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return .
	switch(action)
		if("open_coterie")
			var/key = params["key"]
			var/datum/coterie/C = GLOB.coterie_controller.registry[key]
			if(!C)
				return FALSE
			C.ui_interact(usr)
			return TRUE

ADMIN_VERB(view_coteries, R_ADMIN, "View Coteries", "View all active coteries.", ADMIN_CATEGORY_SECOND_CITY)
	var/datum/coterie_admin_panel/panel = new()
	panel.ui_interact(user.mob)

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
	if(!coterie.members[client.ckey]) // kicked while offline
		client.prefs.coterie_key = null
		client.prefs.save_character()
		coterie = null
		to_chat(src, span_warning("You have been removed from the coterie while offline."))
		return null
	if(client.ckey && real_name)
		coterie.members[client.ckey] = real_name
		coterie.save_coterie()
	return coterie

#undef COTERIES_SAVE_PATH
