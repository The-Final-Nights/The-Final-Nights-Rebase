/datum/round_event_control/darkpack/spiders
	name = "Spider Infestation"
	typepath = /datum/round_event/spiders
	weight = 6
	min_players = 5
	max_occurrences = 2
	earliest_start = 10 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "A large spider has taken up nest inside the city..."

/datum/round_event_control/darkpack/spiders/can_spawn_event(players_amt, allow_magic)
	. = ..()
	if(!.)
		return FALSE

	var/found_spawn = FALSE
	for(var/obj/effect/landmark/event_spawn/spider_spawn/L in GLOB.generic_event_spawns)
		found_spawn = TRUE
		break

	if(!found_spawn)
		message_admins("ERROR: Spider event called but spider spawn landmarks are missing.")
		return FALSE

	return TRUE

/datum/round_event/spiders
	start_when = 1
	announce_when = 5
	var/list/spider_spawns = list()
	var/obj/effect/landmark/event_spawn/spider_spawn/entry_point

/datum/round_event/spiders/setup()
	. = ..()
	// well, we know theres at least one...
	for(var/obj/effect/landmark/event_spawn/spider_spawn/L in GLOB.generic_event_spawns)
		spider_spawns += L

	entry_point = pick(spider_spawns)


/datum/round_event/spiders/announce(fake)
	var/list/warning = list("peeps...", "YOOOOO", "wtf", "Holy shit", "Wow")
	var/list/random_description = list("I just saw a HUGE spider",
	"there are like a TON of spiders",
	"a million fucking spiders",
	"like [pick("seventeen","twenty","three","eighty four","nine","eleven","a dozen")] spiders",
	"absolute nightmare fuel")
	var/area/spawn_area = get_area(entry_point)
	message_admins("EVENT: The spider infestation triggered in [ADMIN_VERBOSEJMP(entry_point.loc)][spawn_area?.name].")
	endpost_announce("[pick(warning)], [pick(random_description)] near the [spawn_area?.name][pick(".","..."," ")]", pick("friedman1990", "mel0nman","y3ll0wgl0v3s","d3bofn1ght"))


/datum/round_event/spiders/start()
	var/spider_count = rand(3, 6)
	for(var/i in 1 to spider_count)
		var/mob/living/basic/spider/growing/young/event/spawned = new(entry_point.loc)
		SSpoints_of_interest.make_point_of_interest(spawned)

// spider infestation event where a nest of spiders emerges somewhere in the city! oh no!
/obj/effect/landmark/event_spawn/spider_spawn
	name = "spider spawn"

/mob/living/basic/spider/growing/young/event

/mob/living/basic/spider/growing/young/event/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOB_CHANGED_TYPE, PROC_REF(on_grown))

/mob/living/basic/spider/growing/young/event/proc/on_grown(datum/source, mob/living/basic/spider/giant/grown)
	SIGNAL_HANDLER
	var/matrix/spooder_size = matrix()
	spooder_size.Scale(0.7, 0.7) // so theyre big, but not tg station big
	grown.transform = spooder_size

/mob/living/basic/spider/giant/set_name()
	. = ..()
	name = "giant tarantula"
	real_name = name
