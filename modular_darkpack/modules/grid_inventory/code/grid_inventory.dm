/obj/item
	var/grid_width = 1
	var/grid_height = 1

/obj/item/storage/Initialize(mapload)
	. = ..()
	update_grid_inventory()

/obj/item/storage/proc/update_grid_inventory()
	//this is stupid shitcode but grid inventory sadly requires it
	var/drop_location = drop_location()
	for(var/obj/item/item_in_source in contents)
		if(drop_location)
			item_in_source.forceMove(drop_location)
		else
			qdel(item_in_source)
		SEND_SIGNAL(src, COMSIG_STORAGE_STORED_ITEM, item_in_source, null, TRUE)

// The actual storage datum.
/datum/storage
	screen_max_columns = 5
	screen_max_rows = 5
	screen_pixel_x = 0
	screen_pixel_y = 0
	screen_start_x = 1
	screen_start_y = 9
	/// Exactly what it sounds like, this makes it use the new RE4-like inventory system
	var/grid = TRUE
	var/static/grid_box_size
	var/static/list/mutable_appearance/underlay_appearances_by_size = list()
	var/list/grid_coordinates_to_item
	var/list/item_to_grid_coordinates
	var/maximum_depth = 1
	max_total_storage = WEIGHT_CLASS_GIGANTIC
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_slots = INFINITY
	///Width in tiles, which we occupy on the gridventory hud - Keep null to generate based on w_class
	var/grid_width = 1
	///Height in tiles, which we occupy on the gridventory hud - Keep null to generate based on w_class
	var/grid_height = 1
