/obj/item
	var/grid_width = 1
	var/grid_height = 1

// The actual storage datum.
/datum/storage/darkpack
	/// Exactly what it sounds like, this makes it use the new RE4-like inventory system
	max_slots = INFINITY
	/**
	 * Width in tiles, which we occupy on the gridventory hud
	 * Keep null to generate based on w_class
	 */
	var/grid_width = 1

	/**
	 * Height in tiles, which we occupy on the gridventory hud
	 * Keep null to generate based on w_class
	 */
	var/grid_height = 1

/**
 * Attempts to insert an item into the storage
 *
 * Arguments
 * * obj/item/to_insert - the item we're inserting
 * * mob/user - (optional) the user who is inserting the item.
 * * override - skip feedback, only do the animation
 * * force - bypass locked storage up to a certain level. See [code/__DEFINES/storage.dm]
 * * messages - if TRUE, we will create balloon alerts for the user.
 */
/datum/storage/darkpack/attempt_insert(obj/item/to_insert, mob/user, override = FALSE, force = STORAGE_NOT_LOCKED, messages = TRUE)
	SHOULD_NOT_SLEEP(TRUE)

	if(!can_insert(to_insert, user, messages = messages, force = force))
		return FALSE

	SEND_SIGNAL(parent, COMSIG_ATOM_STORED_ITEM, to_insert, user, force)
	SEND_SIGNAL(src, COMSIG_STORAGE_STORED_ITEM, to_insert, user, force)
	to_insert.forceMove(real_location)
	item_insertion_feedback(user, to_insert, override)
	parent.update_appearance()
	if(get(real_location, /mob) != user)
		to_insert.do_pickup_animation(real_location, user)
	return TRUE
