#define HUNTER_STATE_IDLE 0
#define HUNTER_STATE_APPROACHING 1
#define HUNTER_STATE_TESTING 2
#define HUNTER_SCAN_RANGE 7
#define HUNTER_TEST_RANGE 3
#define HUNTER_FLEE_RANGE 10
#define HUNTER_BASE_DIFFICULTY 4
GLOBAL_LIST_EMPTY(living_hunters)

/obj/effect/landmark/HUNTER_spawn
	name = "hunter spawn"

/obj/effect/landmark/HUNTER_spawn/hunter
	name = "hunter spawn"

/datum/storyteller_roll/HUNTER_perception
	bumper_text = "hunter perception"
	applicable_stats = list(STAT_PERCEPTION)
	difficulty = 6
	numerical = TRUE

/mob/living/carbon/human/npc/walkby/hunter
	name = "Investigator"
	desc = "Not from around here."
	aggressive = TRUE
	my_weapon_type = /obj/item/vampire_stake

	var/investigation_state = HUNTER_STATE_IDLE
	var/mob/living/investigation_target = null
	var/testing_started = FALSE
	var/list/known_kindred = null
	var/list/cleared_targets = null
	var/chosen_tool = null
	var/turf/guard_turf = null
	var/datum/storyteller_roll/HUNTER_perception/perception_roll
	var/static/list/hunter_tool_templates = list(
		"reaches into their jacket and draws out a flashlight with strange sigils carved into the lens housing, slowly sweeping the beam across",
		"pulls a compass with an iron needle and hand-etched symbols along the rim from their coat pocket, holding it out flat toward",
		"takes a handheld thermal camera with a small cross soldered to the grip from their bag and points it at",
		"produces a small silver-framed mirror with geometric symbols etched into the back from a coat pocket and angles it toward",
		"draws a modified EMF reader with handwritten symbols along the casing from their belt and passes it slowly around",
		"pulls a glass vial of salted water strung on a length of paracord from a shirt pocket and holds it out toward",
		"opens their bag, produces a worn field notebook with pressed herbs tucked between the pages, and holds it open toward",
	)
	var/static/list/hunter_greetings = list(
		"Hey, hold on a second. Can I ask you something?",
		"You look familiar. Do I know you from around here?",
		"Excuse me. You got a minute?",
		"Long night, isn't it.",
		"I hope I'm not bothering you. I'm trying to figure something out.",
		"Mind if I walk with you for a bit?",
		"You're not from this neighborhood, are you.",
		"Strange night to be out alone.",
		"Forgive me for asking, but do you have a moment?",
		"You walk like you know this part of town.",
		"Hold on just a second, if you don't mind.",
		"Haven't seen you around before. You passing through?",
	)

	var/static/list/hunter_detection_phrases = list(
		"I knew it. I knew something was wrong with you.",
		"There it is. Don't run.",
		"God. I've been doing this long enough to know what you are.",
		"The readings don't lie. I know exactly what's standing in front of me.",
		"You people think you can walk among us. Not tonight.",
		"I've been tracking something like you for months. Say your prayers.",
		"The mask slips eventually. Every time.",
		"That's what I thought. Don't make a scene.",
		"I knew the moment I saw you. It's always the eyes.",
		"I've put down [pick("two","six","seven","eight")] of your kind. You'll add to that number tonight.",
		"Wrong neighborhood to be hunting in.",
		"You should have just kept walking.",
		"This city doesn't belong to you.",
	)

	var/static/list/hunter_recognition_phrases = list(
		"I remember you. Drop the act.",
		"We've met before. Last time you got away.",
		"You think I forgot your face?",
		"Been waiting to run into you again.",
		"Not walking away this time.",
		"Oh, you again. Good.",
		"I clocked you the second you came around the corner.",
		"Didn't expect to see you back here.",
		"You and I have unfinished business.",
		"I never forget a face. Especially yours.",
		"I've been carrying your picture in my notebook for a while.",
	)

	var/static/list/hunter_goodbye_phrases = list(
		"My mistake. Have a good night.",
		"I think I mistook you for someone else. Nevermind.",
		"Oh, my bad. I thought I recognized you from somewhere. Seeya'.",
		"Sorry, a case of mistaken identity. Have a nice night.",
		"I apologize for bothering you. Have a good one.",
		"I'm off my meds, forgive me. Take care.",
		"Oh, I was wrong. Sorry for bothering you, I'll go now.",
	)


