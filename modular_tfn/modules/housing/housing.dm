// the map templates for each townhouse variant. keep_cached_map means each dmm is
// parsed once and reused for every load rather than re-read from disk each time.
/datum/map_template/housing/townhouse
	keep_cached_map = TRUE
	should_place_on_top = FALSE

/datum/map_template/housing/townhouse/variant1
	name = "Townhouse 1"
	mappath = "_maps/map_files/Vampire/instanced_housing/townhomes/townhome1.dmm"

/datum/map_template/housing/townhouse/variant2
	name = "Townhouse 2"
	mappath = "_maps/map_files/Vampire/instanced_housing/townhomes/townhome2.dmm"

// area used by all housing instances. treated as an away mission
/area/housing/townhouse
	name = "Town House"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away"
	default_gravity = STANDARD_GRAVITY
	ambience_index = AMBIENCE_AWAY
	sound_environment = SOUND_ENVIRONMENT_ROOM

// invisible solid wall used as the outer border of each housing dmm
// players cannot walk through or see past the edge of their plot
/turf/closed/housing/border
	name = " "
	desc = "Nothing to see here."
	icon = 'icons/turf/floors.dmi'
	icon_state = "black"

// placed this inside the 12x12 .dmm to mark the turf the person starts on when entering a house
// uses a custom type instead of awaystart because awaystart returns INITIALIZE_HINT_QDEL
// and deletes itself before we can find it bc housing spins up as needed, not at the start. easier this way
/obj/effect/landmark/housing/spawnpoint
	name = "housing spawn point"

// /datum/housing_instance tracks a single loaded housing plot and who has access to it.
// keyed by datum/mind so it follows the character, not the account or mob.
// that way if someone matrixes out and returns as a diff character, they dont spawn into their other char's house
// theres a LOT of room on a z level, over a hundred plots by my girlmath, so this shouldnt be an issue unless
// multiple people are spinning up multiple housing instances. if that happens ill eat my shoe and refactor
/datum/housing_instance
	var/datum/mind/owner_mind
	// the turf_reservation that owns the physical space on the housing z-level.
	// handles slot tracking and allows Release() to free the space later.
	var/datum/turf_reservation/reservation
	// the turf the owner and guests are moved to on entry.
	// found by scanning the loaded block for the spawnpoint landmark.
	var/turf/spawn_turf
	var/loaded = FALSE
	var/list/guests = list()

// checks whether the owner's current mob is physically inside this plot via coordinate math
// uses the reservation's bounding corners so it works regardless of
// where the slot landed on the z-level and avoids needing to do costly 'for x in y' for every turf
// checks both z-levels: floor 1 is BL.z, floor 2 is always BL.z + 1
/datum/housing_instance/proc/owner_is_home()
	var/mob/M = owner_mind?.current
	if(!M || !reservation)
		return FALSE
	var/turf/BL = reservation.bottom_left_turfs[1]
	var/turf/TR = reservation.top_right_turfs[1]
	return (M.z == BL.z || M.z == BL.z + 1) \
		&& M.x > BL.x && M.x < TR.x \
		&& M.y > BL.y && M.y < TR.y

/datum/housing_instance/proc/can_enter(mob/user)
	return (user.mind == owner_mind) || (user.mind in guests)

/datum/housing_instance/proc/enter(mob/living/user)
	if(!can_enter(user)) // just incase
		to_chat(user, span_warning("You don't have access to this residence."))
		return
	// i dont anticipate ever having 100+ housing plots loaded for this to ever fire
	// but if we do larger housing plots, the hundreds of 12x12 plots possible may get limited
	if(!loaded)
		if(!SShousing.load_instance(src))
			to_chat(user, span_warning("No housing slots are currently available."))
			return
	user.forceMove(spawn_turf)

// called when a player clicks the "allow entry" href in the knock message.
// usr is validated against the owner's current mob to prevent spoofing.
/datum/housing_instance/Topic(href, list/href_list)
	if(!usr || usr != owner_mind?.current)
		return
	if(href_list["approve"])
		var/datum/mind/guest = locate(href_list["approve"])
		if(!istype(guest, /datum/mind))
			return
		guests |= guest
		to_chat(usr, span_notice("You've allowed [guest.name] to enter your home."))
		if(guest.current)
			to_chat(guest.current, span_notice("[owner_mind.name] unlocked the door for you."))

