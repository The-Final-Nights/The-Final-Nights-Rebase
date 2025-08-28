/mob/living/carbon/human/toggle_move_intent(mob/living/user)
	if (blocking && move_intent == MOVE_INTENT_WALK)
		return

	. = ..()

/mob/living/carbon/human/proc/SwitchBlocking()
	if(!blocking)
		visible_message(span_warning("[src] prepares to block."), span_warning("You prepare to block."))
		blocking = TRUE
		if(hud_used)
			hud_used.block_icon.icon_state = "act_block_on"
		clear_parrying()
		remove_overlay(FIGHT_LAYER)
		var/mutable_appearance/block_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "block", -FIGHT_LAYER)
		overlays_standing[FIGHT_LAYER] = block_overlay
		apply_overlay(FIGHT_LAYER)
		last_move_intent = move_intent
		if(move_intent == MOVE_INTENT_RUN)
			toggle_move_intent(src)
	else
		to_chat(src, span_warning("You lower your defense."))
		remove_overlay(FIGHT_LAYER)
		blocking = FALSE
		if(move_intent != last_move_intent)
			toggle_move_intent(src)
		if(hud_used)
			hud_used.block_icon.icon_state = "act_block_off"

/mob/living/carbon/human/attackby(obj/item/W, mob/living/user, params)
	if(user.blocking)
		return
	if(getStaminaLoss() >= 50 && blocking)
		SwitchBlocking()
	if(CheckFrenzyMove() && blocking)
		SwitchBlocking()
	if(user.a_intent == INTENT_GRAB && ishuman(user))
		var/mob/living/carbon/human/ZIG = user
		if(ZIG.getStaminaLoss() < 50 && !ZIG.CheckFrenzyMove())
			ZIG.parry_class = W.w_class
			ZIG.Parry(src)
			return
	if(user == parrying && user != src)
		if(W.w_class == parry_class)
			user.apply_damage(60, STAMINA)
		if(W.w_class == parry_class-1 || W.w_class == parry_class+1)
			user.apply_damage(30, STAMINA)
		else
			user.apply_damage(10, STAMINA)
		user.do_attack_animation(src)
		visible_message(span_danger("[src] parries the attack!"), span_danger("You parry the attack!"))
		playsound(src, 'modular_darkpack/modules/deprecated/sounds/parried.ogg', 70, TRUE)
		clear_parrying()
		return
	if(HAS_TRAIT(src, TRAIT_ENHANCED_MELEE_DODGE))
		apply_damage(3, STAMINA)
		user.do_attack_animation(src)
		playsound(src, 'sound/items/weapons/tap.ogg', 70, TRUE)
		emote("flip")
		visible_message(span_danger("[src] dodges the attack!"), span_danger("You dodge the attack!"))
		return
	if(blocking)
		if(istype(W, /obj/item/melee))
			var/obj/item/melee/WEP = W
			var/obj/item/bodypart/assexing = get_bodypart("[(active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
			if(istype(get_active_held_item(), /obj/item))
				var/obj/item/IT = get_active_held_item()
				if(IT.w_class >= W.w_class)
					apply_damage(10, STAMINA)
					user.do_attack_animation(src)
					playsound(src, 'sound/items/weapons/tap.ogg', 70, TRUE)
					visible_message(span_danger("[src] blocks the attack!"), span_danger("You block the attack!"))
					if(incapacitated(TRUE, TRUE) && blocking)
						SwitchBlocking()
					return
				else
					var/hand_damage = max(WEP.force - IT.force/2, 1)
					playsound(src, WEP.hitsound, 70, TRUE)
					apply_damage(hand_damage, WEP.damtype, assexing)
					apply_damage(30, STAMINA)
					user.do_attack_animation(src)
					visible_message(span_warning("[src] weakly blocks the attack!"), span_warning("You weakly block the attack!"))
					if(incapacitated(TRUE, TRUE) && blocking)
						SwitchBlocking()
					return
			else
				playsound(src, WEP.hitsound, 70, TRUE)
				apply_damage(round(WEP.force/2), WEP.damtype, assexing)
				apply_damage(30, STAMINA)
				user.do_attack_animation(src)
				visible_message(span_warning("[src] blocks the attack with [gender == MALE ? "his" : "her"] bare hands!"), span_warning("You block the attack with your bare hands!"))
				if(incapacitated(TRUE, TRUE) && blocking)
					SwitchBlocking()
				return
	. = ..()

/mob/living/carbon/human/attack_hand(mob/user)
	if(getStaminaLoss() >= 50 && blocking)
		SwitchBlocking()
	if(CheckFrenzyMove() && blocking)
		SwitchBlocking()
	if(user.a_intent == INTENT_HARM && HAS_TRAIT(src, TRAIT_ENHANCED_MELEE_DODGE))
		playsound(src, 'sound/items/weapons/tap.ogg', 70, TRUE)
		apply_damage(3, STAMINA)
		user.do_attack_animation(src)
		emote("flip")
		visible_message(span_danger("[src] dodges the punch!"), span_danger("You dodge the punch!"))
		return
	if(user.a_intent == INTENT_HARM && blocking)
		playsound(src, 'sound/items/weapons/tap.ogg', 70, TRUE)
		apply_damage(10, STAMINA)
		user.do_attack_animation(src)
		visible_message(span_danger("[src] blocks the punch!"), span_danger("You block the punch!"))
		if(incapacitated(TRUE, TRUE) && blocking)
			SwitchBlocking()
		return
	. = ..()

/mob/living/carbon/human/proc/Parry(mob/M)
	if(!pulledby && !parrying && world.time-parry_cd >= 30 && M != src)
		parrying = M
		if(blocking)
			SwitchBlocking()
		visible_message(span_warning("[src] prepares to parry [M]'s next attack."), span_warning("You prepare to parry [M]'s next attack."))
		playsound(src, 'modular_darkpack/modules/deprecated/sounds/parry.ogg', 70, TRUE)
		remove_overlay(FIGHT_LAYER)
		var/mutable_appearance/parry_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "parry", -FIGHT_LAYER)
		overlays_standing[FIGHT_LAYER] = parry_overlay
		apply_overlay(FIGHT_LAYER)
		parry_cd = world.time
		spawn(10)
			clear_parrying()
	return

/mob/living/carbon/human/proc/clear_parrying()
	if(parrying)
		parrying = null
		remove_overlay(FIGHT_LAYER)
		to_chat(src, span_warning("You lower your defense."))
