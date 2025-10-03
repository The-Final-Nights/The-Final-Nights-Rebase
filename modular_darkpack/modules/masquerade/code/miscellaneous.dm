/proc/check_zone_masquerade(mob/target)
	if(istype(get_area(target), /area/vtm))
		var/area/vtm/V = get_area(target)
		if(V.zone_type != ZONE_MASQUERADE)
			return FALSE
		else
			return TRUE
