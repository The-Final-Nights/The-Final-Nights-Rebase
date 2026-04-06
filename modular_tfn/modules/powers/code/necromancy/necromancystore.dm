/mob/living/basic/corpsestore
	name = "corpsestore"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "bat_dead"
	bloodquality = BLOOD_QUALITY_LOW
	maxHealth = 1
	health = 1

/mob/living/basic/corpsestore/corpse1
	name = "bat corpse"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "bat_dead"
	maxHealth = 15
	health = 1
	stat = DEAD

/mob/living/basic/corpsestore/corpse2
	name = "dog corpse"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "dog_dead"
	maxHealth = 30
	health = 1
	stat = DEAD

/mob/living/basic/corpsestore/corpse3
	name = "bone pile"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "skeleton_dead"
	maxHealth = 50
	health = 1
	stat = DEAD

/mob/living/basic/corpsestore/corpse4
	name = "bear corpse"
	icon = 'modular_darkpack/modules/npc/icons/bear.dmi'
	icon_state = "bear_dead"
	maxHealth = 500
	health = 1
	stat = DEAD

/obj/item/corpsestore
	name = "corpsestore"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "legion_skull"

/obj/item/corspestore/skull
	name = "empty skull"
	desc = "A skull, empty and void of life."
	icon = 'modular_tfn/modules/powers/code/necromancy/flameskull.dmi'
	icon_state = "legion_skull"

/obj/item/coin/oboli
	name = "Oboli"
	desc = "A coin made from a strange gray metal like iron. It's cold to the touch, about 4 inches in diameter, and has a marking of a ferryman on a boat."
	icon = 'icons/obj/economy.dmi'
	icon_state = "coin"
	color = "#808080"
	force = 1
	throwforce = 2
	material_flags = NONE
	w_class = WEIGHT_CLASS_TINY

/obj/item/coin/oboli/Initialize()
	. = ..()
	coinflip = pick(sideslist)
	icon_state = "coin_[coinflip]"
	pixel_x = base_pixel_x + rand(0, 16) - 8
	pixel_y = base_pixel_y + rand(0, 8) - 8
	AddComponent(/datum/component/selling, 300, "Oboli", TRUE, -1, 4)
