/mob/living/carbon/human/npc/police
	aggressive = TRUE
	max_stat = DEAD
	// TODO: [Lucia] reimplement weapons
	/*
	my_backup_weapon_type = /obj/item/melee/baton/vamp
	*/

/mob/living/carbon/human/npc/police/Initialize(mapload)
	. = ..()

	if (prob(66))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/police)

/mob/living/carbon/human/npc/police/Life()
	. = ..()

	if (stat >= SOFT_CRIT)
		return
	if (!prob(10))
		return

	INVOKE_ASYNC(src, PROC_REF(check_for_criminals))

/mob/living/carbon/human/npc/police/proc/check_for_criminals()
	for (var/mob/living/carbon/human/H in oviewers(4, src))
		if (!H.warrant)
			continue

		Aggro(H, FALSE)
