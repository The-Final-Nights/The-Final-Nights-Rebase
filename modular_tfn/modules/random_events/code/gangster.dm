#define BB_GANGSTER_DEFEND_SPOT "BB_gangster_defend_spot"
#define GANGSTER_LEASH_RANGE 10
#define FACTION_GANGSTER_A "gangster_a"
#define FACTION_GANGSTER_B "gangster_b"
GLOBAL_LIST_EMPTY(living_turfwar_npcs)

/datum/round_event_control/darkpack/turf_war
	name = "Turf War"
	typepath = /datum/round_event/turf_war
	weight = 6
	min_players = 5
	max_occurrences = 3
	earliest_start = 10 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "Two gangs have begun fighting for turf in the city!"
	darkpack_allowed = TRUE

/datum/round_event_control/darkpack/turf_war/can_spawn_event(players_amt, allow_magic)
	if(!..())
		return FALSE

	var/found_a = FALSE
	var/found_b = FALSE
	for(var/obj/effect/landmark/event_spawn/gangster_spawn/L in GLOB.generic_event_spawns)
		if(istype(L, /obj/effect/landmark/event_spawn/gangster_spawn/a))
			found_a = TRUE
		else if(istype(L, /obj/effect/landmark/event_spawn/gangster_spawn/b))
			found_b = TRUE
		if(found_a && found_b)
			break

	if(!found_a || !found_b) // these are message_admins because its not a critical enough issue that gangsters arent murdering each other or power grids failing to warrant runtimes
		message_admins("ERROR: Turfwar event called but gangster spawn landmarks are missing.")
		return FALSE

	var/found_defend_area = FALSE
	for(var/obj/effect/landmark/gangster_defend_area/D in GLOB.landmarks_list)
		found_defend_area = TRUE
		break

	if(!found_defend_area)
		message_admins("ERROR: Turfwar event called but no gangster defend area landmark is present.")
		return FALSE


	return TRUE

/datum/round_event/turf_war
	start_when = 1
	announce_when = 5
	var/list/gang_names = list(
		"Three Fifths",
		"The Boulevards",
		"Bay Bikers",
		"Bay Area 13",
		"Red 7",
		"Baywalk Club",
		"Jets",
		"Bluejays",
		"Terror Time",
		"Factory 13",
		"Bay Block Warehouse",
	)
	var/list/warning = list("Watch out bay area", "BREAKING", "CRIME WATCH", "Holy shit", "Wow")
	var/list/random_description = list("declared war on", "is beefing with", "said they are going to kill", "publicly declared their intent to wipe out", "is squaring up with")
	var/list/spawns_a = list()
	var/list/spawns_b = list()
	var/chosen_gang_a_name
	var/chosen_gang_b_name
	var/chosen_warning
	var/obj/effect/landmark/gangster_defend_area/chosen_defend_spot

/datum/round_event/turf_war/announce(fake)
	endpost_announce("[pick(warning)], [chosen_gang_a_name] [pick(random_description)] [chosen_gang_b_name].", pick("friedman1990", "mel0nman","y3ll0wgl0v3s","d3bofn1ght"))

/datum/round_event/turf_war/setup()
	. = ..()
	chosen_gang_a_name = pick(gang_names)
	chosen_gang_b_name = pick(gang_names - chosen_gang_a_name)

	var/list/defend_spots = list()
	for(var/obj/effect/landmark/gangster_defend_area/D in GLOB.landmarks_list)
		defend_spots += D
	if(length(defend_spots))
		chosen_defend_spot = pick(defend_spots)

	for(var/obj/effect/landmark/event_spawn/gangster_spawn/L in GLOB.generic_event_spawns)
		if(istype(L, /obj/effect/landmark/event_spawn/gangster_spawn/a))
			spawns_a += L
		else if(istype(L, /obj/effect/landmark/event_spawn/gangster_spawn/b))
			spawns_b += L

/datum/round_event/turf_war/start()
	if(length(GLOB.living_turfwar_npcs))
		return

	var/a_count = rand(4, 8)
	for(var/i in 1 to a_count)
		var/obj/effect/landmark/event_spawn/gangster_spawn/a/entry_point = pick(spawns_a)
		var/mob/living/basic/trooper/gangster/spawned
		if(prob(15))
			spawned = new /mob/living/basic/trooper/gangster/ranged(entry_point.loc)
		else
			spawned = new /mob/living/basic/trooper/gangster/melee(entry_point.loc)
		spawned.name = "[chosen_gang_a_name] [pick("Thug", "Gangster", "Bruiser", "Recruit")]"
		spawned.set_defend_spot(chosen_defend_spot)
		SSpoints_of_interest.make_point_of_interest(spawned)

	var/b_count = rand(4, 8)
	for(var/i in 1 to b_count)
		var/obj/effect/landmark/event_spawn/gangster_spawn/b/entry_point = pick(spawns_b)
		var/mob/living/basic/trooper/gangster/rival_spawned
		if(prob(15))
			rival_spawned = new /mob/living/basic/trooper/gangster/ranged/rival(entry_point.loc)
		else
			rival_spawned = new /mob/living/basic/trooper/gangster/melee/rival(entry_point.loc)
		rival_spawned.name = "[chosen_gang_b_name] [pick("Thug", "Gangster", "Bruiser", "Recruit")]"
		rival_spawned.set_defend_spot(chosen_defend_spot)
		SSpoints_of_interest.make_point_of_interest(rival_spawned)
	message_admins("EVENT: The turfwar event triggered.")








