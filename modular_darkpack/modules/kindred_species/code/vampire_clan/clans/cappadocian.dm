/datum/vampire_clan/cappadocian
	name = "Cappadocian"
	id = VAMPIRE_CLAN_CAPPADOCIAN
	desc = "A presumed-to-be-extinct Clan of necromancers, the Cappadocians studied death specifically in the physical world. The Giovanni were Embraced into their line to help further their studies into the underworld. They were rewarded with Diablerie and the destruction of their Clan and founder."
	curse = "Extremely corpselike appearance that worsens with age."
	/*
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/fortitude,
		/datum/discipline/necromancy
	)
	*/
	alt_sprite = "rotten1"
	alt_sprite_greyscale = TRUE

	whitelisted = TRUE

/datum/vampire_clan/cappadocian/on_gain(mob/living/carbon/human/H)
	. = ..()

	var/years_undead = H.chronological_age - H.age
	switch(years_undead)
		if (-INFINITY to 100)
			H.rot_body(1)
		if (100 to 300)
			H.rot_body(2)
		if (300 to 500)
			H.rot_body(3)
		if (500 to INFINITY)
			H.rot_body(4)

/datum/vampire_clan/cappadocian/on_join_round(mob/living/carbon/human/H)
	. = ..()

	// Only old, skeletonised Cappadocians need the robes and mask
	if (!HAS_TRAIT(H, TRAIT_MASQUERADE_VIOLATING_FACE))
		return

	var/obj/item/clothing/suit/hooded/robes/darkred/new_robe = new(H.loc)
	H.equip_to_appropriate_slot(new_robe, FALSE)

	var/obj/item/clothing/mask/vampire/venetian_mask/fancy/new_mask = new(H.loc)
	H.equip_to_appropriate_slot(new_mask, FALSE)

