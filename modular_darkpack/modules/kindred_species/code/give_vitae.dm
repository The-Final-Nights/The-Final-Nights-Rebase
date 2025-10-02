/datum/action/cooldown/mob_cooldown/give_vitae
	name = "Give Vitae"
	desc = "Give your vitae to someone, make the Blood Bond."
	button_icon_state = "vitae"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

/datum/action/cooldown/mob_cooldown/give_vitae/Activate(atom/target_atom)
	var/mob/living/living_owner = owner
	living_owner.blood_volume -= 5
