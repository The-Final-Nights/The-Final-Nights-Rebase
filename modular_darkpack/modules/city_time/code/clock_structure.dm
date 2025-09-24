/obj/structure/coclock
	name = "clock"
	desc = "See the time."
	icon = 'modular_darkpack/modules/city_time/icons/clock.dmi'
	icon_state = "clock"
	anchored = TRUE
	pixel_z = 32

/obj/structure/coclock/examine(mob/user)
	. = ..()
	. += "The clock reads: <b>[station_time_timestamp()]</b>"

/obj/structure/coclock/grandpa
	icon = 'modular_darkpack/modules/city_time/icons/grandpa_cock.dmi'
	icon_state = "cock"
	density = TRUE
	pixel_z = 0
