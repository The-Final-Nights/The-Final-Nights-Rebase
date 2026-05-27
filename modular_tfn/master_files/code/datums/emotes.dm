// hoots and hollers!! emote sounds from azure peak
/datum/emote/proc/tfn_voicepack_sound(mob/living/carbon/human/H, emote_key)
	return H.get_voicepack_sound(emote_key)

/datum/emote/get_sound(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/sound/S = tfn_voicepack_sound(H, key)
		if(S)
			return S
	return ..()

// overrides for emotes that might have specific darkpack sound edits. for example, in darkpack giggle has its own get_sound
// instead of editing each instance away with comments, we just override them here
/datum/emote/living/giggle/get_sound(mob/living/carbon/human/user)
	if(istype(user))
		var/sound/S = tfn_voicepack_sound(user, "giggle")
		if(S)
			return S
	return ..()

/datum/emote/living/laugh/get_sound(mob/living/carbon/human/user)
	if(istype(user))
		var/sound/S = tfn_voicepack_sound(user, "laugh")
		if(S)
			return S
	return ..()

/datum/emote/living/scream/get_sound(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/sound/S = tfn_voicepack_sound(H, "scream")
		if(S)
			return S
	return ..()

/datum/emote/living/sigh/get_sound(mob/living/carbon/human/user)
	if(istype(user))
		var/sound/S = tfn_voicepack_sound(user, "sigh")
		if(S)
			return S
	return ..()

/datum/emote/living/sneeze/get_sound(mob/living/carbon/human/user)
	if(istype(user))
		var/sound/S = tfn_voicepack_sound(user, "sneeze")
		if(S)
			return S
	return ..()

/datum/emote/living/cough/get_sound(mob/living/carbon/human/user)
	if(istype(user))
		var/sound/S = tfn_voicepack_sound(user, "cough")
		if(S)
			return S
	return ..()

/datum/emote/living/sniff/get_sound(mob/living/carbon/human/user)
	if(istype(user))
		var/sound/S = tfn_voicepack_sound(user, "sniff")
		if(S)
			return S
	return ..()

/datum/emote/living/snore/get_sound(mob/living/carbon/human/user)
	if(istype(user))
		var/sound/S = tfn_voicepack_sound(user, "snore")
		if(S)
			return S
	return ..()
