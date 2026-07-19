#define ANNOUNCEMENTS_DATA_FILE "data/tfn_data/announcements_data.json"
#define ANNOUNCEMENTS_CLAN_DATA_DIR "data/tfn_data/announcements/"
#define ANNOUNCEMENTS_DEPT_DATA_DIR "data/tfn_data/announcements/jobs/dept_"

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
	var/list/loaded_dept_tabs = list()
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
	for(var/datum/announcement_tab/tab in camarilla_tabs)
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
	camarilla_tabs = list()
	for(var/list/entry in data)
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
			for(var/list/entry in data)
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
	for(var/datum/announcement_tab/tab in tabs)
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

/datum/announcement_manager/proc/get_dept_tabs(dept_id)
	if(!dept_id)
		return list()
	if(dept_id in loaded_dept_tabs)
		return loaded_dept_tabs[dept_id]
	var/list/tabs = list()
	var/file_path = "[ANNOUNCEMENTS_DEPT_DATA_DIR][dept_id].json"
	if(fexists(file_path))
		var/file_data = file2text(file_path)
		if(file_data)
			var/list/data = json_decode(file_data)
			if(!islist(data))
				CRASH("Invalid data in [file_path] for announcements. This should be a list!! You should probably delete this file to let the server regenerate it, or fix it manually.")
			for(var/list/entry in data)
				if(!islist(entry))
					continue
				var/datum/announcement_tab/tab = new
				tab.name = entry["name"] || ""
				tab.html_content = entry["html_content"] || ""
				tab.author_key = entry["author_key"] || ""
				tab.author_name = entry["author_name"] || ""
				tab.timestamp = entry["timestamp"] || ""
				tabs += tab
	loaded_dept_tabs[dept_id] = tabs
	return tabs

/datum/announcement_manager/proc/save_dept_announcements(dept_id)
	if(!dept_id || !(dept_id in loaded_dept_tabs))
		return
	var/list/tabs = loaded_dept_tabs[dept_id]
	var/list/data = list()
	for(var/datum/announcement_tab/tab in tabs)
		data += list(list(
			"name" = tab.name,
			"html_content" = tab.html_content,
			"author_key" = tab.author_key,
			"author_name" = tab.author_name,
			"timestamp" = tab.timestamp,
		))
	var/file_path = "[ANNOUNCEMENTS_DEPT_DATA_DIR][dept_id].json"
	if(fexists(file_path))
		fdel(file_path)
	text2file(json_encode(data), file_path)

/datum/announcement_manager/proc/get_user_dept_id(mob/user)
	if(!user.mind?.assigned_role)
		return null
	var/dept_type = user.mind.assigned_role.department_for_prefs
	if(!dept_type)
		return null
	var/dept_type_str = "[dept_type]"
	var/last_slash = findlasttext(dept_type_str, "/")
	return copytext(dept_type_str, last_slash + 1)

/datum/announcement_manager/proc/user_is_dept_head(mob/user)
	if(!user.mind?.assigned_role)
		return FALSE
	var/dept_type = user.mind.assigned_role.department_for_prefs
	if(!dept_type)
		return FALSE
	var/datum/job_department/dept = SSjob.joinable_departments_by_type[dept_type]
	if(!dept?.department_head)
		return FALSE
	return istype(user.mind.assigned_role, dept.department_head) ? TRUE : FALSE

/datum/announcement_manager/proc/send_announcement_webhook(mob/user, datum/announcement_tab/tab, which_menu, clan_id)
	var/webhook
	if(which_menu == "clan" && clan_id)
		var/entry_type = text2path("/datum/config_entry/string/announcements_webhook_[filter_clan_id(clan_id)]")
		if(entry_type)
			webhook = global.config.Get(entry_type)
	else
		webhook = CONFIG_GET(string/announcements_webhook)
	if(!webhook)
		return

	var/datum/discord_embed/embed = new()
	embed.title = tab.name
	var/body = "[tab.author_name]\n[tab.timestamp]\n\n[tab.html_content]"
	embed.description = body

	var/list/webhook_info = list()
	webhook_info["embeds"] = list(embed.convert_to_list())

	var/list/headers = list()
	headers["Content-Type"] = "application/json"
	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_POST, webhook, json_encode(webhook_info), headers, "tmp/response.json")
	request.begin_async()

// some clans have multiple subtypes that need to use the same announcement feed
/datum/announcement_manager/proc/filter_clan_id(clan_id)
	switch(clan_id)
		if(VAMPIRE_CLAN_DOMINATE_MALKAVIAN)
			return VAMPIRE_CLAN_MALKAVIAN
		if(VAMPIRE_CLAN_BANU_HAQIM_VIZIER)
			return VAMPIRE_CLAN_BANU_HAQIM
		if(VAMPIRE_CLAN_WARRIOR_SALUBRI)
			return VAMPIRE_CLAN_HEALER_SALUBRI
	return clan_id

/datum/announcement_manager/proc/get_user_clan_id(mob/living/user)
	var/datum/subsplat/vampire_clan/clan = user.get_clan()
	if(get_ghoul_splat(user) && user.client?.prefs)
		return filter_clan_id(user.client.prefs.read_preference(/datum/preference/choiced/subsplat/vampire_clan))
	if(clan)
		return filter_clan_id(clan.id)
	return null

