SUBSYSTEM_DEF(title)
	name = "Title Screen"
	wait = 3 SECONDS
	init_stage = INITSTAGE_FIRST

	var/file_path
	var/icon/startup_splash

	/// The current title screen being displayed, as a file path text.
	var/current_title_screen
	/// The current notice text, or null.
	var/current_notice
	/// The preamble html that includes all styling and layout.
	var/title_html
	/// The list of possible title screens to rotate through, as file path texts.
	var/title_screens = list()

	var/expected_startup_messages = 0
	var/received_startup_messages = 0

/datum/controller/subsystem/title/Initialize()
	var/dat
	if(!fexists("[global.config.directory]/tfn/title_html.html"))
		to_chat(world, span_boldwarning("CRITICAL ERROR: Unable to read title_html.html, reverting to backup title html, please check your server config and ensure this file exists."))
		dat = DEFAULT_TITLE_HTML
	else
		dat = file2text("[global.config.directory]/tfn/title_html.html")

	dat = splicetext_char(dat, findtext_char(dat, "</body>"), 0, "") // because vscodium auto adds this shit and its stupid to store html in a txt file
	title_html = dat

	var/list/provisional_title_screens = flist("[global.config.directory]/title_screens/images/")
	var/list/local_title_screens = list()

	for(var/screen in provisional_title_screens)
		var/list/formatted_list = splittext(screen, "+")
		if((LAZYLEN(formatted_list) == 1 && (formatted_list[1] != "exclude" && formatted_list[1] != "blank.png" && formatted_list[1] != "startup_splash")))
			local_title_screens += screen

		if(LAZYLEN(formatted_list) > 1 && LOWER_TEXT(formatted_list[1]) == "startup_splash")
			var/file_path = "[global.config.directory]/title_screens/images/[screen]"
			ASSERT(fexists(file_path))
			startup_splash = new(fcopy_rsc(file_path))

	expected_startup_messages = round(length(Master.subsystems) / 2) // halve the ceiling number since not all have an init message

	if(startup_splash)
		change_title_screen(startup_splash)
	else
		change_title_screen(DEFAULT_TITLE_LOADING_SCREEN)

	if(length(local_title_screens))
		for(var/i in local_title_screens)
			var/file_path = "[global.config.directory]/title_screens/images/[i]"
			ASSERT(fexists(file_path))
			var/icon/title2use = new(fcopy_rsc(file_path))
			title_screens += title2use

	return SS_INIT_SUCCESS

/datum/controller/subsystem/title/Recover()
	startup_splash = SStitle.startup_splash
	file_path = SStitle.file_path

	current_title_screen = SStitle.current_title_screen
	current_notice = SStitle.current_notice
	title_html = SStitle.title_html
	title_screens = SStitle.title_screens

	expected_startup_messages = SStitle.expected_startup_messages
	received_startup_messages = SStitle.received_startup_messages

/datum/controller/subsystem/title/fire(resumed)
	update_tv_info()

/**
 * Show the title screen to all new players.
 */
/datum/controller/subsystem/title/proc/show_title_screen()
	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		INVOKE_ASYNC(new_player, TYPE_PROC_REF(/mob/dead/new_player, show_title_screen))

/**
 * this runs every wait as defined above on the subsystem. probably leave this alone
 */
/datum/controller/subsystem/title/proc/update_tv_info()
	if(!SSticker || SSticker.current_state == GAME_STATE_STARTUP)
		return

	var/tv_params = list2params(list(LAZYLEN(GLOB.clients), LAZYLEN(GLOB.alive_player_list), round_timestamp()))
	for(var/mob/dead/new_player/new_player as anything in GLOB.new_player_list)
		if(!new_player.title_screen_is_ready || isnull(new_player.client) || new_player.client.interviewee)
			continue
		new_player.client << output(tv_params, "tfn_title_browser:update_tv_info")

/**
 * Adds a notice to the main title screen in the form of big red text!
 */
/datum/controller/subsystem/title/proc/set_notice(new_title)
	current_notice = new_title ? sanitize_text(new_title) : null
	show_title_screen()

/**
 * Changes the title screen to a new image.
 */
/datum/controller/subsystem/title/proc/change_title_screen(new_screen)
	if(new_screen)
		current_title_screen = new_screen
	else
		if(LAZYLEN(title_screens))
			current_title_screen = pick(title_screens)
		else
			current_title_screen = DEFAULT_TITLE_SCREEN_IMAGE

	show_title_screen()

/**
 * Update a user's character setup name.
 * Arguments:
 * * user - The user being updated
 * * name - the real name of the current slot.
 */
/datum/controller/subsystem/title/proc/update_character_name(mob/dead/new_player/user, name)
	if(!(istype(user) && user.title_screen_is_ready))
		return

	user.client << output(name, "tfn_title_browser:update_current_character")

/**
 * Adds a startup message to the splashscreen.
 *
 * Arguments:
 * * msg - the message to show users.
 * * warning - optional: TRUE to indicate this is an error/warning
 */
/proc/add_startup_message(msg, warning)
	// HTML displayed to user
	var/msg_html = {"<p class="terminal_text">[warning ? "☒ " : ""][msg]</p>"}

	GLOB.startup_messages += msg_html

	SStitle.received_startup_messages = min(SStitle.received_startup_messages + 1, SStitle.expected_startup_messages)

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		if(!new_player.title_screen_is_ready)
			continue

		new_player.client << output(msg_html, "tfn_title_browser:append_terminal_text")
		new_player.client << output(list2params(list(SStitle.received_startup_messages, SStitle.expected_startup_messages)), "tfn_title_browser:update_loading_progress")
