// sprites by Constellado, MapleStation
// icons ported from https://github.com/Bubberstation/Bubberstation/ @ modular_zubbers/code/modules/rimpoint_newfeatures/code/umbrella.dm
/obj/item/umbrella
	name = "umbrella"
	desc = "A foldable umbrella."
	icon = 'modular_tfn/modules/umbrellas/icons/umbrella.dmi'
	icon_state = "umbrella_closed"
	lefthand_file = 'modular_tfn/modules/umbrellas/icons/umbrella_inhand_l.dmi'
	righthand_file = 'modular_tfn/modules/umbrellas/icons/umbrella_inhand_r.dmi'
	w_class = WEIGHT_CLASS_TINY
	greyscale_config = /datum/greyscale_config/umbrella
	greyscale_config_inhand_left = /datum/greyscale_config/umbrella_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/umbrella_inhand_right
	greyscale_colors = "#808080"
	post_init_icon_state = "umbrella_closed"
	flags_1 = IS_PLAYER_COLORABLE_1
	var/open = FALSE

/obj/item/umbrella/attack_self(mob/user)
	. = ..()
	toggle_open(user)

/obj/item/umbrella/proc/toggle_open(mob/user)
	open = !open
	icon_state = open ? "umbrella_open" : "umbrella_closed"
	balloon_alert(user, open ? "opened" : "closed")
	if(open)
		ADD_TRAIT(user, TRAIT_RAINSTORM_IMMUNE, REF(src))
	else
		REMOVE_TRAIT(user, TRAIT_RAINSTORM_IMMUNE, REF(src))

/obj/item/umbrella/equipped(mob/user, slot)
	. = ..()
	if(open && (slot & ITEM_SLOT_HANDS))
		ADD_TRAIT(user, TRAIT_RAINSTORM_IMMUNE, REF(src))

/obj/item/umbrella/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_RAINSTORM_IMMUNE, REF(src))

/obj/item/umbrella/parasol
	name = "parasol"
	desc = "A foldable parasol."
	icon_state = "parasol_closed"
	post_init_icon_state = "parasol_closed"
	greyscale_config = /datum/greyscale_config/umbrella/parasol

/obj/item/umbrella/parasol/toggle_open(mob/user)
	open = !open
	icon_state = open ? "parasol_open" : "parasol_closed"
	balloon_alert(user, open ? "opened" : "closed")
	if(open)
		ADD_TRAIT(user, TRAIT_RAINSTORM_IMMUNE, REF(src))
	else
		REMOVE_TRAIT(user, TRAIT_RAINSTORM_IMMUNE, REF(src))

