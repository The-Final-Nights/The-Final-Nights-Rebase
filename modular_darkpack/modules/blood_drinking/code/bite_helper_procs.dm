//Wrapper function for adjusting a kindred/ghoul's blood pool
/mob/living/proc/adjustBloodPool(blood_delta, on_spawn = FALSE)
	if(on_spawn)
		bloodpool = 0
	bloodpool = clamp(bloodpool+blood_delta, 0, maxbloodpool)

//runs a bite animation for biting people and biting people and biting p
/mob/living/carbon/human/proc/add_bite_animation()
	remove_overlay(HALO_LAYER)
	var/mutable_appearance/bite_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "bite", -HALO_LAYER)
	overlays_standing[HALO_LAYER] = bite_overlay
	apply_overlay(HALO_LAYER)
	addtimer(CALLBACK(src, PROC_REF(clear_bite_animation_overlay)), 1.5 SECONDS)

/mob/living/carbon/human/proc/clear_bite_animation_overlay()
	if(src)
		remove_overlay(HALO_LAYER)


//Here is where you handle any circumstantial modifiers to bloodpool gains
//VTR has a lot of these.
/mob/living/carbon/human/proc/calculate_drink_modifier(var/mob/living/mob)
	var/drink_mod = 1
	if(HAS_TRAIT(src, TRAIT_HUNGRY))
		drink_mod *= 0.5

	return drink_mod

//Removes the circular suck bar that displays the amount of blood a victim has left.
/mob/living/carbon/human/proc/remove_drinking_overlay()
	stop_sound_channel(CHANNEL_BLOOD)
	COOLDOWN_RESET(src, drinkblood_use_cd)
	if(client)
		client.images -= suckbar
	qdel(suckbar)
	return

//Updates the circular suck bar that displays the amount of blood a victim has left.
/mob/living/carbon/human/proc/update_drinking_overlay(var/mob/living/mob)
	if(client)
		client.images -= suckbar
	qdel(suckbar)
	suckbar_loc = mob
	suckbar = image('modular_darkpack/modules/blood_drinking/icons/bloodcounter.dmi', suckbar_loc, "[round(14*(mob.bloodpool/mob.maxbloodpool))]", HUD_PLANE)
	suckbar.pixel_z = 40
	suckbar.plane = ABOVE_HUD_PLANE
	suckbar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

	if(client)
		client.images += suckbar
	var/sound/heartbeat = sound('modular_darkpack/modules/blood_drinking/sounds/drinkblood2.ogg', repeat = TRUE)
	playsound_local(src, heartbeat, 75, 0, channel = CHANNEL_BLOOD, use_reverb = FALSE)
