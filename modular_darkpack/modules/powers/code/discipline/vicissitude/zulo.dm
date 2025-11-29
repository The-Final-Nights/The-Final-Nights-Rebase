/datum/action/cooldown/spell/shapeshift/zulo
	name = "Zulo Form"
	desc = "Take on the shape a beast."
	cooldown_time = 1 TURNS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	spell_requirements = NONE
	convert_damage = FALSE
	possible_shapes = list(/mob/living/basic/zulo)
	owner_has_control = FALSE

/mob/living/basic/zulo
	name = "unknown creature"
	desc = "What the hell is that thing!?"
	icon = 'modular_darkpack/modules/powers/icons/zulo_forms.dmi'
	icon_state = "fiend"
	pixel_w = -16
	pixel_z = -16
	mob_biotypes = MOB_ORGANIC
	mob_size = MOB_SIZE_HUGE

	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE

	bloodpool = 10
	maxbloodpool = 10
