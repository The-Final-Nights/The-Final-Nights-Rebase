/obj/effect/temp_visual/car
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	layer = BELOW_MOB_LAYER
	light_range = 1
	duration = 0.5 SECONDS

/obj/vampire_car
	name = "car"
	desc = "Take me home, country roads..."
	icon_state = "2"
	icon = 'modular_darkpack/modules/deprecated/icons/cars.dmi'
	anchored = TRUE
	//layer = CAR_LAYER
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	throwforce = 150

	glide_size = 96

	max_integrity = 500
	integrity_failure = 0.25

	var/last_vzhzh = 0

	var/image/headlight_image
	var/headlight_on = FALSE

	var/mob/living/driver
	var/list/passengers = list()
	var/max_passengers = 3

	var/speed = 1	//Future
	var/stage = 1
	var/on = FALSE
	var/locked = TRUE
	var/access = "none"

	var/repairing = FALSE

	var/last_beep = 0

	var/car_storage_type = /datum/storage/car

	var/exploded = FALSE
	var/beep_sound = 'modular_darkpack/modules/deprecated/sounds/beep.ogg'

	var/gas = 1000

	/// The sound of fermentation
	var/datum/looping_sound/boiling/soundloop

	var/movement_vector = 0 //0-359 degrees
	var/speed_in_pixels = 0 // 16 pixels (turf is 2x2m) = 1 meter per 1 SECOND (process fire). Minus equals to reverse, max should be 444
	var/last_pos = list("x" = 0, "y" = 0, "x_pix" = 0, "y_pix" = 0, "x_frwd" = 0, "y_frwd" = 0)

	COOLDOWN_DECLARE(impact_delay)

/obj/vampire_car/Initialize(mapload)
	. = ..()
	START_PROCESSING(SScarpool, src)

	create_storage(storage_type = car_storage_type)

/*
	headlight_image = new(src)
	headlight_image.icon = 'icons/effects/light_overlays/light_cone_car.dmi'
	headlight_image.icon_state = "light"
	headlight_image.pixel_x = -64
	headlight_image.pixel_y = -64
	headlight_image.layer = O_LIGHTING_VISUAL_LAYER
	headlight_image.plane = O_LIGHTING_VISUAL_PLANE
	headlight_image.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	headlight_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
//	headlight_image.vis_flags = NONE
	headlight_image.alpha = 110
*/
	gas = rand(100, 1000)
	last_pos["x"] = x
	last_pos["y"] = y
//	last_pos["x_pix"] = 32
//	last_pos["y_pix"] = 32
	switch(dir)
		if(SOUTH)
			movement_vector = 180
		if(EAST)
			movement_vector = 90
		if(WEST)
			movement_vector = 270
	add_overlay(image(icon = src.icon, icon_state = src.icon_state, pixel_x = -32, pixel_y = -32))
	icon_state = "empty"

/obj/vampire_car/Destroy()
	STOP_PROCESSING(SScarpool, src)
	empty_car()
	. = ..()

/obj/vampire_car/click_alt(mob/user)
	if(!repairing)
		if(locked)
			to_chat(user, span_warning("[src] is locked!"))
			return
		repairing = TRUE
		var/mob/living/L

		if(driver)
			L = driver
		else if(length(passengers))
			L = pick(passengers)
		else
			to_chat(user, span_notice("There's no one in [src]."))
			repairing = FALSE
			return

		user.visible_message(span_warning("[user] begins pulling someone out of [src]!"), \
			span_warning("You begin pulling [L] out of [src]..."))
		if(do_after(user, 5 SECONDS, src))
			user.visible_message(span_warning("[user] has managed to get [L] out of [src]."), \
				span_warning("You've managed to get [L] out of [src]."))
			empty_occupent(L)
		else
			to_chat(user, span_warning("You've failed to get [L] out of [src]."))
		repairing = FALSE
		return

