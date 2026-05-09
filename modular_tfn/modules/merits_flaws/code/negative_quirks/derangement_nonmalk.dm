/datum/quirk/darkpack/derangement/nonmalk
	darkpack_allowed = TRUE
	excluded_clans = list(VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_DOMINATE_MALKAVIAN)
	value = -3

/datum/quirk/darkpack/derangement/nonmalk/post_add()
	var/datum/action/cooldown/malk_speech/malk_font = new(quirk_holder)
	malk_font.Grant(quirk_holder)
