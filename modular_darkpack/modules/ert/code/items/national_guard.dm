/obj/item/clothing/mask/gas/darkpack_ert/guard_mask
	name = "\improper Military Gas Mask"
	desc = "A close-fitting tactical gas mask designed to protect against biological hazards and public accountability."
	icon_state = "gas_tactical"

/obj/item/clothing/head/vampire/darkpack_ert/guard_helmet
	name = "\improper National Guard Helmet"
	desc = "Standard issue C.A.N.G helmet modified for riot supression. Provides superior protection against blunt force." //California Army National Guard
	icon_state = "tactical"
	flags_inv = HIDEEARS|HIDEHAIR
	armor_type = /datum/armor/army_helmet
	masquerade_violating = TRUE

/obj/item/clothing/suit/vampire/darkpack_ert/guard_vest
	name = "\improper National Guard Vest"
	desc = "Standard issue C.A.N.G vest modified for riot supression. Provides great protection against blunt force."
	icon_state = "tactical_vest"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/highly_protective_vest
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
