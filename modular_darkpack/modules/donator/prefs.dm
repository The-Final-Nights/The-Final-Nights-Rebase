// this file contains changes to datum/preferences, specifically related to donators
// Donator ranks: Fledgling, Ancilla, Elder, Antediluvian, Caine. null otherwise
/datum/preferences
	var/donator_rank = null

/datum/preferences/load_preferences()
	. = ..()
	donator_rank = savefile.get_entry("donator_rank")

/datum/preferences/save_preferences()
	. = ..()
	savefile.set_entry("donator_rank", donator_rank)
