// Level 1: Shapeshift Self
// Level 2: Shapeshift Other
// Level 3: Damage others and self.
// Level 4: Shapeshift into a Horrid Form
// Level 5: Slimegirl tzimisce

/datum/discipline/vicissitude
	name = "Vicissitude"
	desc = "It is widely known as Tzimisce art of flesh and bone shaping. Violates Masquerade."
	icon_state = "vicissitude"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/vicissitude

/datum/discipline/vicissitude/post_gain()
	. = ..()
	owner.faction |= VAMPIRE_CLAN_TZIMISCE
	ADD_TRAIT(owner, TRAIT_VICISSITUDE_KNOWLEDGE, DISCIPLINE_TRAIT)

////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude
	name = "Vicissitude power name"
	desc = "Vicissitude power description"

	var/datum/action/cooldown/mob_cooldown/shapeshift/shapeshift_ability

/datum/discipline_power/vicissitude/post_gain()
	if(!shapeshift_ability)
		shapeshift_ability = new(owner)
	shapeshift_ability.Grant(owner)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/malleable_visage
	name = "Malleable Visage"
	desc = "Shapeshift yourself."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = NONE
	cooldown_length = 1 TURNS
	vitae_cost = 1
	toggled = FALSE
	aggravating = TRUE

/datum/discipline_power/vicissitude/malleable_visage/activate(atom/target)
	. = ..()
	shapeshift_ability.Activate(owner)
	return TRUE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/fleshcrafting
	name = "Fleshcrafting"
	desc = "Mold your victim's flesh and soft tissue to your desire."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_SELF | TARGET_HUMAN
	vitae_cost = 1
	range = 1
	toggled = FALSE
	aggravating = TRUE
	cooldown_length = 1 TURNS

/datum/discipline_power/vicissitude/fleshcrafting/activate(atom/target)
	. = ..()
	shapeshift_ability.Activate(target)
	return TRUE

/datum/discipline_power/vicissitude/fleshcrafting/post_gain()
	. = ..()
	var/obj/item/organ/cyberimp/arm/toolkit/surgery/surgery_implant = new()
	surgery_implant.Insert(owner)
	ADD_TRAIT(owner, TRAIT_SURGEON, DISCIPLINE_TRAIT)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/bonecrafting
	name = "Bonecrafting"
	desc = "Forcefully injure a body."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_SELF | TARGET_HUMAN
	vitae_cost = 1
	range = 1
	toggled = FALSE
	aggravating = TRUE
	cooldown_length = 1 TURNS

/datum/discipline_power/vicissitude/bonecrafting/activate(mob/living/target)
	. = ..()

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/horrid_form
	name = "Horrid Form"
	desc = "Force a body to become something truly monstrous."

	level = 4
	violates_masquerade = TRUE
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_SELF | TARGET_HUMAN
	duration_length = 1 TURNS
	vitae_cost = 2
	toggled = FALSE
	aggravating = TRUE
	cooldown_length = 1 TURNS

/datum/discipline_power/vicissitude/horrid_form/activate()
	. = ..()

/datum/discipline_power/vicissitude/horrid_form/deactivate()
	. = ..()


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/bloodform
	name = "Bloodform"
	desc = "Liquify into a shifting mass of sentient Vitae."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_SELF
	violates_masquerade = TRUE
	cooldown_length = 1 TURNS

/datum/discipline_power/vicissitude/bloodform/activate()
	. = ..()

/datum/discipline_power/vicissitude/bloodform/deactivate()
	. = ..()
