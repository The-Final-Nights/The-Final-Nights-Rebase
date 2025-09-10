/obj/item/gun/ballistic/automatic/darkpack
	icon_state = "revolver"
	inhand_icon_state = "revolver"
	worn_icon_state = null
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_guns.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'

/*
/obj/item/ammo_box/magazine/darkpack
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
*/

//REVOLVERS
/obj/item/ammo_box/magazine/internal/cylinder/rev44
	name = "revolver cylinder"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	caliber = CALIBER_44
	max_ammo = 6

/obj/item/gun/ballistic/revolver/darkpack
	name = "evil coder revolver"
	icon_state = "revolver"
	inhand_icon_state = "revolver"
	worn_icon_state = "gun"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	initial_caliber = CALIBER_44
	fire_sound = 'modular_darkpack/modules/weapons/sounds/revolver.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 85

/obj/item/gun/ballistic/revolver/darkpack/magnum
	name = "magnum revolver"
	desc = "Feelin' lucky, punk?"

/obj/item/gun/ballistic/revolver/darkpack/snub
	name = "snub-nosed revolver"
	desc = "a cheap Saturday night special revolver. Sometimes called a 'purse gun'. It takes 9mm rounds."
	icon_state = "revolver_snub"
	inhand_icon_state = "revolver_snub"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev9mm
	w_class = WEIGHT_CLASS_SMALL
	initial_caliber = CALIBER_9MM
	fire_sound_volume = 65
	projectile_damage_multiplier = 1.2 //21.6 damage, slightly higher than the m1911, just so it is possible to kill NPCs within 6 bullets

/obj/item/ammo_box/magazine/internal/cylinder/rev9mm
	name = "revolver cylinder"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MM
	max_ammo = 6

//PISTOLS
/obj/item/gun/ballistic/automatic/pistol/darkpack
	icon_state = "revolver"
	inhand_icon_state = "revolver"
	worn_icon_state = "gun"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'

/obj/item/ammo_box/magazine/m44
	name = "handgun magazine (.44)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "deagle"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	caliber = CALIBER_44
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle
	name = "\improper Desert Eagle"
	desc = "A powerful .44 handgun."
	icon_state = "deagle"
	inhand_icon_state = "deagle"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m44
	recoil = 3
	fire_sound = 'modular_darkpack/modules/weapons/sounds/deagle.ogg'

/obj/item/ammo_box/magazine/m50
	name = "handgun magazine (.50)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "deagle"
	ammo_type = /obj/item/ammo_casing/vampire/c50
	caliber = CALIBER_50
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle/c50
	name = "\improper McLusky .50 caliber "
	desc = "An extremely powerful, and rare, handcannon."
	icon_state = "deagle50"
	inhand_icon_state = "deagle"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m50
	fire_sound_volume = 125 //MY EARS

/obj/item/ammo_box/magazine/darkpack45acp
	name = "pistol magazine (.45 ACP)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "m1911"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	caliber = CALIBER_45
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/m1911
	name = "\improper Colt 1911"
	desc = "A reliable .45 ACP handgun."
	icon_state = "m1911"
	inhand_icon_state = "m1911"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack45acp
	fire_sound = 'modular_darkpack/modules/weapons/sounds/m1911.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 100

/obj/item/ammo_box/magazine/glock9mm
	name = "automatic pistol magazine (9mm)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "glock19"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MM
	max_ammo = 15
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/glock19
	name = "\improper Brokk 19"
	desc = "Very fast 9mm handgun."
	icon_state = "glock19"
	inhand_icon_state = "glock19"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/glock9mm
	burst_size = 3
	fire_delay = 1
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'modular_darkpack/modules/weapons/sounds/glock.ogg'
	fire_sound_volume = 100

/obj/item/ammo_box/magazine/glock45acp
	name = "automatic pistol magazine (.45 ACP)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "glock21"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_45
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/glock21
	name = "\improper Brokk 21"
	desc = "Very fast 45 ACP handgun."
	icon_state = "glock19"
	inhand_icon_state = "glock19"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/glock45acp
	burst_size = 3
	fire_delay = 1
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'modular_darkpack/modules/weapons/sounds/glock.ogg'
	fire_sound_volume = 100

