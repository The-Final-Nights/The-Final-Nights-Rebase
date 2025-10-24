/datum/preference/choiced/vtm_morality
	savefile_key = "vtm_morality_path"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Path"
	relevant_inherent_trait = TRAIT_VTM_MORALITY
	must_have_relevant_trait = TRUE
	can_randomize = FALSE

/datum/preference/choiced/vtm_morality/create_default_value()
	return "Humanity"

/datum/preference/choiced/vtm_morality/init_possible_values()
	return list("Humanity", "Enlightenment")

/datum/preference/choiced/vtm_morality/apply_to_human(mob/living/carbon/human/target, value)
	if (value != "Enlightenment")
		return

	var/datum/species/human/kindred/kindred_species = target.dna.species
	kindred_species.enlightenment = TRUE
