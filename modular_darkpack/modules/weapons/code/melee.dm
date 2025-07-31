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

/obj/item/melee/baseball_bat/vamp
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'
	icon_state = "baseball"

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
	//masquerade_violating = TRUE
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
	armour_penetration = 100	//It's magical damage
	block_chance = 20
	item_flags = DROPDEL
	//masquerade_violating = TRUE
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
	//masquerade_violating = TRUE

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
	bare_wound_bonus = 5
	throwforce = 15
	attack_verb_continuous = list("slashes", "cuts", "reaps")
	attack_verb_simple = list("slash", "cut", "reap")
	hitsound = 'sound/weapons/slash.ogg'
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
	catchphrase = null
	on_use_sound = 'sound/magic/disintegrate.ogg'
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
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/melee/vamp/chainsaw
	name = "chainsaw"
	desc = "A versatile power tool. Useful for limbing trees and delimbing humans."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "chainsaw"
	flags_1 = CONDUCT_1
	force = 15
	var/force_on = 150
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 10
	throw_speed = 2
	throw_range = 4
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = "swing_hit"
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/startchainsaw)
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY
	var/on = FALSE
	var/wielded = FALSE

/obj/item/melee/vamp/chainsaw/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/melee/vamp/chainsaw/ComponentInitialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/chainsawhit.ogg', TRUE)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/melee/vamp/chainsaw/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/obj/item/melee/vamp/chainsaw/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/melee/vamp/chainsaw/attack_self(mob/user)
	on = !on
	to_chat(user, "As you pull the starting cord dangling from [src], [on ? "it begins to whirr." : "the chain stops moving."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : initial(force)
	var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = on

	if(on)
		hitsound = 'sound/weapons/chainsawhit.ogg'
	else
		hitsound = "swing_hit"

	if(src == user.get_active_held_item())
		user.update_inv_hands()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

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
	hitsound = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 50
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	is_wood = TRUE

/obj/item/vampire_stake/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(isgarou(target) || iswerewolf(target) || isanimal(target))
		return
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

/obj/item/melee/vamp/shovel
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "shovel"
	name = "shovel"
	desc = "Great weapon against mortal or immortal."
	force = 40
	throwforce = 10
	block_chance = 30
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "chops", "tears", "beats")
	attack_verb_simple = list("attack", "chop", "tear", "beat")
	armor = list(MELEE = 25, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	resistance_flags = FIRE_PROOF
	masquerade_violating = FALSE
	obj_flags = CONDUCTS_ELECTRICITY

/obj/item/melee/vamp/shovel/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(!target.IsStun() && prob(25))
		visible_message(span_warning("[user] bonks [src]'s head!"), span_warning("You bonk[target]'s head!"))
		target.Stun(5)
		target.drop_all_held_items()

/obj/item/katana/vamp/kosa
	name = "scythe"
	desc = "More instrument, than a weapon. Instrumentally cuts heads..."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "kosa"
	force = 50
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = null
	block_chance = 12
	armour_penetration = 25
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	wound_bonus = 5
	bare_wound_bonus = 10
	resistance_flags = FIRE_PROOF
	//masquerade_violating = TRUE

/obj/item/melee/vamp/eguitar
	icon = 'modular_darkpack/modules/deprecated/icons/48x32weapons.dmi'
	icon_state = "rock0"
	name = "electric guitar"
	desc = "You are pretty fly for a white guy..."
	force = 40
	throwforce = 25
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	attack_verb_continuous = list("attacks", "chops", "rocks", "hits")
	attack_verb_simple = list("attack", "chop", "rock", "hit")
	hitsound = 'modular_darkpack/modules/deprecated/sounds/rock.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 30)
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	bare_wound_bonus = 15
	armour_penetration = 30
	pixel_w = -8
	actions_types = list(/datum/action/item_action/eguitar)
	is_wood = TRUE
	var/wielded = FALSE
	var/on = FALSE
	var/last_solo = 0

/obj/item/melee/vamp/eguitar/AltClick(mob/user)
	if(last_solo+600 > world.time)
		return
	var/result = input(user, "Select a riff") as null|anything in list("1", "2", "3", "4")
	if(result)
		last_solo = world.time
		if(result == "1")
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/solo1.ogg', 100, FALSE)
		if(result == "2")
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/solo2.ogg', 100, FALSE)
		if(result == "3")
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/solo3.ogg', 100, FALSE)
		if(result == "4")
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/solo4.ogg', 100, FALSE)

/obj/item/melee/vamp/eguitar/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/melee/vamp/eguitar/ComponentInitialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=40, force_wielded=10, icon_wielded="rock1")

