/obj/item/claymore/longsword/camarilla
	name = "reinforced longsword"
	desc = "A heavily modified longsword, this huge chunk of metal looks too heavy to lift for any normal person. The edge appears exceptionally sharp."
	force = 3 LETHAL_TTRPG_DAMAGE
	armour_penetration = 75
	block_chance = 75
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE

/obj/item/vamp/keys/camarilla_ert
	name = "whiterock keys"
	accesslocks = list(
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_PRINCE,
		LOCKACCESS_CLERK,
		LOCKACCESS_CHANTRY,
		LOCKACCESS_THEATRE,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIMOGEN,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/card/whiterock
	name = "Whiterock PMC Trooper Badge"
	desc = "A badge which shows honour and dedication."
	icon = 'modular_darkpack/modules/jobs/icons/id_items.dmi'
	icon_state = "sec_badge"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/jobs/icons/id_onfloors.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'

/obj/item/card/whiterock/officer
	name = "Whiterock PMC Officer Badge"
	icon_state = "head_sec_badge"

/obj/item/card/whiterock/medic
	name = "Whiterock PMC Medic Badge"

/obj/item/card/whiterock/cqb
	name = "Whiterock PMC CQB Badge"

/obj/item/card/whiterock/marksman
	name = "Whiterock PMC Marksman Badge"

/obj/item/ammo_box/magazine/darkpack556/incendiary
	name = "carbine magazine (5.56mm) incendiary"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm/incendiary

/obj/item/ammo_box/magazine/darkpack556/silver
	name = "carbine magazine (5.56mm) silver"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm/silver

/obj/item/radio/headset/darkpack/whiterock
	name = "military radio"
	radio_network = NETWORK_CAMARILLA
