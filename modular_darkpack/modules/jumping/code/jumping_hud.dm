/atom/movable/screen/jump
	name = "jump"
	icon = 'modular_darkpack/modules/deprecated/icons/ui/buttons_wide.dmi'
	icon_state = "act_jump_off"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/jump/Click()
	var/mob/living/L = usr
	if(!L.prepared_to_jump)
		L.prepared_to_jump = TRUE
		icon_state = "act_jump_on"
		to_chat(usr, span_notice("You prepare to jump."))
	else
		L.prepared_to_jump = FALSE
		icon_state = "act_jump_off"
		to_chat(usr, span_notice("You are not prepared to jump anymore."))

	. = ..()
