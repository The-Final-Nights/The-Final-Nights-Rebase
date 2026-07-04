/mob/dead/new_player/proc/show_title_screen()
	if(isnull(client))
		return
	if(client.interviewee)
		return

	winset(src, "tfn_title_browser", "is-disabled=false;is-visible=true")
	winset(src, "status_bar", "is-visible=false")

	var/datum/asset/assets = get_asset_datum(/datum/asset/simple/lobby) //Sending pictures to the client
	assets.send(src)

	update_title_screen()

/mob/dead/new_player/proc/update_title_screen()
	var/dat = get_title_html()

	src << browse(SStitle.current_title_screen, "file=loading_screen.png;display=0")
	src << browse(dat, "window=tfn_title_browser")

/*
/datum/asset/simple/lobby
	assets = list(
		"FixedsysExcelsior3.01Regular.ttf" = 'html/browser/FixedsysExcelsior3.01Regular.ttf',
	)
*/

/mob/dead/new_player/proc/hide_title_screen()
	if(client?.mob)
		winset(client, "tfn_title_browser", "is-disabled=true;is-visible=false")
		winset(client, "status_bar", "is-visible=true")

/mob/dead/new_player/proc/play_lobby_button_sound()
	SEND_SOUND(src, sound('modular_tfn/modules/title_screen/sound/button.ogg'))

/mob/dead/new_player/proc/play_lobby_hover_sound()
	SEND_SOUND(src, sound('modular_tfn/modules/title_screen/sound/hover.ogg'))

/mob/dead/new_player/create_character(atom/destination)
	. = ..()
	SEND_SOUND(src, sound('modular_tfn/modules/title_screen/sound/login_hit.ogg'))

/mob/dead/new_player/proc/playerpolls()
	if(!usr || !client)
		return

	var/output
	if (!SSdbcore.Connect())
		return
	var/isadmin = FALSE
	if(client?.holder)
		isadmin = TRUE
	var/datum/db_query/query_get_new_polls = SSdbcore.NewQuery({"
		SELECT id FROM [format_table_name("poll_question")]
		WHERE (adminonly = 0 OR :isadmin = 1)
		AND Now() BETWEEN starttime AND endtime
		AND deleted = 0
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_vote")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_textreply")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
	"}, list("isadmin" = isadmin, "ckey" = ckey))

	if(!query_get_new_polls.Execute())
		qdel(query_get_new_polls)
		return
	if(query_get_new_polls.NextRow())
		output +={"<a class="menu_button menu_newpoll" href='byond://?src=[text_ref(src)];display_polls=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>POLLS (NEW)</a>"}
	else
		output +={"<a class="menu_button" href='byond://?src=[text_ref(src)];display_polls=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>POLLS</a>"}
	qdel(query_get_new_polls)
	if(QDELETED(src))
		return
	return output
