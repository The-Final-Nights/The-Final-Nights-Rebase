/obj/structure/sign/city/crown_blue
	name = "Crown Blue sign"
	desc = "It says Crown Blue. It looks fancy."
	icon = 'modular_tfn/modules/decor/icons/crown_blues_sign.dmi'
	icon_state = "crownblues"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	pixel_w = -8
	//pixel_z = 32

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/crown_blue, 32)
/obj/structure/sign/city/crown_blue/Initialize(mapload)
	. = ..()
	set_light(3, 2, "#4d60b6")

/obj/structure/sign/poster/contraband/rush_propaganda
	name = "A New Life"
	desc = "A beautiful painting depicting a lush green horizon."
	icon_state = "rush_propaganda"

/obj/structure/sign/poster/contraband/rush_propaganda/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You stop to admire the painting...</i>")
	return .
