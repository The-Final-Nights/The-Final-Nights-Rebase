#define HOUSING_TOWNHOUSE_MAP_1 "_maps/map_files/Vampire/instanced_housing/townhomes/townhome1.dmm"
#define HOUSING_TOWNHOUSE_MAP_2 "_maps/map_files/Vampire/instanced_housing/townhomes/townhome2.dmm"
#define HOUSING_BIGHOME_MAP_1 "_maps/map_files/Vampire/instanced_housing/bighomes/big_home1.dmm"

#define HOUSING_SIZE_MEDIUM 1
#define HOUSING_SIZE_LARGE 2

/datum/map_template/housing/townhouse/one
	name = "Townhouse"
	mappath = HOUSING_TOWNHOUSE_MAP_1
	keep_cached_map = TRUE
	should_place_on_top = FALSE

/datum/map_template/housing/townhouse/two
	name = "Townhouse"
	mappath = HOUSING_TOWNHOUSE_MAP_2
	keep_cached_map = TRUE
	should_place_on_top = FALSE

/datum/map_template/housing/bighouse
	name = "Big House"
	mappath = HOUSING_BIGHOME_MAP_1
	keep_cached_map = TRUE
	should_place_on_top = FALSE

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
	var/turf/slot_origin
	var/loaded = FALSE
	var/locked = TRUE
	var/list/guests = list()
	var/size = HOUSING_SIZE_MEDIUM
	var/house_name = ""

/datum/housing_instance/proc/owner_is_home()
	var/mob/M = owner_mind?.current
	if(!M || !slot_origin)
		return FALSE

	var/datum/map_template/tmpl = size == HOUSING_SIZE_LARGE ? SShousing.bighouse_template : SShousing.townhouse_template_one
	return (M.z == slot_origin.z || M.z == slot_origin.z + 1) \
		&& M.x >= slot_origin.x && M.x < slot_origin.x + tmpl.width \
		&& M.y >= slot_origin.y && M.y < slot_origin.y + tmpl.height

/datum/housing_instance/proc/can_enter(mob/user)
	return !locked || (user.mind == owner_mind) || (user.mind in guests)

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
	var/datum/map_template/housing/townhouse/one/townhouse_template_one
	var/datum/map_template/housing/townhouse/two/townhouse_template_two
	var/datum/map_template/housing/bighouse/bighouse_template
	var/list/available_slots = list() // list of list(x, y, z). the missile knows where it is etc
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
	townhouse_template_one = new /datum/map_template/housing/townhouse/one()
	townhouse_template_two = new /datum/map_template/housing/townhouse/two()
	bighouse_template = new /datum/map_template/housing/bighouse()
	generate_slots()
	return SS_INIT_SUCCESS

// this happens at init time once, and in my tests it took less than a second to complete
/datum/controller/subsystem/housing/proc/generate_slots()
	var/slot_w = 25
	var/slot_h = 25
	var/z = housing_level_1.z_value

	var/col = 0
	while((col * slot_w + slot_w) <= world.maxx)
		var/row = 0
		while((row * slot_h + slot_h) <= world.maxy)
			available_slots += list(list(col * slot_w + 2, row * slot_h + 2, z))
			row++
		col++
	message_admins("Housing: generated [available_slots.len] slots (world: [world.maxx]x[world.maxy], z=[z])")

/datum/controller/subsystem/housing/proc/get_instance(mob/living/user)
	return instances[user.mind]

// checks if the specified mob is in an instanced housing plot
/datum/controller/subsystem/housing/proc/is_in_housing(mob/user)
	for(var/datum/mind/M in instances)
		var/datum/housing_instance/inst = instances[M]
		if(!inst.loaded || !inst.slot_origin)
			continue
		var/datum/map_template/tmpl = inst.size == HOUSING_SIZE_LARGE ? bighouse_template : townhouse_template_one
		if((user.z == inst.slot_origin.z || user.z == inst.slot_origin.z + 1) \
			&& user.x >= inst.slot_origin.x && user.x < inst.slot_origin.x + tmpl.width \
			&& user.y >= inst.slot_origin.y && user.y < inst.slot_origin.y + tmpl.height)
			return TRUE
	return FALSE

/datum/controller/subsystem/housing/proc/assign_instance(mob/living/user)
	if(instances[user.mind])
		return instances[user.mind]
	var/datum/housing_instance/inst = new()
	inst.owner_mind = user.mind
	instances[user.mind] = inst
	return inst