/obj/item/gun/ballistic/automatic/pistol/darkpack/beretta
	name = "\improper Elite 92G"
	desc = "A 9mm pistol favored among law enforcement and criminal alike due to it's use in action movies. Often, it is wielded in pairs."
	icon_state = "beretta"
	inhand_icon_state = "beretta"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/semi9mm
	burst_size = 1
	fire_delay = 0 //spam it
	dual_wield_spread = 10 //DUAL ELITES!
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'modular_darkpack/modules/weapons/sounds/glock.ogg'
	fire_sound_volume = 75

/obj/item/gun/ballistic/automatic/pistol/darkpack/beretta/toreador
	name = "\improper Sword Series S 9mm"
	desc = "A handgun that has been heavily decorated and customized. The improvements seem almost supernaturally good, you feel like the engravings have given you a tactical advantage."
	icon_state = "beretta_toreador"
	projectile_damage_multiplier = 2.5
	fire_sound_volume = 110

/obj/item/ammo_box/magazine/semi9mm
	name = "pistol magazine (9mm)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "semi9mm"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MM
	max_ammo = 18
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/semi9mm/toreador
	name = "custom pistol magazine (9mm)"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm/silver

//AUTOMATICS
/obj/item/ammo_box/magazine/darkpack9mm
	name = "uzi magazine (9mm)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "uzi"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MM
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/uzi
	name = "\improper Killamatic Uzi"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	inhand_icon_state = "uzi"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack9mm
	burst_size = 5
	spread = 11
	recoil = 5
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	rack_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/uzi.ogg'

/obj/item/ammo_box/magazine/darkpack9mp5
	name = "mp5 magazine (9mm)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "mp5"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MM
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/mp5
	name = "\improper HK MP5"
	desc = "A lightweight, burst-fire submachine gun, for when you really want to do some dirty cool job. Uses 9mm rounds."
	icon_state = "mp5"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	inhand_icon_state = "mp5"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack9mp5
	burst_size = 4
	spread = 4
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	rack_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/mp5.ogg'

/obj/item/ammo_box/magazine/darkpack556
	name = "carbine magazine (5.56mm)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "rifle"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	caliber = CALIBER_556
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/darkpack556/hunt
	name = "rifle magazine (5.56mm)"
	icon_state = "hunt556"
	max_ammo = 20

/obj/item/gun/ballistic/automatic/darkpack/ar15
	name = "\improper AR-15 Carbine"
	desc = "A two-round burst 5.56 toploading carbine, designated 'AR-15'."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	icon_state = "rifle"
	inhand_icon_state = "rifle"
	worn_icon_state = "rifle"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack556
	burst_size = 2
	fire_delay = 2
	spread = 4
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/rifle.ogg'
	masquerade_violating = TRUE

/obj/item/gun/ballistic/automatic/darkpack/huntrifle
	name = "hunting rifle"
	desc = "A semi-automatic hunting rifle, just like what your dad used to shoot. If your dad didn't go out to get milk, anyways."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	worn_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "huntrifle"
	inhand_icon_state = "huntrifle"
	worn_icon_state = "mosin_nagant"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack556/hunt
	burst_size = 1
	fire_delay = 1
	spread = 2
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/rifle.ogg'
	masquerade_violating = FALSE

/obj/item/ammo_box/magazine/darkpack545
	name = "rifle magazine (5.45mm)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "ak"
	ammo_type = /obj/item/ammo_casing/vampire/c545mm
	caliber = CALIBER_545
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/ak74
	name = "\improper Kalashnikov's Automatic Rifle 74"
	desc = "Pretty old, but also easy fireable and cleanable by vodka.Uses 5.45 rounds."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	worn_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "ak74"
	inhand_icon_state = "ak74"
	worn_icon_state = "sks"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack545
	recoil = 5
	burst_size = 3
	fire_delay = 3
	spread = 8
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/ak.ogg'
	masquerade_violating = TRUE

