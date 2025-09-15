// ! Bad code that needs to be removed

/turf/proc/get_blocking_contents(exclude_mobs = FALSE, source_atom = null, list/ignore_atoms)
	if(density)
		return list(src)

	var/list/blocking_content = list()
	for(var/content in contents)
		// We don't want to block ourselves or consider any ignored atoms.
		if((content == source_atom) || (content in ignore_atoms))
			continue
		var/atom/atom_content = content
		// If the thing is dense AND we're including mobs or the thing isn't a mob AND if there's a source atom and
		// it cannot pass through the thing on the turf,  we consider the turf blocked.
		if(atom_content.density && (!exclude_mobs || !ismob(atom_content)))
			if(source_atom && atom_content.CanPass(source_atom, src))
				continue
			blocking_content += content
	return blocking_content

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
				var/datum/action/carr/headlight/F = new()
				F.Grant(src)
				var/datum/action/carr/engine/N = new()
				N.Grant(src)
				var/datum/action/carr/stage/S = new()
				S.Grant(src)
				var/datum/action/carr/beep/B = new()
				B.Grant(src)
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