/obj/vampire_car/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/gas_can))
		var/obj/item/gas_can/G = I
		if(G.stored_gasoline && gas < 1000 && isturf(user.loc))
			var/gas_to_transfer = min(1000-gas, min(100, max(1, G.stored_gasoline)))
			G.stored_gasoline = max(0, G.stored_gasoline-gas_to_transfer)
			gas = min(1000, gas+gas_to_transfer)
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/gas_fill.ogg', 25, TRUE)
			to_chat(user, span_notice("You transfer [gas_to_transfer] fuel to [src]."))
		return
	if(istype(I, /obj/item/vamp/keys))
		var/obj/item/vamp/keys/K = I
		if(istype(I, /obj/item/vamp/keys/hack))
			if(!repairing)
				repairing = TRUE
				if(do_after(user, 20 SECONDS, src))
					var/roll = rand(1, 20) + (user.st_get_stat(STAT_LARCENY)+user.st_get_stat(STAT_DEXTERITY)) - 8
					//(<= 1, break lockpick) (2-9, trigger car alarm), (>= 10, unlock car)
					if (roll <= 1)
						to_chat(user, span_warning("Your lockpick broke!"))
						qdel(K)
						repairing = FALSE
						return
					else if (roll >= 10)
						locked = FALSE
						repairing = FALSE
						to_chat(user, span_notice("You've managed to open [src]'s lock."))
						playsound(src, 'modular_darkpack/modules/deprecated/sounds/open.ogg', 50, TRUE)
					else
						to_chat(user, span_warning("You've failed to open [src]'s lock."))
						playsound(src, 'modular_darkpack/modules/deprecated/sounds/signal.ogg', 50, FALSE)
						for(var/mob/living/carbon/human/npc/police/P in oviewers(7, src))
							P.Aggro(user)
						repairing = FALSE
						return //Don't penalize vampire humanity if they failed.
					if(initial(access) == "none") //Stealing a car with no keys assigned to it is basically robbing a random person and not an organization
						if(ishuman(user))
							var/mob/living/carbon/human/H = user
							H.AdjustHumanity(-1, 6)
						return
				else
					to_chat(user, span_warning("You've failed to open [src]'s lock."))
					repairing = FALSE
					return
			return
		if(K.accesslocks)
			for(var/i in K.accesslocks)
				if(i == access)
					to_chat(user, span_notice("You [locked ? "open" : "close"] [src]'s lock."))
					playsound(src, 'modular_darkpack/modules/deprecated/sounds/open.ogg', 50, TRUE)
					locked = !locked
					return
		return
	if(istype(I, /obj/item/melee/vamp/tire))
		if(!repairing)
			if(atom_integrity >= max_integrity)
				to_chat(user, span_notice("[src] is already fully repaired."))
				return
			repairing = TRUE

			var time_to_repair = (max_integrity - atom_integrity) / 4 //Repair 4hp for every second spent repairing
			var start_time = world.time

			user.visible_message(span_notice("[user] begins repairing [src]..."), \
				span_notice("You begin repairing [src]. Stop at any time to only partially repair it."))
			if(do_after(user, time_to_repair SECONDS, src))
				atom_integrity = max_integrity
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/repair.ogg', 50, TRUE)
				user.visible_message(span_notice("[user] repairs [src]."), \
					span_notice("You finish repairing all the dents on [src]."))
				color = "#ffffff"
				repairing = FALSE
				return
			else
				take_damage((world.time - start_time) * -2 / 5) //partial repair
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/repair.ogg', 50, TRUE)
				user.visible_message(span_notice("[user] repairs [src]."), \
					span_notice("You repair some of the dents on [src]."))
				color = "#ffffff"
				repairing = FALSE
				return
		return

	else
		if(I.force)
			take_damage(round(I.force/2))
			for(var/mob/living/L in src)
				if(prob(50))
					L.apply_damage(round(I.force/2), I.damtype, pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST))

			if(!driver && !length(passengers) && last_beep+70 < world.time && locked)
				last_beep = world.time
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/signal.ogg', 50, FALSE)
				for(var/mob/living/carbon/human/npc/police/P in oviewers(7, src))
					P.Aggro(user)

			if(prob(10) && locked)
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/open.ogg', 50, TRUE)
				locked = FALSE

	. = ..()

/obj/vampire_car/attack_hand(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.combat_mode && H.st_get_stat(STAT_STRENGTH) > 6)
			var/atom/throw_target = get_edge_target_turf(src, user.dir)
			playsound(get_turf(src), 'modular_darkpack/modules/deprecated/sounds/bump.ogg', 100, FALSE)
			take_damage(10)
			throw_at(throw_target, rand(4, 6), 4, user)