/mob/living/carbon/human/npc/walkby/hunter/Initialize(mapload)
	. = ..()
	known_kindred = list()
	cleared_targets = list()
	chosen_tool = pick(hunter_tool_templates)
	GLOB.living_hunters += src
	storyteller_stats = create_new_stat_prefs(storyteller_stats)
	st_set_stat(STAT_BRAWL, 5)
	st_set_stat(STAT_STAMINA, 5)
	st_set_stat(STAT_DEXTERITY, 5)
	st_set_stat(STAT_STRENGTH, 5)
	st_set_stat(STAT_MELEE, 5)
	st_set_stat(STAT_PERCEPTION, 2)
	st_set_stat(STAT_PERMANENT_WILLPOWER, 10)
	st_set_stat(STAT_TEMPORARY_WILLPOWER, 10)

/mob/living/carbon/human/npc/walkby/hunter/Destroy()
	GLOB.living_hunters -= src
	known_kindred = null
	cleared_targets = null
	chosen_tool = null
	investigation_target = null
	guard_turf = null
	return ..()

/mob/living/carbon/human/npc/walkby/hunter/death(gibbed)
	. = ..()
	GLOB.living_hunters -= src

/mob/living/carbon/human/npc/walkby/hunter/handle_automated_movement()
	if(stat == DEAD)
		return
	if(danger_source)
		hunter_handle_combat()
		return
	switch(investigation_state)
		if(HUNTER_STATE_IDLE)
			hunter_idle_scan()
			..()
		if(HUNTER_STATE_APPROACHING)
			hunter_handle_approach()
		if(HUNTER_STATE_TESTING)
			hunter_handle_testing()

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_idle_scan()
	if(!prob(25))
		return
	for(var/mob/living/carbon/human/nearby in view(HUNTER_SCAN_RANGE, src))
		if(!nearby.client)
			continue
		if(nearby.stat >= UNCONSCIOUS)
			continue
		if(!get_vampire_splat(nearby))
			continue
		if(!isnull(known_kindred) && known_kindred.Find(nearby))
			face_atom(nearby)
			last_antagonised = world.time
			Aggro(nearby)
			return
		if(!isnull(cleared_targets) && cleared_targets.Find(nearby))
			continue
		hunter_begin_approach(nearby)
		return

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_begin_approach(mob/living/carbon/human/target)
	investigation_target = target
	investigation_state = HUNTER_STATE_APPROACHING
	testing_started = FALSE
	realistic_say(pick(hunter_greetings))
	addtimer(CALLBACK(src, PROC_REF(hunter_point_at), investigation_target), 5 SECONDS)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_handle_approach()
	if(!hunter_target_valid())
		hunter_reset()
		return
	if(get_dist(src, investigation_target) > HUNTER_FLEE_RANGE)
		hunter_reset()
		return
	face_atom(investigation_target)
	GLOB.move_manager.move_to(src, investigation_target, 1, cached_multiplicative_slowdown)
	if(get_dist(src, investigation_target) <= HUNTER_TEST_RANGE && !testing_started)
		testing_started = TRUE
		investigation_state = HUNTER_STATE_TESTING
		addtimer(CALLBACK(src, PROC_REF(hunter_perform_test)), 6 SECONDS)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_handle_testing()
	if(!hunter_target_valid())
		hunter_reset()
		return
	if(get_dist(src, investigation_target) > HUNTER_FLEE_RANGE)
		hunter_add_known(investigation_target)
		hunter_reset()
		return
	face_atom(investigation_target)
	if(get_dist(src, investigation_target) > HUNTER_TEST_RANGE + 1)
		GLOB.move_manager.move_to(src, investigation_target, 1, cached_multiplicative_slowdown)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_perform_test()
	if(!hunter_target_valid())
		hunter_reset()
		return
	var/mob/living/carbon/human/test_subject = investigation_target
	manual_emote("[chosen_tool].")
	if(!perception_roll)
		perception_roll = new()
	if(get_kindred_splat(test_subject) || get_ghoul_splat(test_subject))
		var/subterfuge = investigation_target.st_get_stat(STAT_SUBTERFUGE) || 0
		perception_roll.difficulty = clamp(HUNTER_BASE_DIFFICULTY + subterfuge, 4, 10)
		var/successes = perception_roll.st_roll(src, test_subject)
		if(successes > 0)
			test_subject.emote("twitch_s")
			addtimer(CALLBACK(src, PROC_REF(hunter_detection_confirmed)), 3 SECONDS)
		else
			hunter_add_cleared(test_subject)
			hunter_reset()
	else
		hunter_add_cleared(test_subject)
		hunter_reset()

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_detection_confirmed()
	if(!hunter_target_valid())
		hunter_reset()
		return
	var/mob/living/confirmed_target = investigation_target
	hunter_add_known(confirmed_target)
	hunter_reset()
	realistic_say(pick(hunter_detection_phrases))
	SetStun(2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(hunter_point_at), confirmed_target), pick(2 SECONDS, 4 SECONDS))
	addtimer(CALLBACK(src, PROC_REF(hunter_delayed_aggro), confirmed_target), 5 SECONDS)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_handle_combat()
	cleared_targets = null // something aggro'd the hunter, so it should be suspicious of everyone now
	guard_turf = null
	var/mob/living/target = danger_source?.resolve()
	if(!target || QDELETED(target))
		end_combat()
		return
	last_antagonised = world.time
	if(HAS_TRAIT(target, TRAIT_DEATHCOMA) || target.stat == DEAD)
		var/turf/body_turf = get_turf(target)
		end_combat()
		hunter_post_kill(body_turf)
		return
	if(!istype(get_active_held_item(), /obj/item/vampire_stake))
		var/obj/item/vampire_stake/spawned_stake = new()
		put_in_active_hand(spawned_stake)
	ClickOn(target)
	face_atom(target)
	GLOB.move_manager.move_to(src, target, 1, cached_multiplicative_slowdown)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_post_kill(turf/body_turf)
	guard_turf = body_turf
	staying = TRUE
	addtimer(CALLBACK(src, PROC_REF(hunter_begin_guard)), 5 SECONDS)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_begin_guard()
	if(stat == DEAD)
		return
	staying = FALSE
	walktarget = ChoosePath()