// SS_NO_FIRE because this subsystem has no recurring work,
// it only acts in response to player actions.
// this probably doesnt need a subsystem, but it exists so xeon wont yell at me to make it a subsystem :)
SUBSYSTEM_DEF(housing)
	name = "Housing"
	dependencies = list(
		/datum/controller/subsystem/mapping,
		/datum/controller/subsystem/atoms,
	)
	ss_flags = SS_NO_FIRE

	var/datum/space_level/housing_level_1
	var/datum/space_level/housing_level_2
	// all available townhouse variants, populated during Initialize.
	// load_instance picks randomly from this list each time.
	var/list/townhouse_templates = list()

	// one entry per character who has claimed a home this round.
	// will probably evolve into addtimers() that refresh when someone enters the house once we go full persistent
	// that way we dont have a bunch of empty houses. like say, 'empty for 20 minutes? clear the instance' type shi
	var/list/instances = list()

/datum/controller/subsystem/housing/Initialize()
	// two consecutive z-levels for the two-floor dmm.
	// ZTRAIT_UP on floor 1 and ZTRAIT_DOWN on floor 2 links them for stair traversal.
	// ZTRAIT_AWAY keeps them off the main map. ZTRAIT_SECRET hides them from map votes.
	// ZTRAIT_NOPHASE prevents phase-shifting into them from outside.
	housing_level_1 = SSmapping.add_new_zlevel("Housing Floor 1", list(
		ZTRAIT_AWAY = TRUE,
		ZTRAIT_SECRET = TRUE,
		ZTRAIT_NOPHASE = TRUE,
		ZTRAIT_UP = TRUE,
	))
	housing_level_2 = SSmapping.add_new_zlevel("Housing Floor 2", list(
		ZTRAIT_AWAY = TRUE,
		ZTRAIT_SECRET = TRUE,
		ZTRAIT_NOPHASE = TRUE,
		ZTRAIT_DOWN = TRUE,
	))
	townhouse_templates = list(
		new /datum/map_template/housing/townhouse/variant1(),
		new /datum/map_template/housing/townhouse/variant2(),
	)

	// register all turfs on housing_level_1 with the turf_reservation system
	// so that reserve() can find and allocate space when a player claims a home.
	// only floor 1 is registered here. floor 2 is implicitly available
	// hasnt conflicted with anything else so far in testing
	// if we somehow need more reserved z levels, this will need another pair of z's
	// maybe if we make a z dedicated for larger houses
	var/z = housing_level_1.z_value
	var/list/housing_turfs = list()
	for(var/turf/T in block(1, 1, z, world.maxx, world.maxy, z))
		T.turf_flags |= UNUSED_RESERVATION_TURF
		housing_turfs += T
	SSmapping.unused_turfs["[z]"] = housing_turfs

	return SS_INIT_SUCCESS

/datum/controller/subsystem/housing/proc/get_instance(mob/living/user)
	return instances[user.mind]

// returns an existing 'instance' for this character or creates a new one
/datum/controller/subsystem/housing/proc/assign_instance(mob/living/user)
	if(instances[user.mind])
		return instances[user.mind]
	var/datum/housing_instance/inst = new()
	inst.owner_mind = user.mind
	instances[user.mind] = inst
	return inst

// allocates a slot on housing_level_1 via turf_reservation, then plops the dmm onto it like its a space ruin
// the reservation is width+2 by height+2 to give a 1-tile buffer on each side. still probably best to map a buffer in though
// if you dont map in a buffer, its liable to potentially have atmos issues if you have complex house builds across z levels
// like say if you have a balcony with open space on the above z, and no buffer below,
// it might give you hot n fresh space tiles that suffocate your guests
/datum/controller/subsystem/housing/proc/load_instance(datum/housing_instance/inst)
	var/datum/map_template/housing/townhouse/template = pick(townhouse_templates)
	var/datum/turf_reservation/res = new()
	if(!res.reserve(template.width + 2, template.height + 2, 1, housing_level_1.z_value))
		qdel(res)
		return FALSE

	var/turf/BL = res.bottom_left_turfs[1]
	var/turf/load_origin = locate(BL.x + 1, BL.y + 1, BL.z)
	template.load(load_origin)
	inst.reservation = res

	var/list/loaded_turfs = block(
		load_origin.x, load_origin.y, load_origin.z,
		load_origin.x + template.width - 1,
		load_origin.y + template.height - 1,
		load_origin.z,
	)
	for(var/turf/T in loaded_turfs)
		if(locate(/obj/effect/landmark/housing/spawnpoint) in T)
			inst.spawn_turf = T
			break

	if(!inst.spawn_turf)
		inst.spawn_turf = load_origin

	inst.loaded = TRUE
	return TRUE