// turf war event where two sets of NPC gangsters fight it out over a landmark
/obj/effect/landmark/gangster_defend_area
	name = "turfwar marker"

/obj/effect/landmark/event_spawn/gangster_spawn/a
	name = "gangster spawn (A)"

/obj/effect/landmark/event_spawn/gangster_spawn/b
	name = "gangster spawn (B)"

/datum/outfit/gangster_a
	name = "Gangster (A)"
	uniform = /obj/item/clothing/under/vampire/bandit
	suit = /obj/item/clothing/suit/jacket/letterman_red
	shoes = /obj/item/clothing/shoes/vampire/jackboots

/datum/outfit/gangster_b
	name = "Gangster (B)"
	uniform = /obj/item/clothing/under/vampire/bandit
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots

/obj/effect/mob_spawn/corpse/human/gangster_a
	name = "Thug" // replaced on spawn to include the gang name
	outfit = /datum/outfit/gangster_a
	facial_hairstyle = "Shaved"

/obj/effect/mob_spawn/corpse/human/gangster_a/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_human.skin_tone = "caucasian2"
	spawned_human.update_body()

/obj/effect/mob_spawn/corpse/human/gangster_b
	name = "Thug"
	outfit = /datum/outfit/gangster_b
	facial_hairstyle = "Shaved"

/obj/effect/mob_spawn/corpse/human/gangster_b/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_human.skin_tone = "caucasian1"
	spawned_human.update_body()

/datum/ai_planning_subtree/prepare_travel_to_destination/gangster
	target_key = BB_GANGSTER_DEFEND_SPOT

/datum/ai_planning_subtree/gangster_leash
/datum/ai_planning_subtree/gangster_leash/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/defend_spot = controller.blackboard[BB_GANGSTER_DEFEND_SPOT]
	if(!defend_spot)
		return
	if(get_dist(controller.pawn, defend_spot) <= GANGSTER_LEASH_RANGE)
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
	controller.CancelActions()

/datum/ai_controller/basic_controller/trooper/gangster
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/gangster_leash,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/prepare_travel_to_destination/gangster,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target,
	)

/datum/ai_controller/basic_controller/trooper/gangster/ranged
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/gangster_leash,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper,
		/datum/ai_planning_subtree/prepare_travel_to_destination/gangster,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target,
	)

/mob/living/basic/trooper/gangster/proc/set_defend_spot(obj/effect/landmark/gangster_defend_area/spot)
	if(!spot || !ai_controller)
		return
	var/patrol_area = rand(4, 8) // how close theyll get to the actual landmark before they start npc wandering
	if(get_dist(src, spot) > patrol_area)
		ai_controller.set_blackboard_key(BB_GANGSTER_DEFEND_SPOT, spot)

/mob/living/basic/trooper/gangster
	name = "Gangster"
	desc = "Local gangster. Seems on edge!"
	faction = list(FACTION_GANGSTER_A)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/gangster_a
	corpse = /obj/effect/mob_spawn/corpse/human/gangster_a

/mob/living/basic/trooper/gangster/Initialize(mapload)
	. = ..()
	GLOB.living_turfwar_npcs += src

/mob/living/basic/trooper/gangster/Destroy()
	GLOB.living_turfwar_npcs -= src
	return ..()

/mob/living/basic/trooper/gangster/death(gibbed)
	. = ..()
	GLOB.living_turfwar_npcs -= src

/mob/living/basic/trooper/gangster/melee
	name = "Gangster"
	ai_controller = /datum/ai_controller/basic_controller/trooper/gangster
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_verb_continuous = "bludgeons"
	attack_verb_simple = "bludgeon"
	attack_sound = 'sound/items/weapons/genhit3.ogg'
	r_hand = /obj/item/melee/baseball_bat/vamp

/mob/living/basic/trooper/gangster/melee/Initialize(mapload)
	if(ispath(r_hand, /obj/item/melee/baseball_bat/vamp) && prob(50))
		r_hand = /obj/item/switchblade/vamp // for variety
	. = ..()

/mob/living/basic/trooper/gangster/ranged
	name = "Gangster"
	ai_controller = /datum/ai_controller/basic_controller/trooper/gangster/ranged
	r_hand = /obj/item/gun/ballistic/automatic/darkpack/uzi
	var/casingtype = /obj/item/ammo_casing/vampire/c9mm
	var/projectilesound = 'modular_darkpack/modules/deprecated/sounds/uzi.ogg'
	var/burst_shots = 3
	var/ranged_cooldown = 3 SECONDS

/mob/living/basic/trooper/gangster/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = casingtype,\
		projectile_sound = projectilesound,\
		cooldown_time = ranged_cooldown,\
		burst_shots = burst_shots,\
	)

/mob/living/basic/trooper/gangster/melee/rival
	name = "Rival Gangster"
	desc = "A gangster representing colors from a few blocks away."
	faction = list(FACTION_GANGSTER_B)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/gangster_b
	corpse = /obj/effect/mob_spawn/corpse/human/gangster_b

/mob/living/basic/trooper/gangster/ranged/rival
	name = "Rival Gangster"
	desc = "A gangster representing colors from a few blocks away."
	faction = list(FACTION_GANGSTER_B)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/gangster_b
	corpse = /obj/effect/mob_spawn/corpse/human/gangster_b

#undef BB_GANGSTER_DEFEND_SPOT
#undef FACTION_GANGSTER_A
#undef FACTION_GANGSTER_B
#undef GANGSTER_LEASH_RANGE
