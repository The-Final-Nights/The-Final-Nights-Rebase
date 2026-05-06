/mob/living/carbon/human/npc/magadonsecurity
	staying = TRUE
	max_stat = 4
	my_weapon_type = /obj/item/gun/ballistic/automatic/darkpack/mp5
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/magadonsecurity/Initialize()
	. = ..()
	AssignSocialRole(/datum/socialrole/magadonsecurity)

/mob/living/carbon/human/npc/magadonlabsecurity
	staying = TRUE

	max_stat = 4
	my_weapon_type = /obj/item/gun/ballistic/automatic/darkpack/mp5
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/magadonlabsecurity/Initialize()
	. = ..()
	AssignSocialRole(/datum/socialrole/magadonlabsecurity)

/mob/living/carbon/human/npc/magadonexecsecurity
	staying = TRUE

	max_stat = 4
	my_weapon_type = /obj/item/gun/ballistic/automatic/pistol/darkpack/deagle
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/magadonexecsecurity/Initialize()
	. = ..()
	AssignSocialRole(/datum/socialrole/magadonexecsecurity)
