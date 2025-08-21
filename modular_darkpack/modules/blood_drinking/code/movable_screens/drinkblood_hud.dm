/atom/movable/screen/drinkblood
	name = "Drink Blood"
	icon = 'modular_darkpack/modules/deprecated/icons/disciplines.dmi'
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/drinkblood/Click()
	bite()
	. = ..()

/atom/movable/screen/drinkblood/proc/bite()
	if(ishuman(usr))
		var/mob/living/carbon/human/human_user = usr
		human_user.vamp_bite()
