// random in-round events to keep things interesting

SUBSYSTEM_DEF(tfnevents)
	name = "TFN Random Events"
	runlevels = RUNLEVEL_GAME
	wait = 10 MINUTES
	var/next_event = 0
	var/frequency_lower = 20 MINUTES
	var/frequency_upper = 120 MINUTES
	var/list/power_outage_pool = list(
		/area/vtm/interior/police,
		/area/vtm/interior/jazzclub,
		/area/vtm/interior/museum,
		/area/vtm/interior/bianchiBank,
		/area/vtm/interior/clinic,
		/area/vtm/interior/techshop
	)

/datum/controller/subsystem/tfnevents/Initialize()
	reschedule()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/tfnevents/fire()
	if(world.time < next_event)
		return
	var/list/events = list(
		PROC_REF(run_power_outage_event),
		PROC_REF(run_turfwar_event),
		PROC_REF(run_spider_event),
	)
	call(src, pick(events))()
	reschedule()

/datum/controller/subsystem/tfnevents/proc/reschedule()
	next_event = world.time + rand(frequency_lower, frequency_upper)

/datum/controller/subsystem/tfnevents/proc/run_power_outage_event()
	if(!length(power_outage_pool))
		return

	var/target_area_type = pick(power_outage_pool)
	power_outage_pool -= target_area_type
	var/area/target_area = locate(target_area_type)
	if(!target_area)
		return

	var/list/blown = list()
	for(var/obj/fusebox/box in target_area)
		if(box.damaged > 100) // dont doubly blow the thing if its already blown from say, the faulty grid event
			continue
		box.damaged = 150
		box.check_damage()
		blown += box

	if(!length(blown))
		message_admins("ERROR: Power outage event called but [target_area.name] had no fuseboxes. Tell Nimi.")
		return
	message_admins("EVENT: The power outage event triggered in [target_area.name].")
	endpost_announce("Reports of power outages in [target_area.name]. Bring wirecutters if you want to help.", "SF Grid Watchers")

/datum/controller/subsystem/tfnevents/proc/run_turfwar_event()
	if(length(GLOB.living_turfwar_npcs))
		return
	var/list/spawns_a = list()
	var/list/spawns_b = list()
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
	for(var/obj/effect/landmark/L in GLOB.landmarks_list)
		if(istype(L, /obj/effect/landmark/gangster_spawn/a))
			spawns_a += L
		else if(istype(L, /obj/effect/landmark/gangster_spawn/b))
			spawns_b += L

	if(!length(spawns_a) || !length(spawns_b)) // these are message_admins because its not a critical enough issue that gangsters arent murdering each other or power grids failing to warrant runtimes
		message_admins("ERROR: Turfwar event called but gangster spawn landmarks are missing.")
		return

	var/gang_a_name = pick(gang_names)
	var/gang_b_name = pick(gang_names - gang_a_name)

	var/a_count = rand(4, 8)
	for(var/i in 1 to a_count)
		var/obj/effect/landmark/gangster_spawn/a/entry_point = pick(spawns_a)
		var/mob/living/basic/trooper/gangster/spawned
		if(prob(15))
			spawned = new /mob/living/basic/trooper/gangster/ranged(entry_point.loc)
		else
			spawned = new /mob/living/basic/trooper/gangster/melee(entry_point.loc)
		spawned.name = "[gang_a_name] [pick("Thug", "Gangster", "Bruiser", "Recruit")]"
		SSpoints_of_interest.make_point_of_interest(spawned)

	var/b_count = rand(4, 8)
	for(var/i in 1 to b_count)
		var/obj/effect/landmark/gangster_spawn/b/entry_point = pick(spawns_b)
		var/mob/living/basic/trooper/gangster/rival_spawned
		if(prob(15))
			rival_spawned = new /mob/living/basic/trooper/gangster/ranged/rival(entry_point.loc)
		else
			rival_spawned = new /mob/living/basic/trooper/gangster/melee/rival(entry_point.loc)
		rival_spawned.name = "[gang_b_name] [pick("Thug", "Gangster", "Bruiser", "Recruit")]"
		SSpoints_of_interest.make_point_of_interest(rival_spawned)
	message_admins("EVENT: The turfwar event triggered.")
	endpost_announce("[pick(warning)], [gang_a_name] [pick(random_description)] [gang_b_name].", pick("friedman1990", "mel0nman","y3ll0wgl0v3s","d3bofn1ght"))

// currently uncapped
/datum/controller/subsystem/tfnevents/proc/run_spider_event()
	var/list/warning = list("peeps...", "YOOOOO", "wtf", "Holy shit", "Wow")
	var/list/random_description = list("I just saw a HUGE spider",
	"there are like a TON of spiders",
	"a million fucking spiders",
	"like [pick("seventeen","twenty","three","eighty four","nine","eleven","a dozen")] spiders",
	"absolute nightmare fuel")

	var/list/spawns = list()
	for(var/obj/effect/landmark/L in GLOB.landmarks_list)
		if(istype(L, /obj/effect/landmark/spider_spawn))
			spawns += L

	if(!length(spawns))
		message_admins("ERROR: Spider event called but spider spawn landmarks are missing. Tell Nimi.")
		return

	var/obj/effect/landmark/spider_spawn/entry_point = pick(spawns)
	var/area/spawn_area = get_area(entry_point)

	var/spider_count = rand(3, 6)
	for(var/i in 1 to spider_count)
		var/mob/living/basic/spider/growing/young/event/spawned = new(entry_point.loc)
		SSpoints_of_interest.make_point_of_interest(spawned)

	message_admins("EVENT: The spider infestation triggered in [ADMIN_VERBOSEJMP(entry_point.loc)][spawn_area?.name].")
	endpost_announce("[pick(warning)], [pick(random_description)] near the [spawn_area?.name][pick(".","..."," ")]", pick("friedman1990", "mel0nman","y3ll0wgl0v3s","d3bofn1ght"))
