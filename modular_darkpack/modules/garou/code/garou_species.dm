/datum/species/human/garou
	name = "Garou"
	plural_form = "Garou"
	id = SPECIES_GAROU
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_USES_SKINTONES,
	)
	changesource_flags = MIRROR_BADMIN
	species_language_holder = /datum/language_holder/garou
	mutanttongue = /obj/item/organ/tongue/garou

/mob/living/carbon/human/species/garou
	race = /datum/species/human/garou

/datum/species/human/garou/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#502D15", update = FALSE)
	human.set_hairstyle("Long Hair 3", update = TRUE)

/datum/species/human/get_species_description()
	return "Lorem Ipsum"

/datum/species/human/get_species_lore()
	return list(
		"Lorem Ipsum",
	)

/datum/species/human/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "shield",
		SPECIES_PERK_NAME = "Garou",
		SPECIES_PERK_DESC = "Its a Garou.",
	))


	return to_add
