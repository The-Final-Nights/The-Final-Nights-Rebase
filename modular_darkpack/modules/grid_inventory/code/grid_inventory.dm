/obj/item
	var/grid_width = 1 GRID_BOXES
	var/grid_height = 1 GRID_BOXES

/obj/item/storage/Initialize()
	. = ..()
	update_grid_inventory()

/obj/item/storage/proc/update_grid_inventory()
	//this is stupid shitcode but grid inventory sadly requires it
	var/drop_location = drop_location()
	for(var/obj/item/item_in_source in contents)
		if(drop_location)
			item_in_source.forceMove(drop_location)
		else
			item_in_source.moveToNullspace()
		SEND_SIGNAL(src, COMSIG_ATOM_STORED_ITEM, item_in_source, null, TRUE)
		SEND_SIGNAL(storage_type, COMSIG_STORAGE_STORED_ITEM, item_in_source, null, TRUE)

/// Storage datum, uses the new RE4-like inventory system in this module.
/datum/storage/darkpack
	max_slots = INFINITY
	var/static/grid_box_size
	var/list/grid_coordinates_to_item
	var/list/item_to_grid_coordinates
	var/static/list/mutable_appearance/underlay_appearances_by_size = list()

/datum/storage/darkpack/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	if(!grid_box_size)
		grid_box_size = world.icon_size

/datum/storage/darkpack/attempt_insert(obj/item/to_insert, mob/user, override = FALSE, force = STORAGE_NOT_LOCKED, messages = TRUE, params)
	if(!can_insert(to_insert, user, messages = messages, force = force))
		return FALSE

	var/coordinates
	if(params)
		var/list/modifiers = params2list(params)
		coordinates = LAZYACCESS(modifiers, "screen-loc")
	var/grid_box_ratio = (world.icon_size / world.icon_size)

	//if you are clicking the item on the storage container, find the first cell that happens to be valid
	if(coordinates)
		var/final_x = 0
		var/final_y = 0
		var/final_coordinates = ""
		var/grid_location_found = FALSE
		for(var/current_x in 0 to ((screen_max_rows*grid_box_ratio)-1))
			for(var/current_y in 0 to ((screen_max_columns*grid_box_ratio)-1))
				final_y = current_y
				final_x = current_x
				final_coordinates = "[final_x],[final_y]"
				if(validate_grid_coordinates(final_coordinates, to_insert.grid_width, to_insert.grid_height, to_insert))
					coordinates = final_coordinates
					grid_location_found = TRUE
					break
			if(grid_location_found)
				break
		if(!grid_location_found)
			return FALSE
	else
		coordinates = screen_loc_to_grid_coordinates(coordinates)

	. = ..()
	grid_add_item(to_insert, coordinates)

/datum/storage/darkpack/attempt_remove(obj/item/thing, atom/remove_to_loc, silent = FALSE, visual_updates = TRUE)
	. = ..()
	//This loops through all cells in the inventory box that we overlap and removes the item from them
	grid_remove_item(thing)

//////////////////////////////////////////////////////////////////////////////////////////////

/datum/storage/darkpack/orient_storage()
	. = ..()
	var/mutable_appearance/bound_underlay
	var/screen_loc
	var/screen_x
	var/screen_y
	var/new_screen_pixel_x
	var/new_screen_pixel_y

	for(var/obj/item/item as anything in real_location)
		bound_underlay = LAZYACCESS(underlay_appearances_by_size, "[item.grid_width]x[item.grid_height]")
		if(!bound_underlay)
			bound_underlay = generate_bound_underlay(item.grid_width, item.grid_height)
			underlay_appearances_by_size["[item.grid_width]x[item.grid_height]"] = bound_underlay
		item.underlays = null
		item.underlays += bound_underlay
		screen_loc = LAZYACCESSASSOC(item_to_grid_coordinates, item, 1)
		screen_loc = grid_coordinates_to_screen_loc(screen_loc)
		screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
		new_screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
		new_screen_pixel_x += (world.icon_size/2)*((item.grid_width/world.icon_size)-1)
		screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
		screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
		new_screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
		new_screen_pixel_y += (world.icon_size/2)*((item.grid_height/world.icon_size)-1)
		screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))

