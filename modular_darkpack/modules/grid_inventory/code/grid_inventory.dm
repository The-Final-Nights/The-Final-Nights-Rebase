/obj/item
	var/grid_width = 1
	var/grid_height = 1

// The actual storage datum.
/datum/storage
	/// Exactly what it sounds like, this makes it use the new RE4-like inventory system
	max_slots = INFINITY
	max_specific_storage = INFINITY
	max_total_storage = INFINITY
	///Width in tiles, which we occupy on the gridventory hud - Keep null to generate based on w_class
	var/grid_width = 1
	///Height in tiles, which we occupy on the gridventory hud - Keep null to generate based on w_class
	var/grid_height = 1
