// this file contains changes to datum/preferences, specifically related to donators
// Donator ranks: Fledgling, Ancilla, Elder, Antediluvian, Caine. null otherwise
/datum/preferences
	var/donator_rank = null

/datum/preferences/load_preferences()
	. = ..()
	donator_rank = savefile.get_entry("donator_rank")
	discipline_trusted = savefile.get_entry("discipline_trusted")

/datum/preferences/save_preferences()
	. = ..()
	savefile.set_entry("donator_rank", donator_rank)
	savefile.set_entry("discipline_trusted", discipline_trusted)
