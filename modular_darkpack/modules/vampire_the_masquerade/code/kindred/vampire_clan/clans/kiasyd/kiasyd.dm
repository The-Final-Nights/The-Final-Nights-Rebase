/datum/vampire_clan/kiasyd
	name = "Kiasyd"
	id = VAMPIRE_CLAN_KIASYD
	desc = "The Kiasyd are a bloodline of the Lasombra founded after a mysterious \"accident\" involving the Lasombra Marconius of Strasbourg. The \"accident\", involving faeries and the blood of \"Zeernebooch, a god of the Underworld\", resulted in Marconius gaining several feet in height, turning chalky white and developing large, elongated black eyes."
	curse = "At a glance they look unsettling or perturbing to most, their appearance closely resembles fae from old folklore. Kiasyd are also in some way connected with changelings and they are vulnerable to cold iron."
	clan_disciplines = list(
		/datum/discipline/dominate,
		/datum/discipline/obtenebration,
		/datum/discipline/mytherceria
	)
	clan_traits = list(
		TRAIT_MASQUERADE_VIOLATING_EYES
	)
	alt_sprite = "kiasyd"
	no_facial = TRUE
	male_clothes = /obj/item/clothing/under/vampire/archivist
	female_clothes = /obj/item/clothing/under/vampire/archivist
	whitelisted = TRUE
	accessories = list("fae_ears", "none")
	accessories_layers = list("fae_ears" = UPPER_EARS_LAYER, "none" = UPPER_EARS_LAYER)

/datum/vampire_clan/kiasyd/on_gain(mob/living/carbon/human/H)
	. = ..()

	// Kiasyd are made taller and thinner
	if (H.has_quirk(/datum/quirk/dwarf))
		H.remove_quirk(/datum/quirk/dwarf)
	else if (!H.has_quirk(/datum/quirk/tower))
		H.add_quirk(/datum/quirk/tower)

	var/obj/item/organ/eyes/night_vision/kiasyd/NV = new()
	NV.Insert(H, TRUE, FALSE)

	// Add curse component
	H.AddComponent(/datum/component/kiasyd_iron_weakness)

/datum/vampire_clan/kiasyd/on_lose(mob/living/carbon/human/vampire)
	. = ..()

	if (vampire.has_quirk(/datum/quirk/tower))
		vampire.remove_quirk(/datum/quirk/tower)
	else
		vampire.add_quirk(/datum/quirk/dwarf)

	vampire.update_body()

/datum/vampire_clan/kiasyd/on_join_round(mob/living/carbon/human/H)
	. = ..()

	//give them sunglasses to hide their freakish eyes
	var/obj/item/clothing/glasses/vampire/sun/new_glasses = new(H.loc)
	H.equip_to_appropriate_slot(new_glasses, TRUE)

