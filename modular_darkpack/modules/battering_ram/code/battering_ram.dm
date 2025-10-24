/obj/item/battering_ram
	name = "battering ram"
	desc = "WE CALL THIS A DIFFICULTY TWEAK"
	icon = 'modular_darkpack/modules/battering_ram/icons/battering_ram.dmi'
	icon_state = "battering_ram"
	inhand_icon_state = "battering_ram"
	lefthand_file = 'modular_darkpack/modules/battering_ram/icons/inhand_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/battering_ram/icons/inhand_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/battering_ram/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_HUGE
	force = 5
	armour_penetration = 15
	demolition_mod = 2

/obj/item/battering_ram/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 5, force_wielded = 20, require_twohands = TRUE, icon_wielded = "battering_ram")

/obj/item/battering_ram/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(istype(target, /obj/structure/vampdoor))
		var/obj/structure/vampdoor/target_door = target
		if(target_door.door_broken)
			return COMPONENT_CANCEL_ATTACK_CHAIN
		var/dice_result = SSroll.storyteller_roll(user.st_get_stat(STAT_STRENGTH)+user.st_get_stat(STAT_MELEE), 6, user, user, TRUE)
		if(!do_after(user, ((5 SECONDS) / max(1, dice_result)), target))
			return COMPONENT_CANCEL_ATTACK_CHAIN
		if(prob(80 / max(1, dice_result)) || !dice_result)
			target_door.pixel_z = target_door.pixel_z+rand(-1, 1)
			target_door.pixel_w = target_door.pixel_w+rand(-1, 1)
			addtimer(CALLBACK(target_door, TYPE_PROC_REF(/obj/structure/vampdoor, reset_transform)), 2)
			playsound(get_turf(target_door), 'modular_darkpack/modules/doors/sounds/get_bent.ogg', 50, TRUE)
			return COMPONENT_CANCEL_ATTACK_CHAIN
		target_door.break_door(user)
		return COMPONENT_CANCEL_ATTACK_CHAIN
