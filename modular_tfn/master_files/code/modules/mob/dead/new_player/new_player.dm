/mob/dead/new_player
	var/title_screen_is_ready = FALSE

/mob/dead/new_player/Topic(href, href_list[])
	if(src != usr)
		return

	if(!client)
		return

	if(client.interviewee)
		return FALSE

	if(href_list["observe"])
		play_lobby_button_sound()
		make_me_an_observer()
		return

	if(href_list["view_manifest"])
		play_lobby_button_sound()
		ViewManifest()
		return

	if(href_list["character_setup"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
		preferences.update_static_data(src)
		preferences.ui_interact(src)
		return

	if(href_list["game_options"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_GAME_PREFERENCES
		preferences.update_static_data(usr)
		preferences.ui_interact(usr)
		return

	if(href_list["toggle_ready"])
		if(SSticker && SSticker.current_state > GAME_STATE_PREGAME)
			to_chat(src, span_notice("It's too late for that, the round is already starting!"))
			return
		play_lobby_button_sound()

		if(ready == PLAYER_NOT_READY)
			auto_deadmin_on_ready_or_latejoin()
			ready = PLAYER_READY_TO_PLAY
		else
			ready = PLAYER_NOT_READY

		client << output((ready == PLAYER_READY_TO_PLAY) ? 1 : 0, "tfn_title_browser:toggle_ready")
		return

	if(href_list["late_join"])
		play_lobby_button_sound()
		GLOB.latejoin_menu.ui_interact(usr)
		return

	if(href_list["display_polls"])
		handle_player_polling()
		return

	if(href_list["viewpoll"])
		var/datum/poll_question/poll = locate(href_list["viewpoll"]) in GLOB.polls
		poll_player(poll)
		return

	if(href_list["votepollref"])
		var/datum/poll_question/poll = locate(href_list["votepollref"]) in GLOB.polls
		vote_on_poll_handler(poll, href_list)
		return

	if(href_list["title_is_ready"])
		title_screen_is_ready = TRUE
		return

	if(href_list["button_hover"])
		play_lobby_hover_sound()
		return
