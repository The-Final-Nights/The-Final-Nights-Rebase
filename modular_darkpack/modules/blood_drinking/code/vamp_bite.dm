//this code is what should be called every time blood drinking is used on a character
/mob/living/carbon/human/proc/vamp_bite()
	src.update_blood_hud()
	if(world.time < src.last_drinkblood_use+30)
		return
	if(world.time < src.last_drinkblood_click+10)
		return
	src.last_drinkblood_click = world.time
	if(src.grab_state > GRAB_PASSIVE)
		if(ishuman(src.pulling))
			var/mob/living/carbon/human/PB = src.pulling
			if(isghoul(src))
				if(!iskindred(PB))
					SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(src, "<span class='warning'>You're not desperate enough to try <i>that</i>.</span>")
					return
			if(!isghoul(src) && !iskindred(src))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>You're not desperate enough to try <i>that</i>.</span>")
				return
			if(PB.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>Your Beast requires life, not the tepid swill of corpses.</span>")
				return
			if(PB.blood_volume <= 50 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>This vessel is empty. You'll have to find another.</span>")
				return
			if(PB.bloodpool <= 0 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>This vessel is empty. You'll have to find another.</span>")
				return
			if(iskindred(src))
				PB.emote("groan")
			if(isghoul(src))
				PB.emote("scream")
			PB.add_bite_animation()
		if(isliving(src.pulling))
			if(!iskindred(src))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>You're not desperate enough to try <i>that</i>.</span>")
				return
			var/mob/living/LV = src.pulling
			if(LV.blood_volume <= 50 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>This vessel is empty. You'll have to find another.</span>")
			if(LV.bloodpool <= 0 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>This vessel is empty. You'll have to find another.</span>")
				return
			if(LV.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>Your Beast requires life, not the tepid swill of corpses.</span>")
				return
			var/skipface = (src.wear_mask && (src.wear_mask.flags_inv & HIDEFACE)) || (src.head && (src.head.flags_inv & HIDEFACE))
			if(!skipface)
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					playsound(src, 'modular_darkpack/modules/blood_drinking/sounds/drinkblood1.ogg', 50, TRUE)
					LV.visible_message("<span class='warning'><b>[src] bites [LV]'s neck!</b></span>", "<span class='warning'><b>[src] bites your neck!</b></span>")
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					if(src.CheckEyewitness(LV, src, 7, FALSE))
						src.adjust_masquerade(-1)
				else
					playsound(src, 'modular_darkpack/modules/blood_drinking/sounds/kiss.ogg', 50, TRUE)
					LV.visible_message("<span class='italics'><b>[src] kisses [LV]!</b></span>", "<span class='userlove'><b>[src] kisses you!</b></span>")
				src.drinksomeblood(LV, TRUE)
