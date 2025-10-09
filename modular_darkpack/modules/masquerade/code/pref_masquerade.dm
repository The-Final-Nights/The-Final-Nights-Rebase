/datum/preference/numeric/masquerade
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "masquerade"
	savefile_identifier = PREFERENCE_CHARACTER
	#warn 1 or 0
	minimum = 0
	maximum = 5

/datum/preference/numeric/masquerade/create_default_value()
	return 5

/datum/preference/numeric/masquerade/apply_to_human(mob/living/carbon/human/target, value)
	target.masquerade_score = value
