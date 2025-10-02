/mob/living/basic/pet/cat/darkpack
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	var/random_cat_color = TRUE

/mob/living/basic/pet/cat/darkpack/Initialize(mapload)
	. = ..()
	if(random_cat_color)
		var/id = rand(3, 9)
		icon_state = "cat[id]"
		icon_living = "cat[id]"
		icon_dead = "cat[id]_dead"


/mob/living/basic/pet/cat/darkpack/tzi
	name = "Gene"
	bloodpool = 5
	maxbloodpool = 5
	random_cat_color = FALSE
	icon_state = "cat_tzi"
	icon_living = "cat_tzi"
	icon_dead = "cat_tzi_dead"
