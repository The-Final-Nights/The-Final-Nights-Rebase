/datum/preference/choiced/garou_fur_color
	savefile_key = "garou_fur_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Fera Fur Color"
	relevant_inherent_trait = TRAIT_FERA_FUR
	must_have_relevant_trait = TRUE

/datum/preference/choiced/garou_fur_color/init_possible_values()
	return assoc_to_keys(GLOB.garou_fur_colors)


/datum/preference/choiced/garou_fur_color/apply_to_human(mob/living/carbon/human/target, value)
	// TFN EDIT START
	var/datum/subsplat/werewolf/tribe/tribe = target.get_our_tribe() || get_fera_tribe(target.client?.prefs?.read_preference(/datum/preference/choiced/subsplat/garou_tribe))
	if(tribe?.name == TRIBE_BLACK_SPIRAL_DANCERS)
		target.dna.features[FEATURE_FUR_COLOR] = "spiral[value]"
	else
		target.dna.features[FEATURE_FUR_COLOR] = value
	// TFN EDIT END
