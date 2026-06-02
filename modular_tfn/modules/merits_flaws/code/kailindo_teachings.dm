/datum/quirk/darkpack/kailindo_teachings
	name = "Kailindo Martial Artist"
	desc = "A martial art created by the Zephyr Stargazers to take advantage of Garou's shapeshifting abilities. It beganas an attempt to develop a form of non-lethal ritual combat to stem savage, and often fatal, infighting among septmates. In this respect, Kailindo failed as few maintain the temperment needed. There are few Kailindorani outside of the Stargazers, but this art remains potent even if rare."
	value = 2
	mob_trait = TRAIT_KAILINDO_TEACHINGS
	gain_text = span_notice("You feel the wind on you, empowering you to use it to strike.")
	lose_text = span_notice("Your knowledge of Kailindo fades; the wind blowing away your mastery..")
	allowed_splats = list(SPLAT_GAROU)	//Might want to limit what septs can take this.
	included_tribes = list(TRIBE_STARGAZERS, TRIBE_GALESTALKERS)
	excluded_tribes = list(TRIBE_FORSWORN, TRIBE_BLACK_FURIES, TRIBE_BONE_GNAWERS, TRIBE_CHILDREN_OF_GAIA, TRIBE_HART_WARDENS, TRIBE_GET_OF_FENRIS, TRIBE_GHOST_COUNCIL, TRIBE_GLASS_WALKERS, TRIBE_RED_TALONS, TRIBE_SHADOW_LORDS, TRIBE_SILENT_STRIDERS, TRIBE_SILVER_FANGS, TRIBE_BLACK_SPIRAL_DANCERS, TRIBE_CORAX)
	icon = FA_ICON_SCROLL
	var/minimum_brawl	//Forces you to have at least 4 brawl to get this.

/datum/quirk/darkpack/kailindo_teachings/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(. == FALSE)
		return

	if(minimum_brawl)
		if(!new_holder.st_get_stat(STAT_BRAWL) >= 4)
			to_chat(new_holder, span_warning("You don't have high enough Brawl for this fighting technique!"))
			return FALSE

	if(ishuman(new_holder))
		var/datum/martial_art/learned_art = new /datum/martial_art/darkpack_kailindo(new_holder)
		learned_art.teach(new_holder)
