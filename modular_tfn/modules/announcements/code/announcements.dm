#define ANNOUNCEMENTS_DATA_FILE "data/tfn_data/announcements_data.json"
#define ANNOUNCEMENTS_CLAN_DATA_DIR "data/tfn_data/announcements/"

// this is largely based on the guide system with endpost style posts
/datum/announcement_tab
	var/name = ""
	var/html_content = ""
	var/author_key = ""
	var/author_name = ""
	var/timestamp = ""

/datum/announcement_manager
	var/list/camarilla_tabs = list()
	var/list/loaded_clan_tabs = list()
	var/post_title_length = 64
	var/post_content_length = 4096

/datum/announcement_manager/New()
	. = ..()
	load_camarilla_announcements()

/datum/announcement_manager/proc/tab_to_list(datum/announcement_tab/tab, can_edit)
	return list(
		"name" = tab.name,
		"html_content" = tab.html_content,
		"author_name" = tab.author_name,
		"timestamp" = tab.timestamp,
		"can_edit" = can_edit ? TRUE : FALSE,
	)

/datum/announcement_manager/proc/save_camarilla_announcements()
	var/list/data = list()
	for(var/datum/announcement_tab/tab as anything in camarilla_tabs)
		data += list(list(
			"name" = tab.name,
			"html_content" = tab.html_content,
			"author_key" = tab.author_key,
			"author_name" = tab.author_name,
			"timestamp" = tab.timestamp,
		))
	if(fexists(ANNOUNCEMENTS_DATA_FILE))
		fdel(ANNOUNCEMENTS_DATA_FILE)
	text2file(json_encode(data), ANNOUNCEMENTS_DATA_FILE)

/datum/announcement_manager/proc/load_camarilla_announcements()
	if(!fexists(ANNOUNCEMENTS_DATA_FILE))
		return
	var/file_data = file2text(ANNOUNCEMENTS_DATA_FILE)
	if(!file_data)
		return
	var/list/data = json_decode(file_data)
	if(!islist(data))
		CRASH("Invalid data in [ANNOUNCEMENTS_DATA_FILE] for announcements! You should probably delete this file to let the server regenerate it, or fix it manually.")
		return
	camarilla_tabs = list()
	for(var/list/entry as anything in data)
		if(!islist(entry))
			continue
		var/datum/announcement_tab/tab = new
		tab.name = entry["name"] || ""
		tab.html_content = entry["html_content"] || ""
		tab.author_key = entry["author_key"] || ""
		tab.author_name = entry["author_name"] || ""
		tab.timestamp = entry["timestamp"] || ""
		camarilla_tabs += tab

/datum/announcement_manager/proc/get_clan_tabs(clan_id)
	if(!clan_id)
		return list()
	if(clan_id in loaded_clan_tabs)
		return loaded_clan_tabs[clan_id]

	var/list/tabs = list()
	var/file_path = "[ANNOUNCEMENTS_CLAN_DATA_DIR][clan_id].json"
	if(fexists(file_path))
		var/file_data = file2text(file_path)
		if(file_data)
			var/list/data = json_decode(file_data)
			if(!islist(data)) // uh oh
				CRASH("Invalid data in [file_path] for announcements. This should be a list!! You should probably delete this file to let the server regenerate it, or fix it manually.")
				return
			for(var/list/entry as anything in data)
				if(!islist(entry))
					continue
				var/datum/announcement_tab/tab = new
				tab.name = entry["name"] || ""
				tab.html_content = entry["html_content"] || ""
				tab.author_key = entry["author_key"] || ""
				tab.timestamp = entry["timestamp"] || ""
				tabs += tab

	loaded_clan_tabs[clan_id] = tabs
	return tabs

/datum/announcement_manager/proc/save_clan_announcements(clan_id)
	if(!clan_id || !(clan_id in loaded_clan_tabs))
		return
	var/list/tabs = loaded_clan_tabs[clan_id]
	var/list/data = list()
	for(var/datum/announcement_tab/tab as anything in tabs)
		data += list(list(
			"name" = tab.name,
			"html_content" = tab.html_content,
			"author_key" = tab.author_key,
			"author_name" = tab.author_name,
			"timestamp" = tab.timestamp,
		))
	var/file_path = "[ANNOUNCEMENTS_CLAN_DATA_DIR][clan_id].json"
	if(fexists(file_path))
		fdel(file_path)
	text2file(json_encode(data), file_path)

/datum/announcement_manager/proc/get_user_clan_id(mob/user)
	if(!isliving(user))
		return null
	var/mob/living/living_user = user
	var/datum/subsplat/vampire_clan/clan = living_user.get_clan()
	if(clan)
		return clan.id
	if(get_ghoul_splat(living_user) && user.client?.prefs)
		return user.client.prefs.read_preference(/datum/preference/choiced/subsplat/vampire_clan)
	return null

/datum/announcement_manager/proc/user_is_primogen(mob/user)
	if(!user.mind?.assigned_role)
		return FALSE
	return findtext("[user.mind.assigned_role.type]", "primogen_") ? TRUE : FALSE

/datum/announcement_manager/proc/user_is_seneschal(mob/user)
	return istype(user.mind?.assigned_role, /datum/job/vampire/clerk) ? TRUE : FALSE

GLOBAL_DATUM(announcements_datum, /datum/announcement_manager)

/proc/get_announcements()
	if(!GLOB.announcements_datum)
		GLOB.announcements_datum = new /datum/announcement_manager()
	return GLOB.announcements_datum

