/atom/movable/screen/drinkblood
	name = "Drink Blood"
	icon = 'modular_darkpack/modules/blood_drinking/icons/drink_blood_hud.dmi'
	icon_state = "act_bite"

/atom/movable/screen/drinkblood/Click()
	bite()
	. = ..()

/atom/movable/screen/drinkblood/proc/bite()
	if(ishuman(usr))
		var/mob/living/carbon/human/human_user = usr
		human_user.vamp_bite()
