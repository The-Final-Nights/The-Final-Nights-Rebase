/obj/item/bodypart/chest/check_wounding(woundtype, damage, wound_bonus, exposed_wound_bonus, attack_direction, damage_source, wound_clothing)
	if(get_kindred_splat(owner))
		return
	. = ..()
