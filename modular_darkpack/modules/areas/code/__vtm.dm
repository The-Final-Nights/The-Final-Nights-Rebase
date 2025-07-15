/area/vtm
	name = "San Francisco"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "sewer"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	wall_rating = VERY_HIGH_WALL_RATING
	var/upper = TRUE
	var/zone_type = ZONE_MASQUERADE

/area/vtm/powered(chan)
	if (!requires_power)
		return TRUE
	return FALSE

/area/vtm/proc/break_elysium()
	if (zone_type != ZONE_MASQUERADE)
		return

	zone_type = ZONE_NO_MASQUERADE
	addtimer(CALLBACK(src, PROC_REF(restore_elysium)), 3 MINUTES)

/area/vtm/proc/restore_elysium()
	if (zone_type != ZONE_NO_MASQUERADE)
		return

	zone_type = ZONE_MASQUERADE