/obj/item/melee/vamp/eguitar/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/obj/item/melee/vamp/eguitar/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/melee/vamp/eguitar/update_icon_state()
	icon_state = "rock0"

/obj/item/shield/door
	name = "\improper door"
	desc = "It opens and closes."
	icon_state = "door"
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	force = 20
	block_chance = 25
	throwforce = 40
	throw_speed = 2
	throw_range = 3
	masquerade_violating = FALSE
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	max_integrity = 999999
	material_flags = MATERIAL_NO_EFFECTS
	is_wood = TRUE

/obj/item/melee/classic_baton/vampire
	name = "police baton"
	desc = "Blunt instrument of justice."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "baton"
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("bludgeons", "bashes", "beats")
	attack_verb_simple = list("bludgeon", "bash", "beat")
	force = 30
	wound_bonus = 15
	block_chance = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_NORMAL
	is_wood = TRUE


/obj/item/knife/vamp/switchblade
	name = "switchblade"
	desc = "A spring-loaded knife. Perfect for stabbing sharks and jets."
	flags_1 = CONDUCT_1
	force = 5
	icon_state = "switchblade" //sprite by Spefo
	w_class = WEIGHT_CLASS_NORMAL
	block_chance = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 6
	hitsound = 'sound/weapons/genhit.ogg'
	attack_verb_continuous = list("stubs", "pokes")
	attack_verb_simple = list("stub", "poke")
	resistance_flags = FIRE_PROOF
	var/extended = TRUE

/obj/item/knife/vamp/switchblade/attack_self(mob/user)
	extended = !extended
	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, TRUE)
	if(extended)
		force = 25
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = 15
		armour_penetration = 55
		wound_bonus = 5
		bare_wound_bonus = 5
		icon_state = "switchblade1"
		attack_verb_continuous = list("slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
		attack_verb_simple = list("slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
		hitsound = 'sound/weapons/bladeslice.ogg'
		sharpness = SHARP_EDGED
		grid_width = 1 GRID_BOXES
		grid_height = 2 GRID_BOXES
	else
		force = 5
		w_class = WEIGHT_CLASS_TINY
		armour_penetration = 0
		throwforce = 5
		icon_state = "switchblade0"
		attack_verb_continuous = list("stubs", "pokes")
		attack_verb_simple = list("stub", "poke")
		hitsound = 'sound/weapons/genhit.ogg'
		sharpness = SHARP_NONE
		grid_width = 1 GRID_BOXES
		grid_height = 1 GRID_BOXES


/obj/item/melee/vamp/brick
	name = "Brick"
	desc = "Killer of gods and men alike, builder of worlds vast."
	icon = 'modular_darkpack/modules/deprecated/icons/weapons.dmi'
	icon_state = "red_brick"
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	armour_penetration = 0
	throwforce = 30
	attack_verb_continuous = list("bludgeons", "bashes", "beats")
	attack_verb_simple = list("bludgeon", "bash", "beat", "smacks")
	hitsound = 'sound/weapons/genhit3.ogg'
	sharpness = SHARP_NONE
	force = 18
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_NORMAL
	grid_width = 2 GRID_BOXES
	grid_height = 1 GRID_BOXES
	var/broken = FALSE

/obj/item/melee/vamp/brick/after_throw(datum/callback/callback)
	broken = !broken
	if(broken)
		force = 14
		w_class = WEIGHT_CLASS_SMALL
		throwforce = 14
		armour_penetration = 0
		icon_state = "red_brick2"
		attack_verb_continuous = list("bludgeons", "bashes", "beats")
		attack_verb_simple = list("bludgeon", "bash", "beat", "smacks", "whacks")
		hitsound = 'sound/weapons/genhit1.ogg'
		sharpness = SHARP_NONE
		grid_width = 1 GRID_BOXES
		grid_height = 1 GRID_BOXES
	else
		force = 18
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = 30
		armour_penetration = 0
		attack_verb_continuous = list("bludgeons", "bashes", "beats")
		attack_verb_simple = list("bludgeon", "bash", "beat", "smacks")
		hitsound = 'sound/weapons/genhit3.ogg'
		sharpness = SHARP_NONE
		grid_width = 2 GRID_BOXES
		grid_height = 1 GRID_BOXES


