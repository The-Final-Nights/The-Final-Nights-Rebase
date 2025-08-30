/obj/structure/roofstuff
	name = "roof ventilation"
	desc = "Air to inside."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "roof1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/roofstuff/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/roofstuff/alt1
	icon_state = "roof2"
	density = FALSE

/obj/structure/roofstuff/alt2
	icon_state = "roof3"

// Use this instead of alt3
/obj/structure/roofstuff/vent_end
	icon_state = "roof4"
	smoothing_groups = SMOOTH_GROUP_VENTS

/obj/structure/roofstuff/vent
	icon_state = "vent-0"
	base_icon_state = "vent"
	smoothing_groups = SMOOTH_GROUP_VENTS

/obj/structure/roofstuff/vent/south
	icon_state = "vent-3"

/obj/structure/roofstuff/vent/autotiling
	MAP_SWITCH(icon_state = "vent-0", icon_state = "vent_autotile")
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_VENTS
	canSmoothWith = SMOOTH_GROUP_VENTS

/obj/structure/roofstuff/vent/autotiling/update_appearance(updates=ALL)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & USES_SMOOTHING))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)
