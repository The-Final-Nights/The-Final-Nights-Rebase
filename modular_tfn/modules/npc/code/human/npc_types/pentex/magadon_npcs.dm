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

/mob/living/carbon/human/npc/magadonpharmacist
	staying = TRUE

/mob/living/carbon/human/npc/magadonpharmacist/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/magadonpharmacist)

/mob/living/carbon/human/npc/bouncer/magadon
	our_role = /datum/socialrole/bouncer/magadon
	protected_zone_id = "endron"

/mob/living/carbon/human/npc/bouncer/magadon/magadon_2
	our_role = /datum/socialrole/bouncer/magadon/magadon_2
	protected_zone_id = "endron_2"

/mob/living/carbon/human/npc/bouncer/magadon/magadon_backdoor
	protected_zone_id = "endron_backdoor"

/mob/living/carbon/human/npc/bouncer/magadon/magadon_lab
	our_role = /datum/socialrole/bouncer/magadon/magadon_lab
	protected_zone_id = "endron_lab"

/mob/living/carbon/human/npc/bouncer/magadon/magadon_lab_2
	our_role = /datum/socialrole/bouncer/magadon/magadon_lab_2
	protected_zone_id = "endron_lab_2"
