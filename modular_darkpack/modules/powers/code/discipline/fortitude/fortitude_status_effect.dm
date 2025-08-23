#define BASHING_LETHAL_PROTECTION 15
#define AGGRAVATED_PROTECTION 15

/datum/status_effect/fortitude
	// All IDs are the same to prevent stacking multiple Fortitude statuses
	id = "fortitude"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null

	var/armor_type

/datum/status_effect/fortitude/on_apply()
	. = ..()
	if (!.)
		return

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.add_other_armor(armor_type)

/datum/status_effect/fortitude/on_remove()
	. = ..()

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.subtract_other_armor(armor_type)

// Status effect ranks
/datum/status_effect/fortitude/one
	armor_type = /datum/armor/fortitude1

/datum/armor/fortitude1
	acid = 10
	bio = 10
	bomb = 15
	bullet = 15
	consume = 15
	energy = 15
	laser = 15
	fire = 10
	melee = 15
	wound = 15

/datum/status_effect/fortitude/two
	armor_type = /datum/armor/fortitude2

/datum/armor/fortitude2
	acid = 20
	bio = 20
	bomb = 30
	bullet = 30
	consume = 30
	energy = 30
	laser = 30
	fire = 20
	melee = 30
	wound = 30

/datum/status_effect/fortitude/three
	armor_type = /datum/armor/fortitude3

/datum/armor/fortitude3
	acid = 30
	bio = 30
	bomb = 45
	bullet = 45
	consume = 45
	energy = 45
	laser = 45
	fire = 30
	melee = 45
	wound = 45

/datum/status_effect/fortitude/four
	armor_type = /datum/armor/fortitude4

/datum/armor/fortitude4
	acid = 40
	bio = 40
	bomb = 60
	bullet = 60
	consume = 60
	energy = 60
	laser = 60
	fire = 40
	melee = 60
	wound = 60

/datum/status_effect/fortitude/five
	armor_type = /datum/armor/fortitude5

/datum/armor/fortitude5
	acid = 50
	bio = 50
	bomb = 75
	bullet = 75
	consume = 75
	energy = 75
	laser = 75
	fire = 50
	melee = 75
	wound = 75
