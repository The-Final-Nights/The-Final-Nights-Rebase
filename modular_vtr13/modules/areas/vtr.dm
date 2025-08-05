/area/vtm/vtr

	ambience_index = null
	var/sector
	var/ambiance_message

	//what z-level the area is located on
	var/floor

	var/datum/area_group/area_group

	//An id matching area's group, for pathing
	var/id

	//marked true if an area cannot be reached via stairs
	var/inaccessible = FALSE

	//marked true if the area is sanctified
	var/holy_ground = FALSE
