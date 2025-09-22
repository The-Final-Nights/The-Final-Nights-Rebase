/obj/machinery/light/broken
	status = LIGHT_BROKEN
	icon_state = "tube-broken"

/obj/machinery/light/built
	icon_state = "tube-empty"
	start_with_cell = FALSE
	status = LIGHT_EMPTY

/obj/machinery/light/no_nightlight
	nightshift_enabled = FALSE

/obj/machinery/light/warm
	bulb_colour = "#fae5c1"

/obj/machinery/light/warm/no_nightlight
	nightshift_allowed = FALSE

/obj/machinery/light/warm/dim
	nightshift_allowed = FALSE
	bulb_power = 0.6

/obj/machinery/light/cold
	bulb_colour = LIGHT_COLOR_FAINT_BLUE
	nightshift_light_color = LIGHT_COLOR_FAINT_BLUE

/obj/machinery/light/cold/no_nightlight
	nightshift_allowed = FALSE

/obj/machinery/light/cold/dim
	nightshift_allowed = FALSE
	bulb_power = 0.6

/obj/machinery/light/red
	bulb_colour = COLOR_VIVID_RED
	nightshift_allowed = FALSE
	no_low_power = TRUE

/obj/machinery/light/red/dim
	brightness = 4
	bulb_power = 0.7
	fire_brightness = 4.5

/obj/machinery/light/blacklight
	bulb_colour = "#A700FF"
	nightshift_allowed = FALSE

/obj/machinery/light/dim
	nightshift_allowed = FALSE
	bulb_colour = "#FFDDCC"
	bulb_power = 0.6

// the smaller bulb light fixture

/obj/machinery/light/small
	icon_state = "bulb"
	base_state = "bulb"
	fitting = "bulb"
	brightness = 4
	nightshift_brightness = 4
	fire_brightness = 4.5
	bulb_colour = LIGHT_COLOR_TUNGSTEN
	fire_colour = "#bd3f46"
	desc = "A small lighting fixture."
	light_type = /obj/item/light/bulb

/obj/machinery/light/small/broken
	status = LIGHT_BROKEN
	icon_state = "bulb-broken"

/obj/machinery/light/small/built
	icon_state = "bulb-empty"
	start_with_cell = FALSE
	status = LIGHT_EMPTY

/obj/machinery/light/small/dim
	brightness = 2.4

/obj/machinery/light/small/red
	bulb_colour = COLOR_VIVID_RED
	no_low_power = TRUE
	nightshift_allowed = FALSE
	fire_colour = "#ff1100"

/obj/machinery/light/small/red/dim
	brightness = 2
	bulb_power = 0.8
	fire_brightness = 2.5

/obj/machinery/light/small/blacklight
	bulb_colour = "#A700FF"
	nightshift_allowed = FALSE
	brightness = 4
	fire_brightness = 4.5
	fire_colour = "#d400ff"

//DARKPACK EDIT START
/obj/machinery/light/prince
	base_state = "prince"

/obj/machinery/light/prince/ghost

/obj/machinery/light/prince/ghost/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ENTERED, PROC_REF(jumpscare))

/obj/machinery/light/prince/ghost/proc/jumpscare(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(ishuman(arrived))
		var/mob/living/L = arrived
		if(L.client)
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(5, 1, get_turf(src))
			s.start()
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/explode.ogg', 100, TRUE)
			qdel(src)

/obj/machinery/light/prince/broken
	status = LIGHT_BROKEN
	icon_state = "tube-broken"
// DARKPACK EDIT END

// -------- Directional presets
// The directions are backwards on the lights we have now
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light, 0)

// ---- Broken tube
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/broken, 0)

// ---- Tube construct
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/light_construct, 0)

// ---- Tube frames
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/built, 0)

// ---- No nightlight tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/no_nightlight, 0)

// ---- Warm light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm, 0)

// ---- No nightlight warm light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm/no_nightlight, 0)

// ---- Dim warm light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm/dim, 0)

// ---- Cold light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold, 0)

// ---- No nightlight cold light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold/no_nightlight, 0)

// ---- Dim cold light tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold/dim, 0)

// ---- Red tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/red, 0)

// ---- Red dim tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/red/dim, 0)

// ---- Blacklight tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/blacklight, 0)

// ---- Dim tubes
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/dim, 0)


// -------- Bulb lights
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small, 0)

// ---- Bulb construct
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/light_construct/small, 0)

// ---- Bulb frames
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/built, 0)

// ---- Broken bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/broken, 0)

// ---- Red bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/dim, 0)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/red, 0)

// ---- Red dim bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/red/dim, 0)

// ---- Blacklight bulbs
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/blacklight, 0)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/prince, 0) // DARKPACK EDIT ADD