/datum/announcement_manager/proc/user_is_primogen(mob/user)
	if(!user.mind?.assigned_role)
		return FALSE
	return findtext("[user.mind.assigned_role.type]", "primogen_") ? TRUE : FALSE

/datum/announcement_manager/proc/user_is_seneschal(mob/user)
	return istype(user.mind?.assigned_role, /datum/job/vampire/clerk) ? TRUE : FALSE

/datum/announcement_manager/proc/user_is_tremere_regent(mob/user)
	return istype(user.mind?.assigned_role, /datum/job/vampire/regent) ? TRUE : FALSE

/datum/announcement_manager/proc/user_is_elder(mob/living/carbon/human/user) // let the old heads post clan announcements, too
	if(!get_kindred_splat(user))
		return FALSE
	return (user.chronological_age >= 200) ? TRUE : FALSE

GLOBAL_DATUM(announcements_datum, /datum/announcement_manager)

/proc/get_announcements()
	if(!GLOB.announcements_datum)
		GLOB.announcements_datum = new /datum/announcement_manager()
	return GLOB.announcements_datum

/datum/announcement_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AnnouncementsMenu", "(IC) Announcements")
		ui.open()

/datum/announcement_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/announcement_manager/ui_data(mob/user)
	var/is_admin = (user.client && check_rights_for(user.client, R_ADMIN)) ? TRUE : FALSE
	var/is_primogen = user_is_primogen(user)
	var/is_seneschal = user_is_seneschal(user)
	var/is_regent = user_is_tremere_regent(user)
	var/is_elder = user_is_elder(user)
	var/user_key = user.client?.ckey
	var/clan_id = get_user_clan_id(user)
	var/datum/subsplat/vampire_clan/clan = get_vampire_clan(clan_id)
	var/clan_name = clan?.name || null
	var/show_kindred_tabs = is_admin || !!get_kindred_splat(user) || !!get_ghoul_splat(user)

	var/list/camarilla_tab_data = list()
	for(var/datum/announcement_tab/tab in camarilla_tabs)
		var/can_edit = is_admin || ((is_seneschal || is_primogen) && tab.author_key == user_key)
		camarilla_tab_data += list(tab_to_list(tab, can_edit))

	var/list/clan_tab_list = get_clan_tabs(clan_id)
	var/list/clan_tab_data = list()
	for(var/datum/announcement_tab/tab in clan_tab_list)
		var/can_edit = is_admin || ((is_primogen || is_regent || is_elder) && tab.author_key == user_key)
		clan_tab_data += list(tab_to_list(tab, can_edit))

	var/list/all_clan_tab_data = list()
	if(is_admin)
		for(var/clan_type in GLOB.vampire_clans)
			var/datum/subsplat/vampire_clan/c = GLOB.vampire_clans[clan_type]
			if(!c.id)
				continue
			if(filter_clan_id(c.id) != c.id)
				continue
			var/list/c_tab_list = get_clan_tabs(c.id)
			var/list/c_posts = list()
			for(var/datum/announcement_tab/tab in c_tab_list)
				c_posts += list(tab_to_list(tab, TRUE))
			all_clan_tab_data += list(list(
				"clan_id" = c.id,
				"clan_name" = c.name,
				"posts" = c_posts,
			))

	var/dept_id = get_user_dept_id(user)
	var/dept_name
	if(dept_id && user.mind?.assigned_role)
		var/dept_type = user.mind.assigned_role.department_for_prefs
		var/datum/job_department/dept_datum = SSjob.joinable_departments_by_type[dept_type]
		dept_name = dept_datum?.department_name

	var/list/dept_tab_list = get_dept_tabs(dept_id)
	var/list/dept_tab_data = list()
	for(var/datum/announcement_tab/tab in dept_tab_list)
		var/can_edit = is_admin || tab.author_key == user_key
		dept_tab_data += list(tab_to_list(tab, can_edit))

	var/list/all_dept_tab_data = list()
	if(is_admin)
		for(var/dept_type_key in SSjob.joinable_departments_by_type)
			var/datum/job_department/dept_entry = SSjob.joinable_departments_by_type[dept_type_key]
			if(!dept_entry.display_order) // dont include jobs that dont appear as selectable
				continue
			var/dept_type_str = "[dept_type_key]"
			var/dept_entry_id = copytext(dept_type_str, findlasttext(dept_type_str, "/") + 1)
			var/list/dept_entry_tabs = get_dept_tabs(dept_entry_id)
			var/list/dept_entry_posts = list()
			for(var/datum/announcement_tab/tab in dept_entry_tabs)
				dept_entry_posts += list(tab_to_list(tab, TRUE))
			all_dept_tab_data += list(list(
				"dept_id" = dept_entry_id,
				"dept_name" = dept_entry.department_name,
				"posts" = dept_entry_posts,
			))

	return list(
		"camarilla_tabs" = camarilla_tab_data,
		"clan_tabs" = clan_tab_data,
		"clan_name" = clan_name,
		"clan_id" = clan_id,
		"all_clan_tabs" = all_clan_tab_data,
		"dept_tabs" = dept_tab_data,
		"dept_name" = dept_name,
		"dept_id" = dept_id,
		"all_dept_tabs" = all_dept_tab_data,
		"can_post_camarilla" = is_admin || is_seneschal,
		"can_post_clan" = is_admin || is_primogen || is_regent || is_elder,
		"can_post_dept" = is_admin || user_is_dept_head(user),
		"show_kindred_tabs" = show_kindred_tabs,
		"is_admin" = is_admin,
	)