/obj/item/ammo_box/magazine/darkpackaug
	name = "AUG magazine (5.56mm)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "aug"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	caliber = CALIBER_556
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/aug
	name = "\improper Steyr AUG-77"
	desc = "A three-round burst 5.56 bullpup design, designated 'Steyr AUG-77'."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	icon_state = "aug"
	inhand_icon_state = "aug"
	worn_icon_state = "aug"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpackaug
	burst_size = 3
	fire_delay = 2
	spread = 3
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/rifle.ogg'
	masquerade_violating = TRUE
	obj_flags = NONE

/obj/item/ammo_box/magazine/darkpackthompson
	name = "tommy gun magazine (.45 ACP)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	icon_state = "thompson"
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	caliber = CALIBER_45
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/thompson
	name = "\improper Thompson Submachine Gun"
	desc = "\"Mamma-mia, Mercurio! Yu shot 'im in da head, he can't speek now! Yu guappo, Mercurio, yu naturale guappo!\""
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	icon_state = "thompson"
	inhand_icon_state = "thompson"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpackthompson
	recoil = 7
	burst_size = 5
	fire_delay = 3
	spread = 15
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/thompson.ogg'
	masquerade_violating = TRUE

/obj/item/ammo_box/magazine/internal/vampire/sniper
	name = "sniper rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/vampire/c50
	caliber = CALIBER_50
	max_ammo = 5
	//multiload = TRUE

/obj/item/gun/ballistic/automatic/darkpack/sniper
	name = "sniper rifle"
	desc = "A long ranged weapon that does significant damage. No, you can't quickscope."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	icon_state = "sniper"
	inhand_icon_state = "sniper"
	worn_icon_state = "sniper"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampire/sniper
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/sniper.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	rack_sound = 'sound/items/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/rifle/bolt_in.ogg'
	tac_reloads = FALSE
	fire_delay = 40
	burst_size = 1
	w_class = WEIGHT_CLASS_NORMAL
	//zoomable = TRUE
	//zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	//zoom_out_amt = 5
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 2 //140 damage. Nice.
	actions_types = list()
	masquerade_violating = TRUE

/obj/item/ammo_box/magazine/internal/vampshotgun
	name = "shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/vampire/c12g
	caliber = CALIBER_SHOTGUN
	//multiload = FALSE
	max_ammo = 6
	masquerade_violating = FALSE

/obj/item/gun/ballistic/shotgun/vampire
	name = "shotgun"
	desc = "A traditional shotgun with wood furniture and a six-round tube magazine."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_guns.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "pomp"
	inhand_icon_state = "pomp"
	worn_icon_state = "pomp"
	recoil = 6
	fire_delay = 6
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampshotgun
	can_be_sawn_off	= FALSE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/pomp.ogg'
	recoil = 4
	inhand_x_dimension = 32
	inhand_y_dimension = 32

/obj/item/ammo_box/magazine/darkpackautoshot
	name = "shotgun magazine (12ga)"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "spas15"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/buck
	caliber = CALIBER_SHOTGUN
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/autoshotgun
	name = "\improper Jaegerspas-XV"
	desc = "A semi-automatic shotgun. It looks more like an assault rifle than a shotgun and fires at a deadly pace."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	icon_state = "spas15"
	inhand_icon_state = "spas15"
	worn_icon_state = "rifle"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpackautoshot
	burst_size = 1
	fire_delay = 2
	spread = 4
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/pomp.ogg'
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 0.9
	masquerade_violating = TRUE
	recoil = 6

/obj/item/gun/ballistic/shotgun/toy/crossbow/vampire
	name = "crossbow"
	desc = "Welcome to the Middle Ages!"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "crossbow0"
	inhand_icon_state = "crossbow0"
	fire_delay = 16
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampcrossbow
	fire_sound = 'sound/items/syringeproj.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	masquerade_violating = TRUE
	obj_flags = NONE

/obj/item/ammo_box/magazine/internal/vampcrossbow
	ammo_type = /obj/item/ammo_casing/caseless/bolt
	caliber = CALIBER_BOLT
	max_ammo = 2
