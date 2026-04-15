// the new player guide
// editable ingame by staff
// coming to a character setup screen near you
#define GUIDE_DATA_FILE "data/guide_data.json"

/datum/guide_tab
	var/name = "Welcome"
	var/html_content = "If you can read this, tell Nimi."

/datum/guide_manager
	var/list/tabs = list()
	var/section_name_length = 64

/datum/guide_manager/New()
	. = ..()
	load_from_file()
	if(!length(tabs))
		var/datum/guide_tab/default_tab = new
		default_tab.name = "Welcome"
		default_tab.html_content = "If you can read this, tell Nimi."
		tabs += default_tab

/datum/guide_manager/proc/save_to_file()
	var/list/data = list()
	for(var/datum/guide_tab/tab as anything in tabs)
		data += list(list(
			"name" = tab.name,
			"html_content" = tab.html_content,
		))
	if(fexists(GUIDE_DATA_FILE))
		fdel(GUIDE_DATA_FILE) // without fdel, it just appends new stuff infinitely
	text2file(json_encode(data), GUIDE_DATA_FILE)

/datum/guide_manager/proc/load_from_file()
	if(!fexists(GUIDE_DATA_FILE))
		return
	var/raw = file2text(GUIDE_DATA_FILE)
	if(!raw)
		return
	var/list/data = json_decode(raw)
	if(!islist(data))
		return
	tabs = list()
	for(var/list/entry as anything in data)
		if(!islist(entry))
			continue
		var/datum/guide_tab/tab = new
		tab.name = entry["name"] || "Unnamed"
		tab.html_content = entry["html_content"] || ""
		tabs += tab

// woe, globals upon ye
var/datum/guide_manager/guide_datum
/proc/get_guide()
	if(!guide_datum)
		guide_datum = new /datum/guide_manager()
	return guide_datum

/datum/guide_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "GuideMenu", "Guide")
		ui.open()

/datum/guide_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/guide_manager/ui_data(mob/user)
	var/is_admin = user.client && check_rights_for(user.client, R_ADMIN)
	var/show_on_spawn = user.client && user.client.prefs && user.client.prefs.show_new_player_guide
	var/list/tab_data = list()
	for(var/datum/guide_tab/tab as anything in tabs)
		tab_data += list(list(
			"name" = tab.name,
			"html_content" = tab.html_content,
		))
	return list(
		"tabs" = tab_data,
		"is_admin" = is_admin,
		"show_on_spawn" = show_on_spawn,
	)

/datum/guide_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(action == "toggle_show_on_spawn")
		if(ui.user.client && ui.user.client.prefs)
			ui.user.client.prefs.show_new_player_guide = !ui.user.client.prefs.show_new_player_guide
			ui.user.client.prefs.save_preferences()
		var/status = ui.user.client.prefs.show_new_player_guide ? "now see" : "no longer see"
		var/additional_text = !ui.user.client.prefs.show_new_player_guide ? "You can view it at any time via the Guide verb in the OOC tab." : ""
		to_chat(ui.user, span_notice("You will [status] the new player guide on login. [additional_text]"))
		return TRUE

	if(!ui.user.client || !check_rights_for(ui.user.client, R_ADMIN))
		return FALSE

	var/tab_index = params["tab_index"]

	switch(action)
		if("add_tab")
			var/new_name = tgui_input_text(ui.user, "Enter a name for the new section.", "Add Section", "New Section", max_length = section_name_length)
			if(!new_name || !length(new_name))
				return FALSE
			var/datum/guide_tab/new_tab = new
			new_tab.name = new_name
			new_tab.html_content = "<p>Section content goes here.</p>"
			tabs += new_tab
			log_admin("[key_name(ui.user)] added guide section: [new_name]")
			message_admins("[key_name_admin(ui.user)] added guide section: [new_name]")
			save_to_file()
			return TRUE

		if("rename_tab")
			if(!tab_index || tab_index < 1 || tab_index > length(tabs))
				return FALSE
			var/datum/guide_tab/tab = tabs[tab_index]
			var/new_name = tgui_input_text(ui.user, "Enter a new name for this section.", "Rename Section", tab.name, max_length = section_name_length)
			if(!new_name || !length(new_name))
				return FALSE
			log_admin("[key_name(ui.user)] renamed guide section '[tab.name]' to '[new_name]'")
			message_admins("[key_name_admin(ui.user)] renamed guide section '[tab.name]' to '[new_name]'")
			tab.name = new_name
			save_to_file()
			return TRUE

		if("delete_tab")
			if(!tab_index || tab_index < 1 || tab_index > length(tabs))
				return FALSE
			var/datum/guide_tab/tab = tabs[tab_index]
			var/confirm = tgui_alert(ui.user, "Are you sure you want to delete '[tab.name]'?", "Delete Section", list("Yes", "No"))
			if(confirm != "Yes")
				return FALSE
			log_admin("[key_name(ui.user)] deleted guide section: [tab.name]")
			message_admins("[key_name_admin(ui.user)] deleted guide section: [tab.name]")
			tabs -= tab
			qdel(tab)
			save_to_file()
			return TRUE

		if("set_content")
			if(!tab_index || tab_index < 1 || tab_index > length(tabs))
				return FALSE
			var/datum/guide_tab/tab = tabs[tab_index]
			var/new_content = params["html_content"]
			if(isnull(new_content))
				return FALSE
			tab.html_content = new_content
			log_admin("[key_name(ui.user)] edited guide section content: [tab.name]")
			save_to_file()
			return TRUE

		if("move_tab")
			if(!tab_index || tab_index < 1 || tab_index > length(tabs))
				return FALSE
			var/direction = params["direction"]
			if(direction == "up" && tab_index > 1)
				var/datum/guide_tab/tab = tabs[tab_index]
				tabs.Remove(tab)
				tabs.Insert(tab_index - 1, tab)
				save_to_file()
				return TRUE

			if(direction == "down" && tab_index < length(tabs))
				var/datum/guide_tab/tab = tabs[tab_index]
				tabs.Remove(tab)
				tabs.Insert(tab_index + 1, tab)
				save_to_file()
				return TRUE

	return FALSE

/client/verb/open_guide()
	set name = "Guide"
	set category = "OOC"
	set desc = "Open the player guide."
	var/datum/guide_manager/guide = get_guide()
	guide.ui_interact(mob)

ADMIN_VERB(edit_guide, R_ADMIN, "Edit Guide", "Edit the server guide window", ADMIN_CATEGORY_SERVER)
	var/datum/guide_manager/guide = get_guide()
	guide.ui_interact(user.mob)

/mob/living/Login()
	. = ..()
	if(client?.prefs?.show_new_player_guide)
		var/datum/guide_manager/guide = get_guide()
		guide.ui_interact(src)

/datum/preferences
	var/show_new_player_guide = TRUE

/datum/preferences/load_preferences()
	. = ..()
	show_new_player_guide = savefile.get_entry("show_new_player_guide")

/datum/preferences/save_preferences()
	. = ..()
	savefile.set_entry("show_new_player_guide", show_new_player_guide)

#undef GUIDE_DATA_FILE
