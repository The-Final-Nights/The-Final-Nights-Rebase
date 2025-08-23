/datum/preference/choiced/vampire_clan
	savefile_key = "vampire_clan"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_TABLETOP
	main_feature_name = "Clan"
	relevant_inherent_trait = TRAIT_VTM_CLANS
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/vampire_clan/init_possible_values()
	// TODO: [Xeon] implement whitelisting
	return assoc_to_keys(GLOB.vampire_clan_list)

/datum/preference/choiced/vampire_clan/has_relevant_feature(datum/preferences/preferences)
	// Skips checks for relevant_organ, relevant trait etc. because vampire clans are tied directly to species
	return current_species_has_savekey(preferences)

/datum/preference/choiced/vampire_clan/icon_for(value)
	return uni_icon('modular_darkpack/modules/vampire_the_masquerade/icons/vampire_clans.dmi', get_vampire_clan(value).id)

/datum/preference/choiced/vampire_clan/apply_to_human(mob/living/carbon/human/target, value)
	target.set_clan(value, TRUE)
