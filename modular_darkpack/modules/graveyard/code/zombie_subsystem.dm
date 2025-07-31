SUBSYSTEM_DEF(zombiepool)
	name = "Zombie Pool"
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_VERYLOW
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 20

	var/list/currentrun = list()

/datum/controller/subsystem/zombiepool/stat_entry(msg)
	var/list/activelist = GLOB.zombie_list
	msg = "ZOMBIES:[length(activelist)]"
	return ..()

/datum/controller/subsystem/zombiepool/fire(resumed = FALSE)

	if (!resumed)
		var/list/activelist = GLOB.zombie_list
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/simple_animal/hostile/zombie/Z = currentrun[currentrun.len]
		--currentrun.len

		if (QDELETED(Z)) // Some issue causes nulls to get into this list some times. This keeps it running, but the bug is still there.
			GLOB.zombie_list -= Z
			log_world("Found a null in npc list!")
			continue

		//NPC.observed_by_player()
		if(MC_TICK_CHECK)
			return
		Z.handle_automated_patriotification()

/obj/structure/vampgate
	name = "Graveyard Gate"
	desc = "It opens and closes."
	icon = 'modular_darkpack/modules/deprecated/icons/gate.dmi'
	icon_state = "gate"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -32
	anchored = TRUE
	density = TRUE
	opacity = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/punches_to_break = 500
	var/repairing = FALSE

/obj/structure/vampgate/proc/punched()
	playsound(get_turf(src), 'modular_darkpack/modules/deprecated/sounds/get_bent.ogg', 100, FALSE)
	pixel_z = pixel_z+rand(-1, 1)
	pixel_w = pixel_w+rand(-1, 1)
	punches_to_break = max(0, punches_to_break-1)
	spawn(2)
		pixel_z = initial(pixel_z)
		pixel_w = initial(pixel_w)
		if(punches_to_break == 0)
			density = FALSE
			icon_state = "gate-open"

/obj/structure/vampgate/examine(mob/user)
	. = ..()
	var/total_health = round((100/initial(punches_to_break))*punches_to_break)
	switch(total_health)
		if(0 to 25)
			. += span_warning("<b>Density: [punches_to_break]/[initial(punches_to_break)]</b>")
		if(26 to 50)
			. += span_warning("Density: [punches_to_break]/[initial(punches_to_break)]")
		if(51 to 75)
			. += span_notice("Density: [punches_to_break]/[initial(punches_to_break)]")
		if(76 to 100)
			. += span_notice("<b>Density: [punches_to_break]/[initial(punches_to_break)]</b>")

/obj/structure/vampgate/Initialize(mapload)
	. = ..()
	GLOB.vampgate = src

/obj/structure/vampgate/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/melee/vamp/tire))
		if(!repairing)
			repairing = TRUE
			if(do_mob(user, src, 5 SECONDS))
				punches_to_break = min(punches_to_break+5, initial(punches_to_break))
				if(punches_to_break)
					density = TRUE
					icon_state = "gate"
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/repair.ogg', 50, TRUE)
				to_chat(user, span_notice("You repair some dents on [src]."))
				repairing = FALSE
			else
				to_chat(user, span_warning("You failed to repair [src]."))
				repairing = FALSE
		return
	else
		if(I.force)
			punched()
	..()
