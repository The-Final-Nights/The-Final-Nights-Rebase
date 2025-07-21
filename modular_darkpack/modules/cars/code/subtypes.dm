/obj/vampire_car/retro
	icon_state = "1"
	max_passengers = 1
	dir = WEST

/obj/vampire_car/retro/rand
	icon_state = "3"

/obj/vampire_car/retro/rand/Initialize(mapload)
	icon_state = "[pick(1, 3, 5)]"
	if(access == "none")
		access = "npc[rand(1, 20)]"
	. = ..()

/obj/vampire_car/rand
	icon_state = "4"
	dir = WEST

/obj/vampire_car/rand/Initialize(mapload)
	icon_state = "[pick(2, 4, 6)]"
	if(access == "none")
		access = "npc[rand(1, 20)]"
	. = ..()

/obj/vampire_car/rand/camarilla
	access = "camarilla"
	icon_state = "6"

/obj/vampire_car/retro/rand/camarilla
	access = "camarilla"
	icon_state = "5"

/obj/vampire_car/rand/anarch
	access = "anarch"
	icon_state = "6"

/obj/vampire_car/retro/rand/anarch
	access = "anarch"
	icon_state = "5"

/obj/vampire_car/rand/clinic
	access = "clinic"
	icon_state = "6"

/obj/vampire_car/retro/rand/clinic
	access = "clinic"
	icon_state = "5"

/obj/vampire_car/limousine
	icon_state = "limo"
	max_passengers = 6
	dir = WEST
	baggage_limit = 45

/obj/vampire_car/limousine/giovanni
	icon_state = "giolimo"
	max_passengers = 6
	dir = WEST
	access = "giovanni"
	baggage_limit = 45
	baggage_max = WEIGHT_CLASS_BULKY

/obj/vampire_car/limousine/camarilla
	icon_state = "limo"
	max_passengers = 6
	dir = WEST
	access = "camarilla"
	baggage_limit = 45

/obj/vampire_car/police
	icon_state = "police"
	max_passengers = 3
	dir = WEST
	beep_sound = 'modular_darkpack/modules/deprecated/sounds/migalka.ogg'
	access = "police"
	baggage_limit = 45
	baggage_max = WEIGHT_CLASS_BULKY
	var/color_blue = FALSE
	var/last_color_change = 0

/obj/vampire_car/police/handle_caring()
	if(fari_on)
		if(last_color_change+10 <= world.time)
			last_color_change = world.time
			if(color_blue)
				color_blue = FALSE
				set_light(0)
				set_light(4, 6, "#ff0000")
			else
				color_blue = TRUE
				set_light(0)
				set_light(4, 6, "#0000ff")
	else
		if(last_color_change+10 <= world.time)
			last_color_change = world.time
			set_light(0)
	. = ..()

/obj/vampire_car/taxi
	icon_state = "taxi"
	max_passengers = 3
	dir = WEST
	access = "taxi"
	baggage_limit = 40
	baggage_max = WEIGHT_CLASS_BULKY

/obj/vampire_car/track
	icon_state = "track"
	max_passengers = 6
	dir = WEST
	access = "none"
	baggage_limit = 100
	baggage_max = WEIGHT_CLASS_BULKY
	component_type = /datum/component/storage/concrete/vtm/car/track

/obj/vampire_car/track/Initialize(mapload)
	if(access == "none")
		access = "npc[rand(1, 20)]"
	. = ..()

/obj/vampire_car/track/volkswagen
	icon_state = "volkswagen"
	baggage_limit = 60

/obj/vampire_car/track/ambulance
	icon_state = "ambulance"
	access = "clinic"
	baggage_limit = 60
