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

// Level 2
/datum/discipline_power/vicissitude/fleshcrafting/post_gain()
	. = ..()
	var/obj/item/organ/cyberimp/arm/toolkit/surgery/surgery_implant = new()
	surgery_implant.Insert(owner)

////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude
	name = "Vicissitude power name"
	desc = "Vicissitude power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg'

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
