// Handles simulating bootleg 'soak'; uses fortitude values.
// More of a stop-gap till a soak/better system for Garou is added to simulate vampire-soaking.
/datum/species/human/shifter/war/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()

	human_who_gained_species.apply_status_effect(/datum/status_effect/werewolf_soaking)

/datum/species/human/shifter/war/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()

	human.remove_status_effect(/datum/status_effect/werewolf_soaking)

// Crap way of doing it, but adds it as a status effect to avoid issues with mob's base armor physiology
/datum/status_effect/werewolf_soaking
	id = "werewolf_soak"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null

/datum/status_effect/werewolf_soaking/on_apply()
	. = ..()
	if (!.)
		return

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.add_other_armor(/datum/armor/werewolf)

/datum/status_effect/werewolf_soaking/on_remove()
	. = ..()

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.subtract_other_armor(/datum/armor/werewolf)

// Equal to Fortitude 4; 4x15 (60) for bash, 4x10 (40) for agg on fort 4
// If it's too weak you can tune up to Fort 5 (75 bash and 60 agg) but that felt too strong when tried w/ the passive regen.
/datum/armor/werewolf
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
