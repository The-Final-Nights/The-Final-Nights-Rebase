// VAMPIRE THE MASQUERADE 20th ANNIVERSARY EDITION - VALEREN (WARRIOR)
/* A healer learns a subject's illnesses to cure them. The
Salubri antitribu, however, learn how close to death a
target is so that they may hasten the process.
System: This power works identically to the Obeah
power of the same name (p. 457):

"With a touch, the Salubri can instantaneously read
a target's injuries. She may learn how much damage a
target has incurred, and therefore make a guess at what
must be done to save him. This power can also be used
for diagnostic purposes - useful for a victim who can
no longer speak.

System: The Salubri must touch the target to see how
close to death she is. He must then make a Perception
+ Empathy roll (difficulty 7). One success on this roll
identifies a subject as a mortal, vampire, ghoul, or other creature.

Two successes reveal how many health levels
of damage the subject has suffered. Three successes tell
how full the subject's blood pool is (if a vampire) or
how many blood points she has left in her system (if a
mortal or other blood-bearing form of life). Four suc-
cesses reveal any diseases in the subject's bloodstream.
A player may opt to learn the information yielded by
a lesser degree of success - for example, a player who
accumulates three successes may learn whether or not
a subject is a vampire as well as the contents of his
blood pool.
*/

/datum/discipline/warrior_valeren
	name = "Valeren"
	desc = "The warrior's path of Valeren, used by the Salubri antitribu to read and exploit weakness in their enemies."
	icon_state = "valeren"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/warrior_valeren

/datum/discipline_power/warrior_valeren
	name = "Valeren power name"
	desc = "Valeren power description"
	activate_sound = 'modular_darkpack/modules/deprecated/sounds/valeren.ogg'

/datum/discipline_power/warrior_valeren/sense_vitality
	name = "Sense Vitality"
	desc = "Allows you to determine the vitality of a target."
	level = 1
	check_flags = DISC_CHECK_CAPABLE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 1
	cooldown_length = 5 TURNS
	duration_length = 1 TURNS
	activate_sound = null // dont play a sound
	vitae_cost = 5
	var/successes = 0

/datum/discipline_power/warrior_valeren/sense_vitality/pre_activation_checks(mob/living/target)
	. = ..()
	successes = SSroll.storyteller_roll(owner.st_get_stat(STAT_PERCEPTION) + owner.st_get_stat(STAT_EMPATHY), 7, owner, TRUE)
	if(successes > 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/warrior_valeren/sense_vitality/proc/blood_read(mob/living/carbon/human/target)
	var/blood_volume = target.get_blood_volume(apply_modifiers = TRUE)
	switch(blood_volume)
		if(BLOOD_VOLUME_EXCESS to INFINITY)
			return "Their veins are engorged to the point of rupture."
		if(BLOOD_VOLUME_MAXIMUM to BLOOD_VOLUME_EXCESS)
			return "They are heavily overloaded with blood."
		if(BLOOD_VOLUME_SAFE to BLOOD_VOLUME_MAXIMUM)
			return "Their blood volume is healthy."
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			return "Their blood is lower than normal."
		if(BLOOD_VOLUME_RISKY to BLOOD_VOLUME_OKAY)
			return "Their blood volume is dangerously low."
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_RISKY)
			return "You can barely sense any blood left in them."
		if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
			return "They are nearly void of blood altogether. Death comes for them soon without immediate intervention."
		else
			return "They are completely drained of blood, and you sense very little life left."

/datum/discipline_power/warrior_valeren/sense_vitality/proc/damage_severity(damage)
	if(damage < 30)
		return "some"
	if(damage < 50)
		return "moderate"
	return "heavy"

/datum/discipline_power/warrior_valeren/sense_vitality/activate(mob/living/target)
	. = ..()
	var/list/message_lines = list()
	var/list/emotes = list(
		"You briefly touch them to sense their vitality.",
		"Your third eye stirs.",
		"The pulse beneath your fingertips speaks.",
		"Their life force is plain to you.",
	)

	// on one success, identify their splat
	var/creature_type = "mortal"
	if(iskindred(target))
		creature_type = "kindred"
	else if(isghoul(target))
		creature_type = "ghoul"
	else if(isavatar(target) || isobserver(target)) // because salubri spend all their time in the clinic anyway. they'll use this on ghosts
		creature_type = "wraith"
	message_lines += "[pick(emotes)] [target] is a [creature_type]."

	// on two successes, identify their damage
	if(successes >= 2)
		var/brute = target.get_brute_loss()
		var/burn = target.get_fire_loss()
		var/tox = target.get_tox_loss()
		var/oxy = target.get_oxy_loss()
		var/agg = target.get_agg_loss()
		var/list/damage_parts = list()
		if(brute > 0)
			damage_parts += "[damage_severity(brute)] bruising"
		if(burn > 0)
			damage_parts += "[damage_severity(burn)] burns"
		if(tox > 0)
			damage_parts += "[damage_severity(tox)] toxin damage"
		if(oxy > 0)
			damage_parts += "[damage_severity(oxy)] oxygen deprivation"
		if(agg > 0)
			damage_parts += "[damage_severity(agg)] supernatural wounds"
		message_lines += length(damage_parts) ? "They bear [english_list(damage_parts)]." : "They appear uninjured."

	// on three successes, detect their bloodpool, if any exists
	if(successes >= 3)
		message_lines += "[blood_read(target)] Blood pool: [target.bloodpool] / [target.maxbloodpool]."

	// on four, display any diseases they might have
	if(successes >= 4)
		var/list/datum/disease/diseases = target.get_static_viruses()
		if(LAZYLEN(diseases))
			var/list/disease_names = list()
			for(var/datum/disease/D in diseases)
				disease_names += D.name
			message_lines += "You detect the following in their blood: [english_list(disease_names)]."
		else
			message_lines += "You don't sense any diseases in their blood."
		var/list/mental_conditions = list()
		if(target.has_quirk(/datum/quirk/insanity))
			mental_conditions += "insanity"
		if(target.has_quirk(/datum/quirk/derangement))
			mental_conditions += "an incurable derangement"
		if(length(mental_conditions))
			message_lines += "You sense [english_list(mental_conditions)] clouds their mind."

	to_chat(owner, span_notice(message_lines.Join("\n")))

/datum/discipline_power/warrior_valeren/sense_vitality/deactivate()
	. = ..()