/obj/vampire_car/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	. = ..()
	take_damage(5)
	for(var/mob/living/L in src)
		if(prob(50))
			L.apply_damage(P.damage, P.damage_type, pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST))

/obj/vampire_car/examine(mob/user)
	. = ..()
	if(user.loc == src)
		. += "<b>Gas</b>: [gas]/1000"
	if(atom_integrity < max_integrity && atom_integrity >= max_integrity-(max_integrity/4))
		. += "It's slightly dented..."
	if(atom_integrity < max_integrity-(max_integrity/4) && atom_integrity >= max_integrity/2)
		. += "It has some major dents..."
	if(atom_integrity < max_integrity/2 && atom_integrity >= max_integrity/4)
		. += "It's heavily damaged..."
	if(atom_integrity < max_integrity/4)
		. += span_warning("It appears to be falling apart...")
	if(locked)
		. += span_warning("It's locked.")
	if(driver || length(passengers))
		. += span_notice("\nYou see the following people inside:")
		for(var/mob/living/rider in src)
			. += span_notice("* [rider]")

/obj/vampire_car/atom_break(damage_flag)
	. = ..()
	on = FALSE
	set_light(0)
	color = "#919191"
	if(!exploded && prob(50))
		exploded = TRUE
		empty_car()
		explosion(loc,0,1,3,4)
		STOP_PROCESSING(SScarpool, src)

/*
/obj/vampire_car/proc/take_damage(cost)
	if(cost > 0)
		atom_integrity = max(0, atom_integrity-cost)
	if(cost < 0)
		atom_integrity = min(max_integrity, atom_integrity-cost)

	if(atom_integrity == 0)
		on = FALSE
		set_light(0)
		color = "#919191"
		if(!exploded && prob(10))
			exploded = TRUE
			empty_car()
			explosion(loc,0,1,3,4)
			STOP_PROCESSING(SScarpool, src)
	else if(prob(50) && atom_integrity <= max_integrity/2)
		on = FALSE
		set_light(0)
	return
*/

/obj/vampire_car/proc/set_headlight_on(new_value)
	if(headlight_on == new_value)
		return
	. = headlight_on
	headlight_on = new_value
	if(headlight_on)
		add_overlay(headlight_image)
	else
		cut_overlay(headlight_image)

//Dump out all living from the car
/obj/vampire_car/proc/empty_car()
	for(var/mob/living/L in src)
		L.forceMove(loc)
		for(var/datum/action/carr/car_action in L.actions)
			qdel(car_action)

/obj/vampire_car/Bump(atom/A)
	if(!A)
		return
	var/prev_speed = round(abs(speed_in_pixels)/8)
	if(!prev_speed)
		return

	if(istype(A, /mob/living))
		var/mob/living/hit_mob = A
		switch(hit_mob.mob_size)
			if(MOB_SIZE_HUGE) 	//gangrel warforms, werewolves, bears, ppl with fortitude
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/bump.ogg', 75, TRUE)
				speed_in_pixels = 0
				COOLDOWN_START(src, impact_delay, 2 SECONDS)
				hit_mob.Paralyze(1 SECONDS)
			if(MOB_SIZE_LARGE)	//ppl with fat bodytype
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/bump.ogg', 60, TRUE)
				speed_in_pixels = round(speed_in_pixels * 0.35)
				hit_mob.Knockdown(1 SECONDS)
			if(MOB_SIZE_SMALL)	//small animals
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/bump.ogg', 40, TRUE)
				speed_in_pixels = round(speed_in_pixels * 0.75)
				hit_mob.Knockdown(1 SECONDS)
			else				//everything else
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/bump.ogg', 50, TRUE)
				speed_in_pixels = round(speed_in_pixels * 0.5)
				hit_mob.Knockdown(1 SECONDS)
	else
		playsound(src, 'modular_darkpack/modules/deprecated/sounds/bump.ogg', 75, TRUE)
		speed_in_pixels = 0
		COOLDOWN_START(src, impact_delay, 2 SECONDS)

	if(driver && istype(A, /mob/living/carbon/human/npc))
		var/mob/living/carbon/human/npc/NPC = A
		NPC.Aggro(driver, TRUE)

	last_pos["x_pix"] = 0
	last_pos["y_pix"] = 0
	for(var/mob/living/L in src)
		if(L.client)
			L.client.pixel_x = 0
			L.client.pixel_y = 0
	if(istype(A, /mob/living))
		var/mob/living/L = A
		var/dam2 = prev_speed
		if(!HAS_TRAIT(L, TRAIT_TOUGH_FLESH))
			dam2 = dam2*2
		L.apply_damage(dam2, BRUTE, BODY_ZONE_CHEST)
		var/dam = prev_speed
		if(driver)
			if(HAS_TRAIT(driver, TRAIT_EXP_DRIVER))
				dam = round(dam/2)
		take_damage(dam)
	else
		var/dam = prev_speed
		if(driver)
			if(HAS_TRAIT(driver, TRAIT_EXP_DRIVER))
				dam = round(dam/2)
			driver.apply_damage(prev_speed, BRUTE, BODY_ZONE_CHEST)
		take_damage(dam)
	return

