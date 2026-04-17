// This is specifically for shipment NPCs. They won't despawn after ordering.
/mob/living/carbon/human/npc/shipment_worker
	staying = TRUE

/mob/living/carbon/human/npc/shipment_worker/Initialize(mapload)
	. = ..()

	equip_to_slot_if_possible(/obj/item/clothing/head/vampire/blackbag, ITEM_SLOT_HEAD)
	set_handcuffed(new /obj/item/restraints/handcuffs(src))
	var/datum/socialrole/assign_role = pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale)
	AssignSocialRole(assign_role)

/mob/living/carbon/human/npc/shipment_accountant
	staying = TRUE
	bloodquality = BLOOD_QUALITY_HIGH

/mob/living/carbon/human/npc/shipment_buisness/Initialize(mapload)
	. = ..()

	equip_to_slot_if_possible(/obj/item/clothing/head/vampire/blackbag, ITEM_SLOT_HEAD)
	set_handcuffed(new /obj/item/restraints/handcuffs(src))
	var/datum/socialrole/assign_role = pick(/datum/socialrole/richmale, /datum/socialrole/richfemale)
	AssignSocialRole(assign_role)
