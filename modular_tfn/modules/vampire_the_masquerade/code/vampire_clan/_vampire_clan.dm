
/datum/subsplat/vampire_clan/show_lore(mob/user)
	. = ..()
	if(curse)
		to_chat(user, span_danger("<br>CURSE: [curse]"))