/mob/living/carbon/human/npc/walkby/hunter/ChoosePath()
	if(!guard_turf)
		return ..()
	var/list/nearby = list()
	for(var/turf/T in view(guard_turf))
		if(!T.density)
			nearby += T
	if(length(nearby))
		if(!has_status_effect(/datum/status_effect/incapacitating/stun))
			SetStun(5 SECONDS)
		return pick(nearby)
	return ..()


/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_delayed_aggro(mob/living/target)
	if(danger_source || stat == DEAD)
		return
	last_antagonised = world.time
	realistic_say("...")
	Aggro(target)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_point_at(mob/living/target)
	if(!target || QDELETED(target) || stat == DEAD)
		return
	point_at(target)

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_target_valid()
	if(!investigation_target || QDELETED(investigation_target))
		return FALSE
	if(investigation_target.stat == DEAD)
		return FALSE
	if(!isnull(cleared_targets) && cleared_targets.Find(investigation_target))
		return FALSE
	return TRUE

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_add_known(mob/living/target)
	if(target && !known_kindred.Find(target))
		known_kindred += target

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_add_cleared(mob/living/target)
	if(target && !cleared_targets.Find(target))
		cleared_targets += target
		realistic_say(pick(hunter_goodbye_phrases))

/mob/living/carbon/human/npc/walkby/hunter/proc/hunter_reset()
	investigation_target = null
	investigation_state = HUNTER_STATE_IDLE
	testing_started = FALSE
	if(is_talking && !has_status_effect(/datum/status_effect/incapacitating/stun))
		SetStun(5 SECONDS)
	walktarget = ChoosePath()

#undef HUNTER_STATE_IDLE
#undef HUNTER_STATE_APPROACHING
#undef HUNTER_STATE_TESTING
#undef HUNTER_SCAN_RANGE
#undef HUNTER_TEST_RANGE
#undef HUNTER_FLEE_RANGE
#undef HUNTER_BASE_DIFFICULTY
