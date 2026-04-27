/* TFN EDIT REMOVAL - moved to a dedicated tfn file
/datum/preferences
	var/donator_rank = null
*/
/datum/preferences/load_preferences()
	. = ..()
	// TFN EDIT REMOVAL - donator_rank = savefile.get_entry("donator_rank")
	discipline_trusted = savefile.get_entry("discipline_trusted")

/datum/preferences/save_preferences()
	. = ..()
	savefile.set_entry("discipline_trusted", discipline_trusted)
	// TFN EDIT REMOVAL - savefile.set_entry("donator_rank", donator_rank)