/obj/vampire_car/setDir(newdir)
	. = ..()
	apply_vector_angle()

/obj/vampire_car/Moved(atom/OldLoc, Dir)
	. = ..()
	last_pos["x"] = x
	last_pos["y"] = y

/obj/vampire_car/process(seconds_per_tick)
	speed_in_pixels = max(speed_in_pixels, -64)
	var/used_vector = movement_vector
	var/used_speed = speed_in_pixels

	if(gas <= 0)
		on = FALSE
		if(driver)
			to_chat(driver, span_warning("No fuel in the tank!"))
	if(on)
		if(last_vzhzh+10 < world.time)
			playsound(src, 'modular_darkpack/modules/deprecated/sounds/work.ogg', 25, FALSE)
			last_vzhzh = world.time
	if(!on || !driver)
		speed_in_pixels = (speed_in_pixels < 0 ? -1 : 1) * max(abs(speed_in_pixels) - 15, 0)

	car_move()

/obj/vampire_car/proc/car_move()
	forceMove(locate(last_pos["x"], last_pos["y"], z))
	pixel_x = last_pos["x_pix"]
	pixel_y = last_pos["y_pix"]
	var/moved_x = round(sin(used_vector)*used_speed)
	var/moved_y = round(cos(used_vector)*used_speed)
	if(used_speed != 0)
		var/true_movement_angle = used_vector
		if(used_speed < 0)
			true_movement_angle = SIMPLIFY_DEGREES(used_vector+180)
		var/turf/check_turf = locate( \
			x + (moved_x < 0 ? -1 : 1) * round(max(abs(moved_x), 36) / 32), \
			y + (moved_y < 0 ? -1 : 1) * round(max(abs(moved_y), 36) / 32), \
			z
		)
		var/turf/check_turf_ahead = locate( \
			x + (moved_x < 0 ? -1 : 1) * round(max(abs(moved_x), 18) / 16), \
			y + (moved_y < 0 ? -1 : 1) * round(max(abs(moved_y), 18) / 16), \
			z
		)
		for(var/turf/T in get_line(src, check_turf_ahead))
			if(length(T.unpassable))
				for(var/contact in T.unpassable)
					//make NPC move out of car's way
					if(istype(contact, /mob/living/carbon/human/npc))
						var/mob/living/carbon/human/npc/NPC = contact
						if(COOLDOWN_FINISHED(NPC, car_dodge) && !HAS_TRAIT(NPC, TRAIT_INCAPACITATED))
							var/list/dodge_direction = list(
								SIMPLIFY_DEGREES(movement_vector + 45),
								SIMPLIFY_DEGREES(movement_vector - 45),
								SIMPLIFY_DEGREES(movement_vector + 90),
								SIMPLIFY_DEGREES(movement_vector - 90),
							)
							for(var/angle in dodge_direction)
								if(get_step(NPC, angle2dir(angle)).density)
									dodge_direction.Remove(angle)
							if(length(dodge_direction))
								step(NPC, angle2dir(pick(dodge_direction)), NPC.total_multiplicative_slowdown())
								COOLDOWN_START(NPC, car_dodge, 2 SECONDS)
								if(prob(50))
									NPC.realistic_say(pick(NPC.socialrole.car_dodged))

		var/turf/hit_turf
		var/list/in_line = get_line(src, check_turf)
		for(var/turf/T in in_line)
			var/dist_to_hit = get_dist_in_pixels(last_pos["x"]*32+last_pos["x_pix"], last_pos["y"]*32+last_pos["y_pix"], T.x*32, T.y*32)
			if(dist_to_hit <= used_speed)
				var/list/stuff = T.unpassable.Copy()
				stuff -= src
				for(var/contact in stuff)
					if(istype(contact, /mob/living/carbon/human/npc))
						var/mob/living/carbon/human/npc/NPC = contact
						if(NPC.IsKnockdown())
							stuff -= contact
				if(length(stuff))
					if(!hit_turf || dist_to_hit < get_dist_in_pixels(last_pos["x"]*32+last_pos["x_pix"], last_pos["y"]*32+last_pos["y_pix"], hit_turf.x*32, hit_turf.y*32))
						hit_turf = T
		if(hit_turf)
			Bump(pick(hit_turf.unpassable))
			// to_chat(world, "I can't pass that [hit_turf] at [hit_turf.x] x [hit_turf.y] cause of [pick(hit_turf.unpassable)] FUCK")
			// var/bearing = get_angle_raw(x, y, pixel_x, pixel_y, hit_turf.x, hit_turf.y, 0, 0)
			var/actual_distance = get_dist_in_pixels(last_pos["x"]*32+last_pos["x_pix"], last_pos["y"]*32+last_pos["y_pix"], hit_turf.x*32, hit_turf.y*32)-32
			moved_x = round(sin(true_movement_angle)*actual_distance)
			moved_y = round(cos(true_movement_angle)*actual_distance)
			if(last_pos["x"]*32+last_pos["x_pix"] > hit_turf.x*32)
				moved_x = max((hit_turf.x*32+32)-(last_pos["x"]*32+last_pos["x_pix"]), moved_x)
			if(last_pos["x"]*32+last_pos["x_pix"] < hit_turf.x*32)
				moved_x = min((hit_turf.x*32-32)-(last_pos["x"]*32+last_pos["x_pix"]), moved_x)
			if(last_pos["y"]*32+last_pos["y_pix"] > hit_turf.y*32)
				moved_y = max((hit_turf.y*32+32)-(last_pos["y"]*32+last_pos["y_pix"]), moved_y)
			if(last_pos["y"]*32+last_pos["y_pix"] < hit_turf.y*32)
				moved_y = min((hit_turf.y*32-32)-(last_pos["y"]*32+last_pos["y_pix"]), moved_y)
	var/turf/west_turf = get_step(src, WEST)
	if(length(west_turf.unpassable))
		moved_x = max(-8-last_pos["x_pix"], moved_x)
	var/turf/east_turf = get_step(src, EAST)
	if(length(east_turf.unpassable))
		moved_x = min(8-last_pos["x_pix"], moved_x)
	var/turf/north_turf = get_step(src, NORTH)
	if(length(north_turf.unpassable))
		moved_y = min(8-last_pos["y_pix"], moved_y)
	var/turf/south_turf = get_step(src, SOUTH)
	if(length(south_turf.unpassable))
		moved_y = max(-8-last_pos["y_pix"], moved_y)

	for(var/mob/living/rider in src)
		if(rider.client)
			rider.client.pixel_x = last_pos["x_frwd"]
			rider.client.pixel_y = last_pos["y_frwd"]
			animate(rider.client, \
				pixel_x = last_pos["x_pix"] + moved_x * 2, \
				pixel_y = last_pos["y_pix"] + moved_y * 2, \
				SScarpool.wait, 1)

	animate(src, pixel_x = last_pos["x_pix"]+moved_x, pixel_y = last_pos["y_pix"]+moved_y, SScarpool.wait, 1)

	last_pos["x_frwd"] = last_pos["x_pix"] + moved_x * 2
	last_pos["y_frwd"] = last_pos["y_pix"] + moved_y * 2
	last_pos["x_pix"] = last_pos["x_pix"] + moved_x
	last_pos["y_pix"] = last_pos["y_pix"] + moved_y

	var/x_add = (last_pos["x_pix"] < 0 ? -1 : 1) * round((abs(last_pos["x_pix"]) + 16) / 32)
	var/y_add = (last_pos["y_pix"] < 0 ? -1 : 1) * round((abs(last_pos["y_pix"]) + 16) / 32)

	last_pos["x_frwd"] -= x_add * 32
	last_pos["y_frwd"] -= y_add * 32
	last_pos["x_pix"] -= x_add * 32
	last_pos["y_pix"] -= y_add * 32

	last_pos["x"] = clamp(last_pos["x"] + x_add, 1, world.maxx)
	last_pos["y"] = clamp(last_pos["y"] + y_add, 1, world.maxy)

