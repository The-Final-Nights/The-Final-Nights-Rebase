// V20 p. 494
/datum/quirk/darkpack/unbondable
	name = "Unbondable"
	desc = "You are immune to being blood bound. Tremere cannot take this Merit."
	value = 5
	mob_trait = TRAIT_UNBONDABLE
	icon = FA_ICON_CHAIN_BROKEN
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_TREMERE)


/datum/quirk/darkpack/unbondable/ghoul
	name = "Unbondable (Mortal)" // TFN EDIT CHANGE - Unbondable for Humans and Kinfolk - Original - name = "Unbondable (Ghoul)"
	desc = "You are immune to being blood bound.."
	value = 6
	allowed_splats = list(SPLAT_GHOUL, SPLAT_KINFOLK, SPLAT_NONE) // TFN EDIT CHANGE - Unbondable for Humans and Kinfolk - Original - allowed_splats = list(SPLAT_GHOUL)
