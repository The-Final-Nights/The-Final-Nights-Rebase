/atom/movable/screen/jump
	name = "jump"
	icon = 'modular_darkpack/modules/jumping/icons/jumping_icon.dmi'
	icon_state = "act_jump_off"

/atom/movable/screen/jump/Click()
	if(icon_state == "act_jump_off")
		icon_state = "act_jump_on"
	else
		icon_state = "act_jump_off"
	SEND_SIGNAL(usr, COMSIG_LIVING_JUMP_PREP_TOGGLE)
	. = ..()