/datum/storage/darkpack/proc/grid_add_item(obj/item/storing, coordinates)
	var/coordinate_x = text2num(copytext(coordinates, 1, findtext(coordinates, ",")))
	var/coordinate_y = text2num(copytext(coordinates, findtext(coordinates, ",") + 1))
	var/calculated_coordinates = ""
	var/final_x
	var/final_y
	var/validate_x = (storing.grid_width / grid_box_size) - 1
	var/validate_y = (storing.grid_height / grid_box_size) - 1
	//this loops through all cells we overlap given these coordinates
	for(var/current_x in 0 to validate_x)
		for(var/current_y in 0 to validate_y)
			final_x = coordinate_x+current_x
			final_y = coordinate_y+current_y
			calculated_coordinates = "[final_x],[final_y]"
			LAZYADDASSOCLIST(grid_coordinates_to_item, calculated_coordinates, storing)
			LAZYINITLIST(item_to_grid_coordinates)
			LAZYINITLIST(item_to_grid_coordinates[storing])
			LAZYADD(item_to_grid_coordinates[storing], calculated_coordinates)
	return TRUE

/datum/storage/darkpack/proc/grid_remove_item(obj/item/removed)
	if(LAZYACCESS(item_to_grid_coordinates, removed))
		for(var/location in LAZYACCESS(item_to_grid_coordinates, removed))
			LAZYREMOVE(grid_coordinates_to_item, location)
		LAZYREMOVE(item_to_grid_coordinates, removed)
		removed.underlays = null
		return TRUE
	return FALSE

/datum/storage/darkpack/proc/grid_coordinates_to_screen_loc(coordinates = "")
	var/coordinate_x = copytext(coordinates, 1, findtext(coordinates, ","))
	coordinate_x = text2num(copytext(coordinate_x, 1, findtext(coordinate_x, ":")))

	var/coordinate_y = copytext(coordinates, findtext(coordinates, ",") + 1)
	coordinate_y = text2num(copytext(coordinate_y, 1, findtext(coordinate_y, ":")))

	var/screen_x_pixels = coordinate_x * world.icon_size
	screen_x_pixels += (screen_start_x * world.icon_size) + screen_pixel_x
	var/screen_y_pixels = coordinate_y * world.icon_size
	screen_y_pixels += ((screen_start_y - screen_max_rows + 1) * world.icon_size) + screen_pixel_y

	var/new_screen_x = FLOOR(screen_x_pixels/grid_box_size, 1)
	var/new_screen_pixel_x = FLOOR(screen_x_pixels - FLOOR(screen_x_pixels, world.icon_size), 1)
	var/new_screen_y = FLOOR(screen_y_pixels/grid_box_size, 1)
	var/new_screen_pixel_y = FLOOR(screen_y_pixels - FLOOR(screen_y_pixels, world.icon_size), 1)

	return "[new_screen_x]:[new_screen_pixel_x],[new_screen_y]:[new_screen_pixel_y]"

/datum/storage/darkpack/proc/screen_loc_to_grid_coordinates(screen_loc = "")
	var/screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
	var/screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))

	var/screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
	var/screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))

	var/screen_x_pixels = (screen_x * world.icon_size) + screen_pixel_x
	screen_x_pixels -= (screen_start_x * world.icon_size) + screen_pixel_x
	screen_x_pixels = FLOOR(screen_x_pixels/grid_box_size, 1)
	var/screen_y_pixels = (screen_y * world.icon_size) + screen_pixel_y
	screen_y_pixels -= ((screen_start_y - screen_max_rows + 1) * world.icon_size) + screen_pixel_y
	screen_y_pixels = FLOOR(screen_y_pixels/grid_box_size, 1)

	return "[screen_x_pixels],[screen_y_pixels]"

