/datum/supply_pack/weapons/weapondoubleshotgun
	name = "Weapon (double barrel shotgun)"
	desc = "Contains a double barrel shotgun."
	cost = 1000
	contains = list(/obj/item/gun/ballistic/shotgun/vampire/doublebarrel)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponcolt
	name = "Weapon (colt m1911)"
	desc = "Contains a Colt M1911."
	cost = 250
	contains = list(/obj/item/gun/ballistic/automatic/pistol/darkpack/m1911)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponlever
	name = "Weapon (leveraction rifle)"
	desc = "Contains a leveraction repeating rifle."
	cost = 1600
	contains = list(/obj/item/gun/ballistic/rifle/darkpack/lever)
	crate_name = "weapon crate"

/datum/supply_pack/weapons/weaponsilversword
	name = "Weapon (silver sword)"
	desc = "Contains a silver sword."
	cost = 40000
	contains = list(/obj/item/claymore/longsword/silver)
	crate_name = "weapon crate"

// DARKPACK EDIT ADD START - Loadout + Fashion Overhaul
/datum/supply_pack/weapons/tallyho
	name = "Revolutionary Reenactment Kit"
	desc = "No taxation without representation! Contains a set of revolutionary attire, set with a pair of antique muskets."
	cost = 6000
	contains = list(
		/obj/item/gun/ballistic/automatic/darkpack/musket,
		/obj/item/gun/ballistic/automatic/darkpack/musket,
		/obj/item/ammo_box/darkpack/c75,
		/obj/item/clothing/under/costume/redcoat,
		/obj/item/clothing/head/costume/redcoat,
		/obj/item/clothing/head/costume/powdered_wig,
		/obj/item/clothing/suit/armor/militia,
	)
	crate_name = "armor crate"

/datum/supply_pack/weapons/historical_larp_bulk
	name = "Historical LARP Bulk Pack"
	desc = "A set of live-action roleplaying outfits for the discerning history buff, from the Roman Empire to fall of the Soviet Union. Weapons not included."
	cost = 6000
	contains = list(
		/obj/item/clothing/under/costume/roman,
		/obj/item/clothing/under/costume/soviet,
		/obj/item/clothing/under/costume/gladiator,
		/obj/item/clothing/head/helmet/gladiator,
		/obj/item/clothing/under/costume/gi,
		/obj/item/storage/belt/sheath/katana/empty,
		/obj/item/clothing/under/costume/gamberson/military,
		/obj/item/clothing/head/helmet/roman,
		/obj/item/clothing/shoes/roman,
		/obj/item/clothing/suit/armor/vest/russian_coat,
		/obj/item/clothing/head/costume/ushanka,
	)
	crate_name = "armor crate"
// DARKPACK EDIT ADD END - Loadout + Fashion Overhaul
