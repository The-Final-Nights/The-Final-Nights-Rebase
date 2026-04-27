/datum/preference/choiced/subsplat/garou_tribe
	savefile_key = "garou_tribe"
	main_feature_name = "Tribe"
	relevant_inherent_trait = TRAIT_WTA_GAROU_TRIBE

/datum/preference/choiced/subsplat/garou_tribe/init_possible_values()
	return assoc_to_keys(GLOB.tribes_list) // This would be inclusive of ALL tribes so many need to be reworked when adding other fera

/datum/preference/choiced/subsplat/garou_tribe/icon_for(value)
	var/datum/universal_icon/tribe_icon = uni_icon('icons/effects/effects.dmi', "nothing")
	// TFN EDIT ADDITION START - Garou
	var/icon/tribe_icon_state = replacetext(LOWER_TEXT(value), " ", "_")
	if(icon_exists('modular_darkpack/modules/werewolf_the_apocalypse/icons/tribes.dmi', tribe_icon_state))
		tribe_icon.blend_icon(uni_icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/tribes.dmi', tribe_icon_state), ICON_OVERLAY)
	else
		tribe_icon.blend_icon(uni_icon('modular_tfn/modules/werewolf_the_apocalypse/icons/tribes.dmi', tribe_icon_state), ICON_OVERLAY)
	// TFN EDIT ADDITION END
	return tribe_icon

/datum/preference/choiced/subsplat/garou_tribe/apply_to_human(mob/living/carbon/human/target, value)
	var/joining_round = !isdummy(target)
	target.set_fera_tribe(value, joining_round)
