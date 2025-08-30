/obj/structure/rack/clothing
	name = "clothing rack"
	desc = "Have some clothes."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "rack"

/obj/structure/rack/clothing/rand
	icon_state = "rack2"

/obj/structure/rack/clothing/rand/Initialize(mapload)
	. = ..()
	icon_state = "rack[rand(1, 5)]"


/obj/structure/rack/clothing_hanger
	name = "clothing hanger"
	desc = "Have some clothes."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "hanger1"

/obj/structure/rack/clothing_hanger/rand
	icon_state = "hanger2"

/obj/structure/rack/clothing_hanger/rand/Initialize(mapload)
	. = ..()
	icon_state = "hanger[rand(1, 4)]"


/obj/structure/rack/food
	name = "food rack"
	desc = "Have some food."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "rack1"
	pixel_w = -16

/obj/structure/rack/food/rand
	icon_state = "rack2"

/obj/structure/rack/food/rand/Initialize(mapload)
	. = ..()
	icon_state = "rack[rand(1, 5)]"
