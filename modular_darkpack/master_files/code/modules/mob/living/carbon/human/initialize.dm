/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	//Initializes Jumping on the player
	AddComponent(/datum/component/jumper)
