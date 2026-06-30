//Darkpack specific changes to ERTs 
/datum/antagonist/ert/darkpack
  var/splat_used = SPLAT_NONE
	var/generation = 13
	var/clan = /datum/subsplat/vampire_clan/ventrue
	var/discipline_dot_rating = 1 //How many dots to give them. Ghouls belonging to older Vamps can use 2nd+ dots of disciplines.

/datum/antagonist/ertdarkpack/on_gain()
	. = ..()
	clear_splats()
	for (var/datum/quirk/darkpack/quirk_type in owner)
		quirk_type.remove_from_current_holder()
	switch(splat_used)
		if(SPLAT_KINDRED)
			owner.make_kindred(generation, clan)
			var/list/clan_disciplines = clan.clan_disciplines
			if(length(clan_disciplines))
				for(var/i in 1 to 3)
					var/discipline = clan_disciplines[i]
					if(!discipline)
						continue
					owner.give_st_power(discipline, discipline_dot_rating)
					if(ispath(discipline, /datum/discipline/dementation))
						owner.add_quirk(/datum/quirk/darkpack/derangement)
		if(SPLAT_GHOUL)
			owner.make_ghoul()
			var/list/clan_disciplines = clan.clan_disciplines
			if(length(clan_disciplines))
				for(var/i in 1 to 3)
					var/discipline = clan_disciplines[i]
					if(!discipline)
						continue
					owner.give_st_power(discipline, discipline_dot_rating)
					if(ispath(discipline, /datum/discipline/dementation))
						owner.add_quirk(/datum/quirk/darkpack/derangement)
