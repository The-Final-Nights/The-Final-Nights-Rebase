// ! Bad code that needs to be removed

/turf
	var/list/unpassable = list()

/turf/Initialize(mapload)
	. = ..()
	if(density)
		unpassable += src

/atom/movable/Initialize(mapload)
	. = ..()
	if(density && !isitem(src))
		if(isturf(get_turf(src)))
			var/turf/T = get_turf(src)
			T.unpassable += src

/atom/movable/Destroy()
	var/turf/T = get_turf(src)
	if(T)
		T.unpassable -= src
	. = ..()

/turf/Exited(atom/movable/AM, atom/newLoc)
	. = ..()
	unpassable -= AM
	if(AM.density && !isitem(AM))
		if(isturf(newLoc))
			var/turf/T = newLoc
			T.unpassable += AM

/mob/living/death(gibbed)
	. = ..()
	var/turf/T = get_turf(src)
	if(T)
		T.unpassable -= src


/mob/living/carbon/human/mouse_drop_receive(atom/over_object)
	. = ..()
	if(istype(over_object, /obj/vampire_car) && get_dist(src, over_object) < 2)
		var/obj/vampire_car/V = over_object

		if(V.locked)
			to_chat(src, span_warning("[V] is locked."))
			return

		if(V.driver && (length(V.passengers) >= V.max_passengers))
			to_chat(src, "<span class='warning'>There's no space left for you in [V].")
			return

		visible_message(span_notice("[src] begins entering [V]..."), \
			span_notice("You begin entering [V]..."))
		if(do_after(src, 1 SECONDS, over_object))
			if(!V.driver)
				forceMove(over_object)
				V.driver = src
				var/datum/action/carr/exit_car/E = new()
				E.Grant(src)
				var/datum/action/carr/fari_vrubi/F = new()
				F.Grant(src)
				var/datum/action/carr/engine/N = new()
				N.Grant(src)
				var/datum/action/carr/stage/S = new()
				S.Grant(src)
				var/datum/action/carr/beep/B = new()
				B.Grant(src)
				if(V.baggage_limit > 0)
					var/datum/action/carr/baggage/G = new()
					G.Grant(src)
			else if(length(V.passengers) < V.max_passengers)
				forceMove(over_object)
				V.passengers += src
				var/datum/action/carr/exit_car/E = new()
				E.Grant(src)
			visible_message(span_notice("[src] enters [V]."), \
				span_notice("You enter [V]."))
			playsound(V, 'modular_darkpack/modules/deprecated/sounds/door.ogg', 50, TRUE)
			return
		else
			to_chat(src, "<span class='warning'>You fail to enter [V].")
			return
