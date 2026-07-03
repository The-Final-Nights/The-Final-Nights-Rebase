// Unique sawn-off variants of base Darkpack guns
/obj/item/gun/ballistic/shotgun/vampire/doublebarrel/sawnoff
	name = "sawn-off double barrel shotgun"
	desc = "A old fashioned double barrel shotgun, complete with a double-trigger system. This one's sawn down well past the legal barrel length.."
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	icon_state = "dbarrel_sawn"
	inhand_icon_state = "dbarrel_sawn"
	base_icon_state = "dbarrel_sawn"
	can_be_sawn_off = FALSE

/obj/item/ammo_box/magazine/internal/vampshotgun/sawnoff
	name = "sawn-off shotgun internal magazine"
	max_ammo = 4

/obj/item/gun/ballistic/shotgun/vampire/sawnoff
	name = "sawn-off shotgun"
	desc = "A traditional shotgun that's been shortened.. probably illegally. Sports a three-round tube magazine."
	icon_state = "pomp_sawn"
	inhand_icon_state = "pomp_sawn"
	recoil = 10
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampshotgun/sawnoff


/obj/item/ammo_box/magazine/internal/darkpack/lever/sawnoff
	name = "mares leg lever action internal magazine"
	max_ammo = 8	//7+1

/obj/item/gun/ballistic/rifle/darkpack/lever/sawnoff
	name = "mares leg lever action carbine"
	desc = "A .44 caliber lever action rifle, perfect for casual hunters, reenactors, and urban cowboys. This one has had its barrel and stock sawn down."
	icon_state = "lever_sawn"
	inhand_icon_state = "lever_sawn"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/darkpack/lever/sawnoff
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/automatic/darkpack/ak74/sawn
	name = "sawn-off Kalashnikov's Automatic Rifle 74"
	desc = "Pretty old, but also easy fireable and cleanable by vodka. This one has had its stock removed and the barrel chopped; it's a miracle it still cycles! Uses 5.45 rounds."
	icon_state = "ak74_sawn"
	inhand_icon_state = "ak74_sawn"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack545
	recoil = 8	//Increased recoil due to sawing off the stock on a full-auto. Bootleg draco.
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/automatic/darkpack/musket/sawn
	name = "butchered antique musket"
	desc = "A antique musket, likely from the mid 19th century that- wh.. why the fuck would you do this to a musket!?"
	icon_state = "musket_sawn"
	inhand_icon_state = "musket_sawn"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT	//TALLY HOOOO!!!
	recoil = 12
	spread = 25		//+25 from sawing off anyway, good fucking luck
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