/datum/controller/subsystem/housing/proc/load_instance(datum/housing_instance/inst, mob/living/carbon/human/user)
	if(!available_slots.len)
		message_admins("Housing: load_instance failed - no slots remaining")
		return FALSE
	var/list/coords = available_slots[1]
	available_slots.Cut(1, 2)
	var/turf/slot = locate(coords[1], coords[2], coords[3])
	if(!slot)
		message_admins("Housing: locate() returned null for coords ([coords[1]], [coords[2]], [coords[3]]) - [available_slots.len] slots remaining")
		return FALSE
	message_admins("Housing: loading instance at ([coords[1]], [coords[2]], [coords[3]]) - [available_slots.len] slots remaining")
	inst.slot_origin = slot

	var/list/loaded_turfs
	inst.size = user.st_get_stat(STAT_FINANCE) == 5 ? 2 : 1
	if(inst.size == 1) // randomly picks between the townhouses. just different colors
		var/datum/map_template/housing/townhouse/chosen = pick(townhouse_template_one, townhouse_template_two)
		chosen.load(slot)
		loaded_turfs = block(
		slot.x, slot.y, slot.z,
		slot.x + chosen.width - 1,
		slot.y + chosen.height - 1,
		slot.z,
		)
	else
		bighouse_template.load(slot)
		loaded_turfs = block(
		slot.x, slot.y, slot.z,
		slot.x + bighouse_template.width - 1,
		slot.y + bighouse_template.height - 1,
		slot.z,
		)


	for(var/turf/T in loaded_turfs)
		if(locate(/obj/effect/landmark/housing/spawnpoint) in T)
			inst.spawn_turf = T
			break

	if(!inst.spawn_turf)
		message_admins("Housing: no spawnpoint landmark found in loaded turfs, falling back to slot origin ([slot.x], [slot.y], [slot.z])")
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
			"house_name" = inst.house_name,
			"ref" = REF(inst),
			"can_enter" = inst.can_enter(user),
			"is_own" = (M == user.mind),
			"locked" = inst.locked,
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
			var/mob/living/escorted = isliving(ui.user.pulling) ? ui.user.pulling : null
			ui.user.forceMove(destination)
			if(escorted)
				escorted.forceMove(destination)
			return TRUE
		if("go_home")
			var/donator_tier = ui.user.client?.prefs?.donator_rank
			if(donator_tier != "Antediluvian" && donator_tier != "Caine")
				to_chat(ui.user, span_warning("Anyone can visit houses, but you must be an Antediluvian tier donator or above to claim yours."))
				return FALSE
			if(is_in_housing(ui.user))
				to_chat(ui.user, span_warning("You must leave the house you are in first."))
				return FALSE
			var/datum/housing_instance/inst = assign_instance(ui.user)
			if(!inst.loaded)
				if(!load_instance(inst, ui.user))
					to_chat(ui.user, span_warning("No housing slots are currently available."))
					return FALSE
			var/mob/living/dragged_guest = isliving(ui.user.pulling) ? ui.user.pulling : null
			ui.user.forceMove(inst.spawn_turf)
			if(dragged_guest?.mind)
				inst.guests |= dragged_guest.mind
				dragged_guest.forceMove(inst.spawn_turf)
			return TRUE
		if("knock")
			var/datum/housing_instance/inst = locate(params["ref"])
			if(!istype(inst, /datum/housing_instance) || !inst.loaded)
				return FALSE
			if(inst.can_enter(ui.user) || !ui.user.mind)
				return FALSE
			if(!inst.owner_is_home())
				to_chat(ui.user, span_warning("Nobody appears to be home. Try again in a little while."))
				return FALSE
			var/mob/owner_mob = inst.owner_mind.current
			var/approve_link = "<a href='?src=[REF(inst)];approve=[REF(ui.user.mind)]'>Allow entry</a>"
			to_chat(owner_mob, span_notice("[ui.user.mind.name] is knocking on your door! [approve_link]"))
			to_chat(ui.user, span_notice("You knock on [inst.owner_mind.name]'s door."))
			return TRUE
		if("toggle_lock")
			var/datum/housing_instance/inst = instances[ui.user.mind]
			if(!inst?.loaded)
				return FALSE
			inst.locked = !inst.locked
			return TRUE
		if("rename")
			var/datum/housing_instance/inst = instances[ui.user.mind]
			if(!inst?.loaded)
				return FALSE
			var/new_name = tgui_input_text(user, "Rename your house in the listing:", "Rename House", max_length = MAX_NAME_LEN)
			if(isnull(new_name) || new_name == " ")
				return FALSE
			inst.house_name = new_name
			return TRUE
		if("remove_guest")
			var/datum/housing_instance/inst = instances[ui.user.mind]
			if(!inst?.loaded)
				return FALSE
			var/datum/mind/guest = locate(params["ref"])
			to_chat(inst.owner_mind.current, span_warning("[guest.name] will no longer be able to return, but still needs to be escorted out or to leave on their own if they are still present."))
			if(!istype(guest, /datum/mind))
				return FALSE
			inst.guests -= guest
			return TRUE
		if("teleport")
			var/datum/housing_instance/inst = locate(params["ref"])
			if(!istype(inst, /datum/housing_instance))
				return FALSE
			if(is_in_housing(ui.user))
				to_chat(ui.user, span_warning("You must leave the house you are in first."))
				return FALSE
			user.balloon_alert_to_viewers("traveling...")
			if(!do_after(ui.user, 10 SECONDS))
				return
			var/mob/living/escorted = isliving(ui.user.pulling) ? ui.user.pulling : null
			if(escorted)
				inst.enter(escorted)
				to_chat(ui.user, span_notice("You're taken to [inst.house_name]."))
			to_chat(ui.user, span_notice("You travel to [inst.house_name]."))
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
#undef HOUSING_BIGHOME_MAP_1
#undef HOUSING_SIZE_MEDIUM
#undef HOUSING_SIZE_LARGE
