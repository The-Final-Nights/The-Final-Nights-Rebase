// hoots and hollers!! emote sounds from azure peak
/datum/emote/proc/tfn_voicepack_sound(mob/living/carbon/human/H, emote_key)
	var/datum/voicepack/voice_pack
	if(iscrinos(H) || islupus(H))
		voice_pack = new /datum/voicepack/werewolf()
	else
		voice_pack = H.voicepack
	if(!voice_pack)
		return null
	var/raw = voice_pack.get_sound(emote_key)
	if(!raw && !istype(voice_pack, /datum/voicepack/human))
		var/datum/voicepack/fallback = H.gender == FEMALE ? new /datum/voicepack/human/female() : new /datum/voicepack/human/male()
		raw = fallback.get_sound(emote_key)
	if(!raw)
		return null
	var/sound/S = sound(islist(raw) ? pick(raw) : raw)
	var/t = clamp(H.voice_pitch + rand(-VOICE_PITCH_VARIATION, VOICE_PITCH_VARIATION), VOICE_PITCH_MIN, VOICE_PITCH_MAX)
	S.frequency = MIN_EMOTE_PITCH + (t - VOICE_PITCH_MIN) * (MAX_EMOTE_PITCH - MIN_EMOTE_PITCH) / (VOICE_PITCH_MAX - VOICE_PITCH_MIN)
	return S

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
