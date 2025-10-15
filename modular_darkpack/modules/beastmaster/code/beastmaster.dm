/mob/living/simple_animal/hostile/beastmaster
	name = "dog"
	desc = "Woof-woof."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "dog"
	icon_living = "dog"
	icon_dead = "dog_dead"
	del_on_death = 1
	footstep_type = FOOTSTEP_MOB_SHOE
	mob_biotypes = MOB_ORGANIC
	speak_chance = 0
	turns_per_move = 1
	speed = 0.35
//	move_to_delay = 3
//	rapid = 3
//	ranged = 1
	maxHealth = 80
	health = 85
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 25
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/dog.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 2
	maxbloodpool = 2
//	retreat_distance = 3
//	minimum_distance = 5
//	casingtype = /obj/item/ammo_casing/vampire/c556mm
//	projectilesound = 'modular_darkpack/modules/deprecated/sounds/rifle.ogg'
	loot = list()
	AIStatus = AI_OFF

	var/follow = TRUE
	var/mob/living/carbon/human/master
	var/list/enemies = list()

/mob/living/simple_animal/hostile/beastmaster/Initialize(mapload)
	. = ..()
	GLOB.beast_list += src
	RegisterSignal(src, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_hit))

/mob/living/simple_animal/hostile/beastmaster/Destroy()
	. = ..()

	if (stat >= SOFT_CRIT)
		return

	if(master)
		master.beastmaster_minions -= src
		if(!length(master.beastmaster_minions))
			for(var/datum/action/beastmaster_stay/E in master.actions)
				qdel(E)
			for(var/datum/action/beastmaster_deaggro/E in master.actions)
				qdel(E)
	GLOB.beast_list -= src

/mob/living/simple_animal/hostile/beastmaster/death(gibbed)
	. = ..()
	if(master)
		master.beastmaster_minions -= src
		if(!length(master.beastmaster_minions))
			for(var/datum/action/beastmaster_stay/E in master.actions)
				qdel(E)
			for(var/datum/action/beastmaster_deaggro/E in master.actions)
				qdel(E)
	GLOB.beast_list -= src

/mob/living/simple_animal/hostile/beastmaster/proc/handle_automated_beasting()
	if(client)
		return
	if(stat > 0)
		GLOB.beast_list -= src
		return
	if(!target)
		if(length(enemies))
			for(var/mob/living/L in enemies)
				if(L.stat < 1 && L.z == z && get_dist(src, L) < 12)
					target = L
	else if(!ismob(target) || target.z != z || get_dist(src, target) > 11 || (ismob(target) && target:stat > 0))
		target = null
		if(length(enemies))
			for(var/mob/living/L in enemies)
				if(L.stat < 1 && L.z == z && get_dist(src, L) < 12)
					target = L

	var/totalshit = 1
	if(cached_multiplicative_slowdown > 0)
		totalshit = cached_multiplicative_slowdown

	if(target)
		var/reqsteps = round((SSbeastmastering.next_fire-world.time)/totalshit)
		walk_to(src, target, reqsteps, cached_multiplicative_slowdown)
		if(get_dist(src, target) <= 1)
			ClickOn(target)
	else
		if(follow && ismob(master) && isturf(master.loc))
			var/mob/M = master
			if(M.stat != DEAD && z != M.z && get_dist(M.loc, loc) <= 10)
				forceMove(get_turf(M))
			else if(M.stat != DEAD)
				var/reqsteps = round((SSbeastmastering.next_fire-world.time)/totalshit)
				walk_to(src, M, reqsteps, cached_multiplicative_slowdown)
		else
			walk(src, 0)

/mob/living/simple_animal/hostile/beastmaster/proc/add_beastmaster_enemies(mob/living/L)
	if(istype(L, /mob/living/simple_animal/hostile/beastmaster))
		var/mob/living/simple_animal/hostile/beastmaster/M = L
		if(M.master == master)
			return
	if(L == master)
		return
	enemies |= L
	if(!target)
		target = L

/mob/living/simple_animal/hostile/beastmaster/attack_hand(mob/living/user)
	if(user)
		if(!user.combat_mode)
			for(var/mob/living/simple_animal/hostile/beastmaster/B in master.beastmaster_minions)
				B.add_beastmaster_enemies(user)
	. = ..()

/mob/living/simple_animal/hostile/beastmaster/proc/on_hit(datum/source, obj/projectile/P)
	SIGNAL_HANDLER

	if (!P?.firer)
		return

	for (var/mob/living/simple_animal/hostile/beastmaster/B in master.beastmaster_minions)
		B.add_beastmaster_enemies(P.firer)

/mob/living/simple_animal/hostile/beastmaster/attackby(obj/item/W, mob/living/user, params)
	. = ..()

	if (!user || !W.force)
		return

	if(!master)
		return

	for (var/mob/living/simple_animal/hostile/beastmaster/B in master.beastmaster_minions)
		B.add_beastmaster_enemies(user)
