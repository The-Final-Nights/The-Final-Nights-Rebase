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
	masquerade_violating = TRUE

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
	masquerade_violating = TRUE

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
	inhand_icon_state = "machete"
	pixel_w = -8
	masquerade_violating = FALSE

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
	inhand_icon_state = "longsword"

// TODO: [Rebase] reimplement selling stuff
/*
/obj/item/claymore/longsword/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 1800, "longsword", FALSE)
*/

/obj/item/melee/baseball_bat/vamp
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "baseball"
	inhand_icon_state = "baseball"

// TODO: [Rebase] reimplement selling stuff
/*
/obj/item/melee/baseball_bat/vamp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 50, "baseball", FALSE)
*/

/obj/item/melee/baseball_bat/vamp/hand
	name = "ripped arm"
	desc = "Wow, that was someone's arm."
	icon_state = "hand"
	block_chance = 25
	masquerade_violating = TRUE
	//is_wood = FALSE

/obj/item/melee/vamp/tire
	name = "tire iron"
	desc = "Can be used as a tool or as a weapon."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "pipe"
	force = 20
	wound_bonus = 10
	throwforce = 10
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY

/obj/item/knife/vamp
	name = "knife"
	desc = "Don't cut yourself accidentally."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'

/obj/item/knife/vamp/gangrel
	name = "claws"
	icon_state = "gangrel"
	w_class = WEIGHT_CLASS_BULKY
	force = 6
	armour_penetration = 100 //It's magical damage
	block_chance = 20
	item_flags = DROPDEL
	masquerade_violating = TRUE
	obj_flags = NONE

/obj/item/knife/vamp/gangrel/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(isliving(target))
		var/mob/living/L = target
		L.apply_damage(30, AGGRAVATED)

/obj/item/knife/vamp/gangrel/lasombra
	name = "shadow tentacle"
	force = 7
	armour_penetration = 100
	block_chance = 0
	icon_state = "lasombra"
	masquerade_violating = TRUE

/obj/item/knife/vamp/gangrel/lasombra/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(isliving(target))
		var/mob/living/L = target
		L.apply_damage(16, AGGRAVATED)
		L.apply_damage(7, BURN)

/obj/item/melee/vamp/handsickle
	name = "hand sickle"
	desc = "Reap what they have sowed."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "handsickle"
	force = 30
	wound_bonus = -5
	throwforce = 15
	attack_verb_continuous = list("slashes", "cuts", "reaps")
	attack_verb_simple = list("slash", "cut", "reap")
	hitsound = 'sound/items/weapons/slash.ogg'
	armour_penetration = 40
	block_chance = 0
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY

/obj/item/melee/touch_attack/werewolf
	name = "\improper falling touch"
	desc = "This is kind of like when you rub your feet on a shag rug so you can zap your friends, only a lot less safe."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	//catchphrase = null
	//on_use_sound = 'sound/magic/disintegrate.ogg'
	icon_state = "falling"
	inhand_icon_state = "disintegrate"

/obj/item/melee/touch_attack/werewolf/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(isliving(target))
		var/mob/living/L = target
		L.AdjustKnockdown(4 SECONDS)
		L.adjustStaminaLoss(50)
		L.Immobilize(3 SECONDS)
		if(L.body_position != LYING_DOWN)
			L.toggle_resting()
	return ..()

/obj/item/knife/vamp/gangrel/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))

/obj/item/chainsaw/vamp
	name = "chainsaw"
	desc = "A versatile power tool. Useful for limbing trees and delimbing humans."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'

/obj/item/vampire_stake
	name = "stake"
	desc = "Paralyzes blank-bodies if aimed straight to the heart."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "stake"
	force = 10
//	wound_bonus = -10
	throwforce = 10
	attack_verb_continuous = list("pierces", "cuts")
	attack_verb_simple = list("pierce", "cut")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	armour_penetration = 50
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/vampire_stake/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	// TODO: [Rebase] reimplement werewolfs
	/*
	if(isgarou(target) || iswerewolf(target) || isanimal(target))
		return
	*/
	if(target.IsParalyzed() || target.IsKnockdown() || target.IsStun())
		return
	if(!target.IsParalyzed() && iskindred(target) && !target.stakeimmune)
		if(HAS_TRAIT(target, TRAIT_STAKE_RESISTANT))
			visible_message(span_warning("[user]'s stake splinters as it touches [target]'s heart!"), span_warning("Your stake splinters as it touches [target]'s heart!"))
			REMOVE_TRAIT(target, TRAIT_STAKE_RESISTANT, MAGIC_TRAIT)
			qdel(src)
		else
			visible_message(span_warning("[user] aims [src] straight to the [target]'s heart!"), span_warning("You aim [src] straight to the [target]'s heart!"))
			if(do_after(user, 20, target))
				user.do_attack_animation(target)
				visible_message(span_warning("[user] pierces [target]'s torso!"), span_warning("You pierce [target]'s torso!"))
				target.Paralyze(1200)
				target.Sleeping(1200)
				qdel(src)

/obj/item/shovel/vamp
	name = "shovel"
	desc = "Great weapon against mortal or immortal."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "shovel"

/obj/item/scythe/vamp
	name = "scythe"
	desc = "More instrument, than a weapon. Instrumentally cuts heads..."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "kosa"
	inhand_icon_state = "kosa"

/obj/item/instrument/eguitar/vamp
	name = "electric guitar"
	desc = "You are pretty fly for a white guy..."
	icon = 'modular_darkpack/modules/deprecated/icons/48x32weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "rock0"
	inhand_icon_state = "rock0"

/obj/item/shield/door
	name = "\improper door"
	desc = "It opens and closes."
	icon_state = "door"
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	force = 15
	block_chance = 25
	throwforce = 10
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = NONE
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/melee/baton/vamp
	name = "police baton"
	desc = "Blunt instrument of justice."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "baton"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/switchblade/vamp
	name = "switchblade"
	desc = "A spring-loaded knife. Perfect for stabbing sharks and jets."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'

/obj/item/melee/vamp/brick
	name = "Brick"
	desc = "Killer of gods and men alike, builder of worlds vast."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "red_brick"
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	armour_penetration = 0
	throwforce = 15
	attack_verb_continuous = list("bludgeons", "bashes", "beats")
	attack_verb_simple = list("bludgeon", "bash", "beat", "smacks")
	hitsound = 'sound/items/weapons/genhit3.ogg'
	force = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_NORMAL
	//grid_width = 2 GRID_BOXES
	//grid_height = 1 GRID_BOXES
	var/broken = FALSE

/obj/item/melee/vamp/brick/after_throw(datum/callback/callback)
	if(prob(75))
		broken = FALSE
	if(broken)
		force = 6
		w_class = WEIGHT_CLASS_SMALL
		throwforce = 10
		armour_penetration = 0
		icon_state = "red_brick2"
		attack_verb_continuous = list("bludgeons", "bashes", "beats")
		attack_verb_simple = list("bludgeon", "bash", "beat", "smacks", "whacks")
		hitsound = 'sound/items/weapons/genhit1.ogg'
		//grid_width = 1 GRID_BOXES
		//grid_height = 1 GRID_BOXES
