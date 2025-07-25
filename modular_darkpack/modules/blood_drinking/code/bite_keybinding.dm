/datum/keybinding/human/bite
	hotkey_keys = list("F")
	name = "bite"
	full_name = "Bite"
	description = "Bite whoever you're aggressively grabbing, and feed on them if possible."
	keybind_signal = COMSIG_KB_HUMAN_BITE_DOWN

/datum/keybinding/human/bite/down(client/user)
	. = ..()
	if(.)
		return
	//the code below is directly imported from onyxcombat.dm's /atom/movable/screen/drinkblood/Click() proc
	//turning all of this into one centralised proc would be preferable, but it requires more effort than I'm willing to put in right now
	if(ishuman(user.mob))
		var/mob/living/carbon/human/BD = user.mob
		BD.update_blood_hud()
		if(world.time < BD.last_drinkblood_use+30)
			return
		if(world.time < BD.last_drinkblood_click+10)
			return
		BD.last_drinkblood_click = world.time
//		if(BD.bloodpool >= BD.maxbloodpool)
//			SEND_SOUND(BD, sound('code/modules/wod13/need_blood.ogg'))
//			to_chat(BD, span_warning("You're full of <b>BLOOD</b>."))
//			return
		if(BD.grab_state > GRAB_PASSIVE)
			if(ishuman(BD.pulling))
				var/mob/living/carbon/human/PB = BD.pulling
				if(isghoul(user.mob))
					if(!iskindred(PB))
						SEND_SOUND(BD, sound('modular_darkpack/modules/deprecated/sounds/need_blood.ogg', 0, 0, 75))
						to_chat(BD, span_warning("Eww, that is <b>GROSS</b>."))
						return
				if(!isghoul(user.mob) && !iskindred(user.mob) && !iscathayan(user.mob))
					SEND_SOUND(BD, sound('modular_darkpack/modules/deprecated/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, span_warning("Eww, that is <b>GROSS</b>."))
					return
				if(PB.stat == DEAD && !HAS_TRAIT(BD, TRAIT_GULLET) && !iscathayan(user.mob))
					SEND_SOUND(BD, sound('modular_darkpack/modules/deprecated/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, span_warning("This creature is <b>DEAD</b>."))
					return
				if(PB.bloodpool <= 0 && (!iskindred(BD.pulling) || !iskindred(BD)))
					SEND_SOUND(BD, sound('modular_darkpack/modules/deprecated/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, span_warning("There is no <b>BLOOD</b> in this creature."))
					return
				var/special_clan = FALSE
				if (HAS_TRAIT(BD, TRAIT_CONSENSUAL_FEEDING_ONLY))
					if(!PB.IsSleeping() && PB.stat != DEAD)
						to_chat(BD, span_warning("You can't drink from aware targets!"))
						return
					special_clan = TRUE
					PB.emote("moan")
				if(HAS_TRAIT(BD, TRAIT_PAINFUL_VAMPIRE_KISS))
					PB.emote("scream")
					special_clan = TRUE
				if(!special_clan)
					PB.emote("groan")
				PB.add_bite_animation()
			if(isliving(BD.pulling))
				if(!iskindred(BD) && !iscathayan(BD))
					SEND_SOUND(BD, sound('modular_darkpack/modules/deprecated/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, span_warning("Eww, that is <b>GROSS</b>."))
					return
				var/mob/living/LV = BD.pulling
				if(LV.bloodpool <= 0 && (!iskindred(BD.pulling) || !iskindred(BD)))
					SEND_SOUND(BD, sound('modular_darkpack/modules/deprecated/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, span_warning("There is no <b>BLOOD</b> in this creature."))
					return
				if(LV.stat == DEAD && !HAS_TRAIT(BD, TRAIT_GULLET) && !iscathayan(user.mob))
					SEND_SOUND(BD, sound('modular_darkpack/modules/deprecated/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, span_warning("This creature is <b>DEAD</b>."))
					return
				var/skipface = (BD.wear_mask && (BD.wear_mask.flags_inv & HIDEFACE)) || (BD.head && (BD.head.flags_inv & HIDEFACE))
				if(!skipface)
					if(!HAS_TRAIT(BD, TRAIT_BLOODY_LOVER))
						playsound(BD, 'modular_darkpack/modules/deprecated/sounds/drinkblood1.ogg', 50, TRUE)
						LV.visible_message(span_warning("<b>[BD] bites [LV]'s neck!</b>"), span_warning("<b>[BD] bites your neck!</b>"))
					if(!HAS_TRAIT(BD, TRAIT_BLOODY_LOVER))
						if(BD.CheckEyewitness(LV, BD, 7, FALSE))
							BD.AdjustMasquerade(-1)
					else
						playsound(BD, 'modular_darkpack/modules/deprecated/sounds/kiss.ogg', 50, TRUE)
						LV.visible_message(span_italics("<b>[BD] kisses [LV]!</b>"), span_userlove("<b>[BD] kisses you!</b>"))
					if(iskindred(LV))
						var/mob/living/carbon/human/HV = BD.pulling
						if(HV.stakeimmune)
							to_chat(BD, span_warning("There is no <b>HEART</b> in this creature."))
							return
					BD.drinksomeblood(LV)
	return TRUE
