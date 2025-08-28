/atom/Click()
	. = ..()

	if(isliving(usr) && usr != src)
		var/mob/living/L = usr
		if(L.prepared_to_jump)
			L.jump(src)

/mob/proc/jump(atom/target)
	SEND_SIGNAL(src, COMSIG_MOB_THROW, target)
	return

/mob/living/carbon/jump(atom/target)
	. = ..()
	if(!target || !isturf(loc))
		return
	if(istype(target, /atom/movable/screen))
		return
	if(lying_angle != STANDING_UP)
		return

	var/mob/living/carbon/H = src
	var/strength = H.st_get_stat(STAT_STRENGTH)
	var/dexterity = H.st_get_stat(STAT_DEXTERITY)
	var/athletics = H.st_get_stat(STAT_ATHLETICS)

	if(HAS_TRAIT(H, TRAIT_IMMOBILIZED) || H.legcuffed)
		return
	if(pulledby && H.pulledby.grab_state >= GRAB_PASSIVE)
		return

	var/current_time = world.time
	var/adjusted_jump_delay = JUMP_DELAY - (0.4 * dexterity) - (1 * athletics)
	if(current_time - last_jump_time < adjusted_jump_delay)
		to_chat(src, "<span class='notice'>You can't jump so soon!")
		return

	var/adjusted_jump_range = MAX_JUMP_DISTANCE

	if(strength < 2)
		adjusted_jump_range += 0.75 + athletics
	else
		adjusted_jump_range += 0.75 + (strength -1) * 0.5 + athletics

	if(adjusted_jump_range > 6)
		adjusted_jump_range = 6
	if(adjusted_jump_range <1)
		adjusted_jump_range = 1

	// very high override for powers like Jade Shintai 2
	if(HAS_TRAIT(src, TRAIT_SUPERNATURAL_DEXTERITY))
		adjusted_jump_range = 11

	var/distance = get_dist(loc, target)
	var/turf/adjusted_target = target
	if(distance > adjusted_jump_range)
		var/dx = target.x - loc.x
		var/dy = target.y - loc.y
		var/scale = adjusted_jump_range / distance
		adjusted_target = locate(loc.x + round(dx * scale), loc.y + round(dy * scale), loc.z)
	playsound(loc, 'modular_darkpack/modules/deprecated/sounds/jump_neutral.ogg', 50, TRUE)

	var/atom/movable/thrown_thing = src

	if(thrown_thing)
		var/turf/start_T = get_turf(loc) //Get the start and target tile for the descriptors
		var/turf/end_T = get_turf(target)
		if(start_T && end_T)
			log_combat(src, thrown_thing, "jumped", addition="from tile in [AREACOORD(start_T)] towards tile at [AREACOORD(end_T)]")
		var/power_throw = 0
		//Move the player towards the target

		newtonian_move(get_dir(adjusted_target, src))
		thrown_thing.safe_throw_at(adjusted_target, thrown_thing.throw_range, thrown_thing.throw_speed + power_throw, src, null, null, null, move_force, spin = FALSE)
		visible_message(span_danger("[src] jumps towards [adjusted_target]."))



		var/travel_time = distance * 0.5
		spawn(travel_time)
			if(get_dist(loc, adjusted_target) <= 1 && H.st_get_stat(STAT_STRENGTH) > 0)
				H.epic_fall(FALSE, FALSE)


//		newtonian_move(get_dir(target, src))
//		thrown_thing.safe_throw_at(target, thrown_thing.throw_range, thrown_thing.throw_speed + power_throw, src, null, null, null, move_force)
//		visible_message(span_danger("[src] jumps towards [target]."))

		last_jump_time = current_time
