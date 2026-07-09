// random in-round events to keep things interesting

SUBSYSTEM_DEF(tfnevents)
	name = "TFN Random Events"
	runlevels = RUNLEVEL_GAME
	wait = 10 MINUTES
	var/next_event = 0
	var/frequency_lower = 20 MINUTES
	var/frequency_upper = 120 MINUTES


/datum/controller/subsystem/tfnevents/Initialize()
	reschedule()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/tfnevents/fire()
	if(world.time < next_event)
		return
	var/list/events = list()
	call(src, pick(events))()
	check_hunter_event()
	reschedule()

/datum/controller/subsystem/tfnevents/proc/reschedule()
	next_event = world.time + rand(frequency_lower, frequency_upper)



// HUNTERS
// automatically spawned if the masquerade is low enough
/datum/controller/subsystem/tfnevents/proc/check_hunter_event()
	if(length(GLOB.living_hunters) >= 10)
		return
	var/hunter_count = 0
	switch(SSmasquerade.masquerade_level)
		if(MASQUERADE_MAX_LEVEL)
			return
		if(6 to 8)
			hunter_count = rand(1, 2)
		if(3 to 5)
			hunter_count = rand(3, 5)
		if(0 to 2)
			hunter_count = rand(5, 10)
	if(!hunter_count)
		return
	var/list/warning = list("peeps...", "YOOOOO", "wtf", "Holy shit", "Wow", "ok", "crazy", "epic", "actually so annoying")
	var/list/random_description = list("saw a weird religious guy mumbling to himself",	"weird night, and now weird religious guys are out too", \
	"i swear that guy had a stake in his pocket", \
	"so [pick("weird","creepy","gross","icky","strange","bizare","odd")], a pastor \
	[pick("bumped into me", "shoved me", "held a weird thing up to my face", "wiggled a jewel at me", \
	"is walking around with an EMF reader like a ghost buster and just straight up knocked me down", \
	"yelled bible verses at me")] [pick("and didnt even apologize after", " ")]" \
	)

	var/list/spawns = list()
	for(var/obj/effect/landmark/npcactivity/L in GLOB.npc_activities)
		if(istype(L, /obj/effect/landmark/npcactivity))
			spawns += L

	if(!length(spawns))
		message_admins("ERROR: Hunter event called but coulnd't find an npcactivity spawn landmark. Tell Nimi.")
		return

	var/obj/effect/landmark/npcactivity/entry_point = pick(spawns)
	var/area/spawn_area = get_area(entry_point)
	for(var/i in 1 to hunter_count)
		var/mob/living/carbon/human/npc/walkby/hunter/spawned = new(entry_point.loc)
		SSpoints_of_interest.make_point_of_interest(spawned)

	message_admins("EVENT: The hunter event automatically triggered in [ADMIN_VERBOSEJMP(entry_point.loc)][spawn_area?.name].")
	endpost_announce("[pick(warning)], [pick(random_description)][pick(".","..."," ")]", pick("friedman1990", "mel0nman","y3ll0wgl0v3s","d3bofn1ght"))