/datum/storage/darkpack/proc/validate_grid_coordinates(coordinates = "", grid_width = 1, grid_height = 1, obj/item/dragged_item)
	var/grid_box_ratio = (world.icon_size / grid_box_size)
	var/screen_x = copytext(coordinates, 1, findtext(coordinates, ","))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
	var/screen_y = copytext(coordinates, findtext(coordinates, ",") + 1)
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))
	var/validate_x = FLOOR((grid_width / grid_box_size)-1, 1)
	var/validate_y = FLOOR((grid_height / grid_box_size)-1, 1)
	var/final_x = 0
	var/final_y = 0
	var/final_coordinates = ""
	//this loops through all possible cells in the inventory box that we could overlap when given this screen_x and screen_y
	//and returns false on any failure
	for(var/current_x in 0 to validate_x)
		for(var/current_y in 0 to validate_y)
			final_x = screen_x+current_x
			final_y = screen_y+current_y
			final_coordinates = "[final_x],[final_y]"
			if(final_x >= (screen_max_columns*grid_box_ratio))
				return FALSE
			if(final_y >= (screen_max_rows*grid_box_ratio))
				return FALSE
			var/existing_item = LAZYACCESS(grid_coordinates_to_item, final_coordinates)
			if(existing_item && (!dragged_item || (existing_item != dragged_item)))
				return FALSE
	return TRUE

/datum/storage/darkpack/proc/generate_bound_underlay(grid_width = 32, grid_height = 32)
	var/mutable_appearance/bound_underlay = mutable_appearance(icon = 'modular_darkpack/master_files/icons/hud/screen_darkpack.dmi')
	var/static/list/scale_both = list("block_under")
	var/static/list/scale_x_states = list("up", "down")
	var/static/list/scale_y_states = list("left", "right")

	var/scale_x = grid_width/world.icon_size
	var/scale_y = grid_height/world.icon_size
	var/width_constant = (world.icon_size/2)*((grid_width/world.icon_size)-1)
	var/height_constant = (world.icon_size/2)*((grid_height/world.icon_size)-1)
	for(var/i in 1 to scale_x)
		for(var/b in 1 to scale_y)
			var/image/scaled_image = image(bound_underlay.icon, "block_under")
			scaled_image.pixel_w = 32*(i-1)-width_constant
			scaled_image.pixel_z = 32*(b-1)-height_constant
			bound_underlay.add_overlay(scaled_image)
			if(i == 1)
				var/image/side_image = image(bound_underlay.icon, "left")
				side_image.pixel_w = 32*(i-1)-width_constant
				side_image.pixel_z = 32*(b-1)-height_constant
				bound_underlay.add_overlay(side_image)
			if(i == scale_x)
				var/image/side_image = image(bound_underlay.icon, "right")
				side_image.pixel_w = 32*(i-1)-width_constant
				side_image.pixel_z = 32*(b-1)-height_constant
				bound_underlay.add_overlay(side_image)
			if(b == 1)
				var/image/side_image = image(bound_underlay.icon, "down")
				side_image.pixel_w = 32*(i-1)-width_constant
				side_image.pixel_z = 32*(b-1)-height_constant
				bound_underlay.add_overlay(side_image)
			if(b == scale_y)
				var/image/side_image = image(bound_underlay.icon, "up")
				side_image.pixel_w = 32*(i-1)-width_constant
				side_image.pixel_z = 32*(b-1)-height_constant
				bound_underlay.add_overlay(side_image)
	var/image/corner_left_down = image(bound_underlay.icon, "storage_corner_bottomleft")
	corner_left_down.transform = corner_left_down.transform.Translate(-width_constant, -height_constant)
	bound_underlay.add_overlay(corner_left_down)
	var/image/corner_right_down = image(bound_underlay.icon, "storage_corner_bottomright")
	corner_right_down.transform = corner_right_down.transform.Translate(width_constant, -height_constant)
	bound_underlay.add_overlay(corner_right_down)
	var/image/corner_left_up = image(bound_underlay.icon, "storage_corner_topleft")
	corner_left_up.transform = corner_left_up.transform.Translate(-width_constant, height_constant)
	bound_underlay.add_overlay(corner_left_up)
	var/image/corner_right_up = image(bound_underlay.icon, "storage_corner_topright")
	corner_right_up.transform = corner_right_up.transform.Translate(width_constant, height_constant)
	bound_underlay.add_overlay(corner_right_up)

	return bound_underlay
