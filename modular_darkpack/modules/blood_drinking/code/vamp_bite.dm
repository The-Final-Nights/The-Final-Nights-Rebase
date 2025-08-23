//this code is what should be called every time blood drinking is used on a character
/mob/living/carbon/human/proc/vamp_bite()
	src.update_blood_hud()
	if(!COOLDOWN_FINISHED(src, drinkblood_use_cd) || !COOLDOWN_FINISHED(src, drinkblood_click_cd))
		return
	COOLDOWN_START(src, drinkblood_click_cd, 1 SECONDS)
	if(src.grab_state > GRAB_PASSIVE)
		if(ishuman(src.pulling))
			var/mob/living/carbon/human/PB = src.pulling
			if(isghoul(src))
				if(!iskindred(PB))
					SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
					return
			if(!isghoul(src) && !iskindred(src))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
				return
			if(PB.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("Your Beast requires life, not the tepid swill of corpses."))
				return
			if(PB.blood_volume <= 50 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
				return
			if(PB.bloodpool <= 0 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
				return
			if(iskindred(src))
				PB.emote("groan")
			if(isghoul(src))
				PB.emote("scream")
			PB.add_bite_animation()
		if(isliving(src.pulling))
			if(!iskindred(src))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
				return
			var/mob/living/LV = src.pulling
			if(LV.blood_volume <= 50 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
			if(LV.bloodpool <= 0 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
				return
			if(LV.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src,span_warning("Your Beast requires life, not the tepid swill of corpses."))
				return
			var/skipface = (src.wear_mask && (src.wear_mask.flags_inv & HIDEFACE)) || (src.head && (src.head.flags_inv & HIDEFACE))
			if(!skipface)
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					playsound(src, 'modular_darkpack/modules/blood_drinking/sounds/drinkblood1.ogg', 50, TRUE)
					LV.visible_message(span_warning(span_bold("[src] bites [LV]'s neck!")), span_warning(span_bold("[src] bites your neck!")))
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					if(src.CheckEyewitness(LV, src, 7, FALSE))
						src.adjust_masquerade(-1)
				else
					playsound(src, 'modular_darkpack/modules/blood_drinking/sounds/kiss.ogg', 50, TRUE)
					LV.visible_message(span_italics(span_bold("[src] kisses [LV]!")), span_userlove(span_bold("[src] kisses you!")))
				src.drinksomeblood(LV, TRUE)
