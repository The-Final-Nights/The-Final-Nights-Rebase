/obj/item/melee/vamp
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	var/quieted = FALSE

// TODO: [Rebase] reimplement selling stuff
/*
/obj/item/melee/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 25, "melee", FALSE)
*/

/obj/item/fireaxe/vamp
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	pixel_w = -8

/obj/item/katana/vamp
	name = "katana"
	desc = "An elegant weapon, its tiny edge is capable of cutting through flesh and bone with ease."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	pixel_w = -8

/obj/item/katana/vamp/Initialize(mapload)
	. = ..()
	// TODO: [Rebase] reimplement selling stuff
	//AddComponent(/datum/component/selling, 250, "katana", FALSE)

/obj/item/katana/vamp/fire
	name = "burning katana"
	icon_state = "firetana"
	item_flags = DROPDEL
	obj_flags = NONE
	//masquerade_violating = TRUE

// TODO: [Rebase] reimplement selling stuff
/*
//Do not sell the magically summoned katanas for infinite cash
/obj/item/katana/vamp/fire/Initialize(mapload)
	. = ..()
	var/datum/component/selling/sell_component = GetComponent(/datum/component/selling)
	if(sell_component)
		sell_component.RemoveComponent()
*/

/obj/item/katana/vamp/fire/afterattack(atom/target, mob/living/carbon/user, proximity)
	. = ..()
	if (isliving(target) && proximity)
		var/mob/living/burnt_mob = target
		burnt_mob.apply_damage(15, BURN)

/obj/item/katana/vamp/blood
	name = "bloody katana"
	color = "#bb0000"
	item_flags = DROPDEL
	obj_flags = NONE
	//masquerade_violating = TRUE

/obj/item/katana/vamp/blood/Initialize(mapload)
	. = ..()
	// TODO: [Rebase] reimplement selling stuff
	/*
	var/datum/component/selling/sell_component = GetComponent(/datum/component/selling)
	if(sell_component)
		sell_component.RemoveComponent()
	*/

/obj/item/katana/vamp/blood/afterattack(atom/target, mob/living/carbon/user, proximity)
	. = ..()
	if (isliving(target) && proximity)
		var/mob/living/burnt_mob = target
		burnt_mob.apply_damage(15, AGGRAVATED)

/obj/item/melee/sabre/rapier
	name = "rapier"
	desc = "A thin, elegant sword, the rapier is a weapon of the duelist, designed for thrusting."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "rapier"

// TODO: [Rebase] reimplement selling stuff
/*
/obj/item/melee/sabre/rapier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 800, "rapier", FALSE)
*/

/obj/item/claymore/machete
	name = "machete"
	desc = "A certified chopper fit for the jungles...but you don't see any vines around. Well-weighted enough to be thrown."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "machete"
	pixel_w = -8
	//masquerade_violating = FALSE

// TODO: [Rebase] reimplement selling stuff
/*
/obj/item/claymore/machete/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 150, "machete", FALSE)
*/

/obj/item/melee/sabre/vamp
	name = "sabre"
	desc = "A curved sword, the sabre is a weapon of the cavalry, designed for slashing and thrusting."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "sabre"

// TODO: [Rebase] reimplement selling stuff
/*
/obj/item/melee/sabre/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 1000, "sabre", FALSE)
*/

/obj/item/claymore/longsword
	name = "longsword"
	desc = "A classic weapon of the knight, the longsword is a versatile weapon that can be used for both cutting and thrusting."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "longsword"

// TODO: [Rebase] reimplement selling stuff
/*
/obj/item/claymore/longsword/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 1800, "longsword", FALSE)
*/