/datum/announcement_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AnnouncementsMenu", "Kindred Announcements & News")
		ui.open()

/datum/announcement_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/announcement_manager/ui_data(mob/user)
	var/is_admin = (user.client && check_rights_for(user.client, R_ADMIN)) ? TRUE : FALSE
	var/is_primogen = user_is_primogen(user)
	var/is_seneschal = user_is_seneschal(user)
	var/user_key = user.client?.ckey
	var/clan_id = get_user_clan_id(user)
	var/datum/subsplat/vampire_clan/clan = get_vampire_clan(clan_id)
	var/clan_name = clan?.name || null

	var/list/camarilla_tab_data = list()
	for(var/datum/announcement_tab/tab as anything in camarilla_tabs)
		var/can_edit = is_admin || ((is_seneschal || is_primogen) && tab.author_key == user_key)
		camarilla_tab_data += list(tab_to_list(tab, can_edit))

	var/list/clan_tab_list = get_clan_tabs(clan_id)
	var/list/clan_tab_data = list()
	for(var/datum/announcement_tab/tab as anything in clan_tab_list)
		var/can_edit = is_admin || (is_primogen && tab.author_key == user_key)
		clan_tab_data += list(tab_to_list(tab, can_edit))

	return list(
		"camarilla_tabs" = camarilla_tab_data,
		"clan_tabs" = clan_tab_data,
		"clan_name" = clan_name,
		"clan_id" = clan_id,
		"can_post_camarilla" = is_admin || is_seneschal,
		"can_post_clan" = is_admin || is_primogen,
		"is_admin" = is_admin,
	)

/datum/announcement_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/is_admin = (ui.user.client && check_rights_for(ui.user.client, R_ADMIN)) ? TRUE : FALSE
	var/is_primogen = user_is_primogen(ui.user)
	var/is_seneschal = user_is_seneschal(ui.user)
	var/user_key = ui.user.client?.ckey

	var/tab_index = params["tab_index"]
	var/which_menu = params["which_menu"]
	var/target_clan_id = params["clan_id"]

	var/list/target_tabs
	if(which_menu == "clan")
		if(!target_clan_id)
			return FALSE
		if(!is_admin && target_clan_id != get_user_clan_id(ui.user))
			return FALSE
		target_tabs = get_clan_tabs(target_clan_id)
	else
		target_tabs = camarilla_tabs

	switch(action)
		if("add_post")
			if(which_menu == "clan")
				if(!is_admin && !is_primogen)
					return FALSE
			else
				if(!is_admin && !is_seneschal)
					return FALSE
			var/post_name = params["name"]
			var/post_content = params["html_content"]
			if(!post_name || !length(post_name))
				return FALSE
			if(length(post_name) > post_title_length || length(post_content) > post_content_length)
				return FALSE
			var/datum/announcement_tab/new_tab = new
			new_tab.name = post_name
			new_tab.html_content = post_content || ""
			new_tab.author_key = user_key
			if(is_admin && length(params["author_name"]))
				new_tab.author_name = params["author_name"]
			else
				new_tab.author_name = ui.user.real_name
			new_tab.timestamp = "[server_timestamp("Day, Month DD, YYYY", ic_time = TRUE)] [server_timestamp("hh:mm", ic_time = TRUE)] AM"
			target_tabs.Insert(1, new_tab)
			if(is_admin)
				log_admin("[key_name(ui.user)] posted announcement '[post_name]' to [which_menu] menu[which_menu == "clan" ? " ([target_clan_id])" : ""]")
				message_admins("[key_name_admin(ui.user)] posted announcement '[post_name]' to [which_menu] menu")
			if(which_menu == "clan")
				save_clan_announcements(target_clan_id)
			else
				save_camarilla_announcements()
			return TRUE
		if("set_content")
			if(!tab_index || tab_index < 1 || tab_index > length(target_tabs))
				return FALSE
			var/datum/announcement_tab/tab = target_tabs[tab_index]
			if(!is_admin)
				if(which_menu == "clan" && (!is_primogen || tab.author_key != user_key))
					return FALSE
				if(which_menu != "clan" && ((!is_seneschal && !is_primogen) || tab.author_key != user_key))
					return FALSE
			var/new_content = params["html_content"]
			if(isnull(new_content) || length(new_content) > post_content_length)
				return FALSE
			tab.html_content = new_content
			if(is_admin)
				log_admin("[key_name(ui.user)] edited announcement '[tab.name]' in [which_menu] menu")
			if(which_menu == "clan")
				save_clan_announcements(target_clan_id)
			else
				save_camarilla_announcements()
			return TRUE
	return FALSE

/client/verb/open_announcements()
	set name = "Announcements"
	set category = "Character"
	set desc = "Open the announcements and news menu."
	if(!get_kindred_splat(mob) && !get_ghoul_splat(mob))
		to_chat(src, span_warning("These announcements are for kindred and ghouls only."))
		return
	var/datum/announcement_manager/announcements_menu = get_announcements()
	announcements_menu.ui_interact(mob)

ADMIN_VERB(edit_announcements, R_ADMIN, "Edit Announcements", "Edit the announcements and news menu", ADMIN_CATEGORY_SERVER)
	var/datum/announcement_manager/announcements_menu = get_announcements()
	announcements_menu.ui_interact(user.mob)

#undef ANNOUNCEMENTS_DATA_FILE
#undef ANNOUNCEMENTS_CLAN_DATA_DIR
