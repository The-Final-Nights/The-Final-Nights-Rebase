/datum/st_trait/attribute
	score = 1

// Physical
/datum/st_trait/attribute/strength
	name = "Strength"

/datum/st_trait/attribute/dexterity
	name = "Dexterity"

/datum/st_trait/attribute/stamina
	name = "Stamina"

// Social
/datum/st_trait/attribute/charisma
	name = "Charisma"

/datum/st_trait/attribute/manipulation
	name = "Manipulation"

/datum/st_trait/attribute/appearance
	name = "Appearance"

// Mental
/datum/st_trait/attribute/perception
	name = "Perception"

/datum/st_trait/attribute/intelligence
	name = "Intelligence"

/datum/st_trait/attribute/wits
	name = "Wits"

/mob/living/carbon/human/proc/update_max_health()
	maxHealth = round((src::maxHealth + src::maxHealth/8 * trait_holder.get_stat(ST_TRAIT_STAMINA, FALSE)))
	health = maxHealth
