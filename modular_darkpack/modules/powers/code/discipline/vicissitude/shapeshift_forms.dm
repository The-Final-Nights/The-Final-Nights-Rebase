/datum/action/cooldown/spell/shapeshift/tzimisce
	name = "Tzimisce Form"
	desc = "Take on the shape a beast."
	cooldown_time = 10 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	spell_requirements = NONE
	convert_damage = FALSE
	possible_shapes = list(/mob/living/basic/tzimisce_beast)

/datum/action/cooldown/spell/shapeshift/bloodcrawler
	name = "Blood Crawler"
	desc = "Take on the shape a beast."
	cooldown_time = 5 SECONDS
	revert_on_death = TRUE
	convert_damage = FALSE
	spell_requirements = NONE
	die_with_shapeshifted_form = FALSE
	possible_shapes = list(/mob/living/basic/bloodcrawler)
