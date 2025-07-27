
/atom/movable/screen/close
	icon = 'modular_darkpack/modules/deprecated/icons/ui/storage.dmi'
	icon_state = "close"
	var/locked = TRUE

/atom/movable/screen/close/Click(location, control, params)
	. = ..()
	var/datum/storage/storage_master = master
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, "shift"))
		if(!istype(storage_master))
			return
		storage_master.screen_start_x = initial(storage_master.screen_start_x)
		storage_master.screen_pixel_x = initial(storage_master.screen_pixel_x)
		storage_master.screen_start_y = initial(storage_master.screen_start_y)
		storage_master.screen_pixel_y = initial(storage_master.screen_pixel_y)
		storage_master.orient2hud()
		storage_master.show_to(usr)
		testing("storage screen variables reset.")
		to_chat(usr, span_notice("Storage window position has been reset."))
	else
		if(!istype(storage_master))
			return
		storage_master.hide_from(usr)

/atom/movable/screen/storage
	icon = 'modular_darkpack/modules/gridventory/icons/storage.dmi'
	icon_state = "background"
	plane = HUD_PLANE
	layer = 1
	alpha = 180
	var/atom/movable/screen/storage_hover/hovering

/atom/movable/screen/storage/Initialize(mapload, new_master)
	. = ..()
	hovering = new()

/atom/movable/screen/storage/Destroy()
	. = ..()
	qdel(hovering)

/atom/movable/screen/storage/MouseEntered(location, control, params)
	. = ..()
	if(!usr.client)
		return
	MouseMove(location, control, params)

/atom/movable/screen/storage/MouseExited(location, control, params)
	. = ..()
	if(!usr.client)
		return
	usr.client.screen -= hovering

/atom/movable/screen/storage/MouseMove(location, control, params)
	. = ..()
	if(!usr.client)
		return
	usr.client.screen -= hovering
	var/datum/storage/storage_master = master
	if(!istype(storage_master) || !(usr in storage_master.is_using) || !isliving(usr) || usr.incapacitated())
		return
	var/obj/item/held_item = usr.get_active_held_item()
	if(!held_item)
		return
	storage_master = storage_master.master()
	if(!storage_master.grid)
		return
	var/list/modifiers = params2list(params)
	var/screen_loc = LAZYACCESS(modifiers, "screen-loc")
	var/coordinates = storage_master.screen_loc_to_grid_coordinates(screen_loc)
	if(!coordinates)
		return
	if(storage_master.can_be_inserted(held_item, stop_messages = TRUE, user = usr, worn_check = TRUE, params = params, storage_click = TRUE))
		hovering.color = COLOR_LIME
	else
		hovering.color = COLOR_RED_LIGHT
	hovering.transform = matrix()
	var/scale_x = held_item.grid_width/world.icon_size
	var/scale_y = held_item.grid_height/world.icon_size
	hovering.transform = hovering.transform.Scale(scale_x, scale_y)
	var/translate_x = (world.icon_size/2)*((held_item.grid_width/world.icon_size)-1)
	var/translate_y = (world.icon_size/2)*((held_item.grid_height/world.icon_size)-1)
	hovering.transform = hovering.transform.Translate(translate_x, translate_y)
	hovering.screen_loc = storage_master.grid_coordinates_to_screen_loc(coordinates)

	usr.client.screen |= hovering

/atom/movable/screen/storage_hover
	icon = 'modular_darkpack/modules/gridventory/icons/storage.dmi'
	icon_state = "white"
	plane = ABOVE_HUD_PLANE
	layer = 1
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 96