/obj/vampire_car/relaymove(mob/living/carbon/human/driver, direct)
	if(!COOLDOWN_FINISHED(src, impact_delay))
		return
	if(driver.IsUnconscious() || HAS_TRAIT(driver, TRAIT_INCAPACITATED) || HAS_TRAIT(driver, TRAIT_RESTRAINED))
		return
	var/turn_speed = min(abs(speed_in_pixels) / 10, 3)
	switch(direct)
		if(NORTH)
			controlling(1, 0)
		if(NORTHEAST)
			controlling(1, turn_speed)
		if(NORTHWEST)
			controlling(1, -turn_speed)
		if(SOUTH)
			controlling(-1, 0)
		if(SOUTHEAST)
			controlling(-1, turn_speed)
		if(SOUTHWEST)
			controlling(-1, -turn_speed)
		if(EAST)
			controlling(0, turn_speed)
		if(WEST)
			controlling(0, -turn_speed)

/obj/vampire_car/proc/controlling(adjusting_speed, adjusting_turn)
	var/drift = 1
	if(driver)
		if(HAS_TRAIT(driver, TRAIT_EXP_DRIVER))
			drift = 2
	var/adjust_true = adjusting_turn
	if(speed_in_pixels != 0)
		movement_vector = SIMPLIFY_DEGREES(movement_vector+adjust_true)
		apply_vector_angle()
	if(adjusting_speed)
		if(on)
			if(adjusting_speed > 0 && speed_in_pixels <= 0)
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/stopping.ogg', 10, FALSE)
				speed_in_pixels = speed_in_pixels+adjusting_speed*3
				movement_vector = SIMPLIFY_DEGREES(movement_vector+adjust_true*drift)
			else if(adjusting_speed < 0 && speed_in_pixels > 0)
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/stopping.ogg', 10, FALSE)
				speed_in_pixels = speed_in_pixels+adjusting_speed*3
				movement_vector = SIMPLIFY_DEGREES(movement_vector+adjust_true*drift)
			else
				speed_in_pixels = min(stage*64, max(-stage*64, speed_in_pixels+adjusting_speed*stage))
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/drive.ogg', 10, FALSE)
		else
			if(adjusting_speed > 0 && speed_in_pixels < 0)
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/stopping.ogg', 10, FALSE)
				speed_in_pixels = min(0, speed_in_pixels+adjusting_speed*3)
				movement_vector = SIMPLIFY_DEGREES(movement_vector+adjust_true*drift)
			else if(adjusting_speed < 0 && speed_in_pixels > 0)
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/stopping.ogg', 10, FALSE)
				speed_in_pixels = max(0, speed_in_pixels+adjusting_speed*3)
				movement_vector = SIMPLIFY_DEGREES(movement_vector+adjust_true*drift)

/obj/vampire_car/proc/apply_vector_angle()
	var/turn_state = round(SIMPLIFY_DEGREES(movement_vector + 22.5) / 45)
	dir = GLOB.modulo_angle_to_dir[turn_state + 1]
	var/minus_angle = turn_state * 45

	var/matrix/M = matrix()
	M.Turn(movement_vector - minus_angle)
	transform = M

/datum/storage/car
	max_slots = 40
	max_total_storage = 100
	max_specific_storage = WEIGHT_CLASS_HUGE

/datum/storage/car/limo
	max_slots = 45

/datum/storage/car/truck
	max_slots = 100
	max_total_storage = 200
	max_specific_storage = WEIGHT_CLASS_GIGANTIC

/datum/storage/car/van
	max_slots = 60
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
