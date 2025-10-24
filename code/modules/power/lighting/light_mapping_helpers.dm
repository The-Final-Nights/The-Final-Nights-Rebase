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

// DARKPACK EDIT START
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

#define LIGHTING_DIRECTIONAL_HELPERS(path) \
MAPPING_DIRECTIONAL_HELPERS(##path, 0) \
##path/directional/north {\
	pixel_y = 20; \
} \
##path/directional/south {\
	pixel_y = 16; \
}


// -------- Directional presets
// The directions are backwards on the lights we have now
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light)

// ---- Broken tube
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/broken)

// ---- Tube construct
LIGHTING_DIRECTIONAL_HELPERS(/obj/structure/light_construct)

// ---- Tube frames
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/built)

// ---- No nightlight tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/no_nightlight)

// ---- Warm light tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm)

// ---- No nightlight warm light tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm/no_nightlight)

// ---- Dim warm light tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/warm/dim)

// ---- Cold light tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold)

// ---- No nightlight cold light tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold/no_nightlight)

// ---- Dim cold light tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/cold/dim)

// ---- Red tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/red)

// ---- Red dim tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/red/dim)

// ---- Blacklight tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/blacklight)

// ---- Dim tubes
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/dim)


// -------- Bulb lights
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/small)

// ---- Bulb construct
LIGHTING_DIRECTIONAL_HELPERS(/obj/structure/light_construct/small)

// ---- Bulb frames
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/built)

// ---- Broken bulbs
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/broken)

// ---- Red bulbs
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/dim)

LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/red)

// ---- Red dim bulbs
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/red/dim)

// ---- Blacklight bulbs
LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/small/blacklight)

LIGHTING_DIRECTIONAL_HELPERS(/obj/machinery/light/prince) // DARKPACK EDIT ADD

#undef LIGHTING_DIRECTIONAL_HELPERS
// DARKPACK EDIT END
