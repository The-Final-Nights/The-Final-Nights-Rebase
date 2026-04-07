#define HOUSING_TOWNHOUSE_MAP_1 "_maps/map_files/Vampire/instanced_housing/townhomes/townhome1.dmm"
#define HOUSING_TOWNHOUSE_MAP_2 "_maps/map_files/Vampire/instanced_housing/townhomes/townhome2.dmm"


/datum/map_template/housing/townhouse
	name = "Townhouse"
	mappath = HOUSING_TOWNHOUSE_MAP
	keep_cached_map = TRUE
	should_place_on_top = FALSE

/area/housing/townhouse
	name = "Town House"
	icon = 'icons/area/areas_away_missions.dmi'
	icon_state = "away"
	default_gravity = STANDARD_GRAVITY
	ambience_index = AMBIENCE_AWAY
	sound_environment = SOUND_ENVIRONMENT_ROOM

/turf/closed/housing/border
	name = " "
	desc = "Nothing to see here."
	icon = 'icons/turf/floors.dmi'
	icon_state = "black"

/obj/effect/landmark/housing/spawnpoint
	name = "housing spawn point"

/datum/housing_instance
	var/datum/mind/owner_mind
	var/turf/spawn_turf
	var/loaded = FALSE
	var/list/guests = list()

/datum/housing_instance/proc/owner_is_home()
	var/mob/M = owner_mind?.current
	if(!M || !spawn_turf)
		return FALSE

	// instead of a for loop checking each turf's contents to find if the owner's there
	// just check their coordinates compared to their house's coordinates
	var/w = SShousing.townhouse_template.width
	var/h = SShousing.townhouse_template.height
	return (M.z == spawn_turf.z || M.z == spawn_turf.z + 1) \
		&& M.x >= spawn_turf.x && M.x < spawn_turf.x + w \
		&& M.y >= spawn_turf.y && M.y < spawn_turf.y + h

/datum/housing_instance/proc/can_enter(mob/user)
	return (user.mind == owner_mind) || (user.mind in guests)

/datum/housing_instance/proc/enter(mob/living/user)
	if(!can_enter(user))
		to_chat(user, span_warning("You don't have access to this residence."))
		return
	if(!loaded)
		if(!SShousing.load_instance(src))
			to_chat(user, span_warning("No housing plots are currently available."))
			return
	user.forceMove(spawn_turf)

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
			to_chat(guest.current, span_notice("[owner_mind.name] has allowed you to enter their home."))

SUBSYSTEM_DEF(housing)
	name = "Housing"
	dependencies = list(
		/datum/controller/subsystem/mapping,
		/datum/controller/subsystem/atoms,
	)
	ss_flags = SS_NO_FIRE

	var/datum/space_level/housing_level_1
	var/datum/space_level/housing_level_2
	var/datum/map_template/housing/townhouse/townhouse_template
	var/list/turf/available_slots = list()
	var/list/instances = list()

/datum/controller/subsystem/housing/Initialize()
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
	townhouse_template = new /datum/map_template/housing/townhouse()
	generate_slots()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/housing/proc/generate_slots()
	var/slot_w = townhouse_template.width
	var/slot_h = townhouse_template.height
	var/z = housing_level_1.z_value

	var/col = 0
	while((col * slot_w + townhouse_template.width) <= world.maxx)
		var/row = 0
		while((row * slot_h + townhouse_template.height) <= world.maxy)
			available_slots += locate(col * slot_w + 2, row * slot_h + 2, z)
			row++
		col++

/datum/controller/subsystem/housing/proc/get_instance(mob/living/user)
	return instances[user.mind]

/datum/controller/subsystem/housing/proc/assign_instance(mob/living/user)
	if(instances[user.mind])
		return instances[user.mind]
	var/datum/housing_instance/inst = new()
	inst.owner_mind = user.mind
	instances[user.mind] = inst
	return inst

/datum/controller/subsystem/housing/proc/load_instance(datum/housing_instance/inst)
	if(!available_slots.len)
		return FALSE
	var/turf/slot = available_slots[1]
	available_slots.Remove(slot)

	townhouse_template.load(slot)

	var/list/loaded_turfs = block(
		slot.x, slot.y, slot.z,
		slot.x + townhouse_template.width - 1,
		slot.y + townhouse_template.height - 1,
		slot.z,
	)
	for(var/turf/T in loaded_turfs)
		if(locate(/obj/effect/landmark/housing/spawnpoint) in T)
			inst.spawn_turf = T
			break

	if(!inst.spawn_turf)
		inst.spawn_turf = slot

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

	return list(
		"instances" = entries,
		"has_instance" = !isnull(instances[user.mind]),
		"slots_available" = available_slots.len > 0,
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

#undef HOUSING_TOWNHOUSE_MAP_1
#undef HOUSING_TOWNHOUSE_MAP_2
