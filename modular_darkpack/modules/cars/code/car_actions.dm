
/datum/action/carr/headlight
	name = "Toggle Light"
	desc = "Toggle light on/off."
	button_icon_state = "lights"

/datum/action/carr/headlight/Trigger(trigger_flags)
	var/obj/vampire_car/car = owner.loc
	if(!istype(car))
		return
	car.set_headlight_on(!car.headlight_on)
	to_chat(owner, span_notice("You toggle [car]'s lights."))
	playsound(car, 'sound/items/weapons/magout.ogg', 40, TRUE)

/datum/action/carr/beep
	name = "Signal"
	desc = "Beep-beep."
	button_icon_state = "beep"

/datum/action/carr/beep/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.last_beep+10 < world.time)
			V.last_beep = world.time
			playsound(V.loc, V.beep_sound, 60, FALSE)

/datum/action/carr/stage
	name = "Toggle Transmission"
	desc = "Toggle transmission to 1, 2 or 3."
	button_icon_state = "stage"

/datum/action/carr/stage/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.stage < 3)
			V.stage = V.stage+1
		else
			V.stage = 1
		to_chat(owner, span_notice("You enable [V]'s transmission at [V.stage]."))

/datum/action/carr/baggage
	name = "Lock Baggage"
	desc = "Lock/Unlock Baggage."
	button_icon_state = "baggage"

/datum/action/carr/baggage/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/vamp_car = owner.loc
		var/datum/storage/trunk = vamp_car.atom_storage
		trunk.set_locked(trunk.locked ? STORAGE_NOT_LOCKED : STORAGE_FULLY_LOCKED)

		#warn please pick one of these
		vamp_car.balloon_alert(owner, trunk.locked ? "locked" : "unlocked")
		to_chat(owner, span_notice("You [trunk.locked ? "locked" : "unlocked"] [vamp_car]'s baggage."))

		playsound(vamp_car, 'modular_darkpack/modules/deprecated/sounds/door.ogg', 50, TRUE)

/datum/action/carr/engine
	name = "Toggle Engine"
	desc = "Toggle engine on/off."
	button_icon_state = "keys"

/datum/action/carr/engine/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(!V.on)
			if(V.get_integrity() == V.max_integrity)
				V.on = TRUE
				playsound(V, 'modular_darkpack/modules/deprecated/sounds/start.ogg', 50, TRUE)
				to_chat(owner, span_notice("You managed to start [V]'s engine."))
				return
			if(prob(100*(V.get_integrity()/V.max_integrity)))
				V.on = TRUE
				playsound(V, 'modular_darkpack/modules/deprecated/sounds/start.ogg', 50, TRUE)
				to_chat(owner, span_notice("You managed to start [V]'s engine."))
				return
			else
				to_chat(owner, span_warning("You failed to start [V]'s engine."))
				return
		else
			V.on = FALSE
			playsound(V, 'modular_darkpack/modules/deprecated/sounds/stop.ogg', 50, TRUE)
			to_chat(owner, span_notice("You stop [V]'s engine."))
			V.set_light(0)
			return

/datum/action/carr/exit_car
	name = "Exit"
	desc = "Exit the vehicle."
	button_icon_state = "exit"

/datum/action/carr/exit_car/Trigger(trigger_flags)
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.driver == owner)
			V.driver = null
		if(owner in V.passengers)
			V.passengers -= owner
		owner.forceMove(V.loc)

		var/list/exit_side = list(
			SIMPLIFY_DEGREES(V.movement_vector + 90),
			SIMPLIFY_DEGREES(V.movement_vector - 90)
		)
		for(var/angle in exit_side)
			if(get_step(owner, angle2dir(angle)).density)
				exit_side.Remove(angle)
		var/list/exit_alt = GLOB.alldirs.Copy()
		for(var/dir in exit_alt)
			if(get_step(owner, dir).density)
				exit_alt.Remove(dir)
		if(length(exit_side))
			owner.Move(get_step(owner, angle2dir(pick(exit_side))))
		else if(length(exit_alt))
			owner.Move(get_step(owner, exit_alt))

		to_chat(owner, span_notice("You exit [V]."))
		if(owner)
			if(owner.client)
				owner.client.pixel_x = 0
				owner.client.pixel_y = 0
		playsound(V, 'modular_darkpack/modules/deprecated/sounds/door.ogg', 50, TRUE)
		for(var/datum/action/carr/C in owner.actions)
			qdel(C)
