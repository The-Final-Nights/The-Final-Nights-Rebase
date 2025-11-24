/datum/discipline/vicissitude
	name = "Vicissitude"
	desc = "It is widely known as Tzimisce art of flesh and bone shaping. Violates Masquerade."
	icon_state = "vicissitude"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/vicissitude

// Level 1
/datum/discipline/vicissitude/post_gain()
	. = ..()
	owner.faction |= VAMPIRE_CLAN_TZIMISCE
	ADD_TRAIT(owner, TRAIT_VICISSITUDE_KNOWLEDGE, DISCIPLINE_TRAIT)

/datum/discipline_power/vicissitude/malleable_visage/post_gain()
	. = ..()
	var/datum/action/cooldown/mob_cooldown/basic_vicissitude/basic_vicissitude = new(owner)
	basic_vicissitude.Grant(owner)

// Level 2
/datum/discipline_power/vicissitude/fleshcrafting/post_gain()
	. = ..()
	var/obj/item/organ/cyberimp/arm/toolkit/surgery/surgery_implant = new()
	surgery_implant.Insert(owner)

	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_wall)
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_stool)
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_floor)
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_eyes)
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_implant)

// Level 3
/datum/discipline_power/vicissitude/bonecrafting/post_gain()
	. = ..()
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_trench)
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_biter)
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_fister)
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_tanker)

// Level 4
/datum/discipline_power/vicissitude/horrid_form/post_gain()
	. = ..()
	owner.mind?.teach_crafting_recipe(/datum/crafting_recipe/tzi_heart)

////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude
	name = "Vicissitude power name"
	desc = "Vicissitude power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg'

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/malleable_visage
	name = "Malleable Visage"
	desc = "Remember another person's features and copy them at a later time."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	target_type = TARGET_HUMAN
	violates_masquerade = TRUE
	cooldown_length = 1 TURNS
	vitae_cost = 1
	toggled = FALSE

/datum/discipline_power/vicissitude/malleable_visage/activate(atom/target)
	. = ..()


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/fleshcrafting
	name = "Fleshcrafting"
	desc = "Mold your victim's flesh and soft tissue to your desire."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
	target_type = TARGET_MOB
	range = 1

	effect_sound = 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg'
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length =1 TURNS
	grouped_powers = list(/datum/discipline_power/vicissitude/bonecrafting)

/datum/discipline_power/vicissitude/fleshcrafting/activate(mob/living/target)
	. = ..()

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/bonecrafting
	name = "Bonecrafting"
	desc = "Mold your victim's flesh and soft tissue to your desire."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
	target_type = TARGET_MOB
	range = 1

	effect_sound = 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg'
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 1 TURNS
	grouped_powers = list(/datum/discipline_power/vicissitude/fleshcrafting)

/datum/discipline_power/vicissitude/bonecrafting/activate(mob/living/target)
	. = ..()

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/horrid_form
	name = "Horrid Form"
	desc = "Shift your flesh and bone into that of a hideous monster."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
	vitae_cost = 2

	violates_masquerade = TRUE

	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

/datum/discipline_power/vicissitude/horrid_form/activate()
	. = ..()

/datum/discipline_power/vicissitude/horrid_form/deactivate()
	. = ..()


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/bloodform
	name = "Bloodform"
	desc = "Liquefy into a shifting mass of sentient Vitae."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND

	violates_masquerade = TRUE

	cooldown_length = 1 TURNS

/datum/discipline_power/vicissitude/bloodform/activate()
	. = ..()

/datum/discipline_power/vicissitude/bloodform/deactivate()
	. = ..()
