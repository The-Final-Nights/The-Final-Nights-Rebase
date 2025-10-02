/obj/item/cargo_box
	name = "cargo box"
	desc = "Special deliever."
	icon_state = "box"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE

/obj/structure/cargo_take
	name = "cargo"
	desc = "Take and place boxes."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "box_take"
	plane = GAME_PLANE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	COOLDOWN_DECLARE(take_box)

/obj/structure/cargo_take/attack_hand(mob/user)
	if (!COOLDOWN_FINISHED(src, take_box))
		return ..()
	COOLDOWN_START(src, take_box, 3 SECONDS)

	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
	to_chat(user, span_notice("You take the box from [src]."))

	new /obj/item/cargo_box(get_turf(user))

/obj/structure/cargo_put
	name = "cargo"
	desc = "Take and place boxes."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "box_put"
	plane = GAME_PLANE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/cargo_put/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/cargo_box))
		qdel(I)
		playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
		to_chat(user, span_notice("You place the box at [src]."))
		new /obj/item/stack/dollar/five(get_turf(user))
		return
	. = ..()
