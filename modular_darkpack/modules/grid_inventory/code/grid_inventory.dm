/obj/item
	var/grid_width = 1
	var/grid_height = 1

// The actual storage datum.
/datum/storage
	screen_max_columns = 5
	screen_max_rows = 5
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
