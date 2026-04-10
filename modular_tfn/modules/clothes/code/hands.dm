/obj/item/clothing/gloves/vampire/tfn
	icon = 'modular_tfn/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_tfn/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_tfn/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/gloves/vampire/tfn/brassknuckles
	name = "brass knuckles"
	desc = "A set of tarnished brass rings fused together to create a cruel weapon for back-alley brawls. Illegal in most places."
	icon_state = "brassknuckles"
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/brassknuckles

/datum/armor/brassknuckles
	acid = 50

/obj/item/clothing/gloves/vampire/tfn/brassknuckles/equipped(mob/living/carbon/human/user, slot)
	..()
	if(ishuman(user) && slot == ITEM_SLOT_GLOVES)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_damage_low += 10
				limb.unarmed_damage_high += 10
				limb.unarmed_effectiveness += 5
				limb.unarmed_pummeling_bonus += 0.5
				to_chat(user, span_notice("You fit your fingers into the brass knuckle's loops.."))

/obj/item/clothing/gloves/vampire/tfn/brassknuckles/dropped(mob/living/carbon/human/user, slot)
	..()
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_damage_low -= 10
				limb.unarmed_damage_high -= 10
				limb.unarmed_effectiveness -= 5
				limb.unarmed_pummeling_bonus -= 0.5
				to_chat(user, span_notice("You take off the brass knuckles.."))

/obj/item/clothing/gloves/vampire/tfn/brassknuckles/spiked
	name = "spiked steel knuckles"
	desc = "A set of tarnished steel rings fused together and topped with piercing metal spikes. Illegal in most places."
	icon_state = "spikedknuckles"

/obj/item/clothing/gloves/vampire/tfn/brassknuckles/spiked/equipped(mob/living/carbon/human/user, slot)
	..()
	if(ishuman(user) && slot == ITEM_SLOT_GLOVES)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_sharpness = SHARP_POINTY

/obj/item/clothing/gloves/vampire/tfn/brassknuckles/spiked/dropped(mob/living/carbon/human/user, slot)
	..()
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_sharpness = initial(limb.unarmed_sharpness)