/datum/controller/subsystem/housing/ui_state(mob/user)
	return GLOB.always_state

/datum/controller/subsystem/housing/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HousingBrowser", "Housing Directory")
		ui.open()

/datum/controller/subsystem/housing/ui_data(mob/user)
	var/list/entries = list()
	for(var/datum/mind/M in instances)
		var/datum/housing_instance/inst = instances[M]
		if(!inst.loaded)
			continue
		entries += list(list(
			"owner_name" = M.name,
			"ref" = REF(inst),
			// so the ui knows whether to show "enter" or "knock". changes if u have been invited in or not
			"can_enter" = inst.can_enter(user),
			"is_own" = (M == user.mind),
		))

	var/datum/housing_instance/my_inst = instances[user.mind]
	var/list/guests = list()
	if(my_inst?.loaded)
		for(var/datum/mind/G in my_inst.guests)
			guests += list(list(
				"name" = G.name,
				"ref" = REF(G),
			))

	// slots_available is a rough check: non-empty unused_turfs means there is prolly
	// space for at least one more plot. the actual check happens inside reserve(), thank u /tg/ coders
	var/z = housing_level_1.z_value
	return list(
		"instances" = entries,
		"has_instance" = !isnull(instances[user.mind]),
		"slots_available" = !!(length(SSmapping.unused_turfs["[z]"])),
		"guests" = guests,
	)

/datum/controller/subsystem/housing/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return FALSE
	switch(action)
		if("exit")
			var/atom/destination = ui.user.mind?.assigned_role?.get_latejoin_spawn_point() // a subway spawnpoint
			if(!destination)
				return FALSE
			ui.user.forceMove(destination)
			return TRUE
		if("go_home")
			var/datum/housing_instance/inst = assign_instance(ui.user)
			if(!inst.loaded)
				if(!load_instance(inst))
					to_chat(ui.user, span_warning("No housing plots are currently available."))
					return FALSE
			ui.user.forceMove(inst.spawn_turf)
			return TRUE
		if("knock")
			var/datum/housing_instance/inst = locate(params["ref"])
			if(!istype(inst, /datum/housing_instance) || !inst.loaded)
				return FALSE
			if(inst.can_enter(ui.user) || !ui.user.mind)
				return FALSE
			if(!inst.owner_is_home())
				to_chat(ui.user, span_warning("Nobody appears to be home."))
				return FALSE
			var/mob/owner_mob = inst.owner_mind.current
			var/approve_link = "<a href='?src=[REF(inst)];approve=[REF(ui.user.mind)]'>Allow entry</a>"
			to_chat(owner_mob, span_notice("[ui.user.mind.name] is knocking on your door! [approve_link]"))
			to_chat(ui.user, span_notice("You knock on [inst.owner_mind.name]'s door."))
			return TRUE
		if("remove_guest")
			var/datum/housing_instance/inst = instances[ui.user.mind]
			if(!inst?.loaded)
				return FALSE
			var/datum/mind/guest = locate(params["ref"])
			if(!istype(guest, /datum/mind))
				return FALSE
			inst.guests -= guest
			return TRUE
		if("teleport")
			var/datum/housing_instance/inst = locate(params["ref"])
			if(!istype(inst, /datum/housing_instance))
				return FALSE
			inst.enter(ui.user)
			return TRUE
	return FALSE

/obj/structure/roadsign/housing_sign
	icon = 'modular_darkpack/modules/decor/icons/city_map.dmi'
	icon_state = "map"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/roadsign/housing_sign/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	SShousing.ui_interact(user)
	return TRUE