/datum/announcement_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/is_admin = (ui.user.client && check_rights_for(ui.user.client, R_ADMIN)) ? TRUE : FALSE
	var/is_primogen = user_is_primogen(ui.user)
	var/is_seneschal = user_is_seneschal(ui.user)
	var/is_regent = user_is_tremere_regent(ui.user)
	var/is_elder = user_is_elder(ui.user)
	var/user_key = ui.user.client?.ckey

	var/tab_index = params["tab_index"]
	var/which_menu = params["which_menu"]
	var/target_clan_id = params["clan_id"]
	var/target_dept_id = params["dept_id"]

	var/list/target_tabs
	if(which_menu == "clan")
		if(!target_clan_id)
			return FALSE
		if(!is_admin && target_clan_id != get_user_clan_id(ui.user))
			return FALSE
		target_tabs = get_clan_tabs(target_clan_id)
	else if(which_menu == "department")
		if(!target_dept_id)
			return FALSE
		if(!is_admin && target_dept_id != get_user_dept_id(ui.user))
			return FALSE
		target_tabs = get_dept_tabs(target_dept_id)
	else
		target_tabs = camarilla_tabs

	switch(action)
		if("add_post")
			if(which_menu == "clan")
				if(!is_admin && !is_primogen && !is_regent && !is_elder)
					return FALSE
			else if(which_menu == "department")
				if(!is_admin && !user_is_dept_head(ui.user))
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
			new_tab.timestamp = "[server_timestamp("Day, Month DD, YYYY", ic_time = TRUE)]"
			target_tabs.Insert(1, new_tab)
			var/menu_context = which_menu == "clan" ? " ([target_clan_id])" : which_menu == "department" ? " ([target_dept_id])" : ""
			var/post_log = "[key_name(ui.user)] posted announcement '[post_name]' to [which_menu] menu[menu_context]\n\n [post_content]"
			if(is_admin)
				log_admin(post_log)
				message_admins("[key_name_admin(ui.user)] posted announcement '[post_name]' to [which_menu] menu")
			SSoverwatch.record_action(ui.user, post_log)
			if(which_menu == "clan")
				save_clan_announcements(target_clan_id)
			else if(which_menu == "department")
				save_dept_announcements(target_dept_id)
			else
				save_camarilla_announcements()
			if(which_menu != "department") // because i dont feel like making a bunch of more channels and webhooks right now
				send_announcement_webhook(ui.user, new_tab, which_menu, target_clan_id)
			return TRUE
		if("set_content")
			if(!tab_index || tab_index < 1 || tab_index > length(target_tabs))
				return FALSE
			var/datum/announcement_tab/tab = target_tabs[tab_index]
			if(!is_admin)
				if(which_menu == "clan" && ((!is_primogen && !is_regent && !is_elder) || tab.author_key != user_key))
					return FALSE
				if(which_menu == "department" && tab.author_key != user_key)
					return FALSE
				if(which_menu != "clan" && which_menu != "department" && ((!is_seneschal && !is_primogen) || tab.author_key != user_key))
					return FALSE
			var/new_content = params["html_content"]
			if(isnull(new_content) || length(new_content) > post_content_length)
				return FALSE
			tab.html_content = new_content
			if(is_admin)
				log_admin("[key_name(ui.user)] edited announcement '[tab.name]' in [which_menu] menu")
			if(which_menu == "clan")
				save_clan_announcements(target_clan_id)
			else if(which_menu == "department")
				save_dept_announcements(target_dept_id)
			else
				save_camarilla_announcements()
			return TRUE
	return FALSE

/client/verb/open_announcements()
	set name = "Announcements"
	set category = "Character"
	set desc = "Open the announcements and news menu."
	if(!istype(mob, /mob/living/carbon/human)) // observers must join the round to view the announcements ingame
		to_chat(src, "You must join the round to view the announcements menu.")
		return
	var/datum/announcement_manager/announcements_menu = get_announcements()
	announcements_menu.ui_interact(mob)

ADMIN_VERB(edit_announcements, R_ADMIN, "Edit Announcements", "Edit the announcements and news menu", ADMIN_CATEGORY_SERVER)
	var/datum/announcement_manager/announcements_menu = get_announcements()
	announcements_menu.ui_interact(user.mob)

#undef ANNOUNCEMENTS_DATA_FILE
#undef ANNOUNCEMENTS_CLAN_DATA_DIR
#undef ANNOUNCEMENTS_DEPT_DATA_DIR
