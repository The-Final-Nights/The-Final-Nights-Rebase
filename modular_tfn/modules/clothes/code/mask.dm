/obj/item/clothing/mask/vampire
	// This USED to be the default resperatior for wod13 moved that to /obj/item/clothing/mask/gas/vampire
	abstract_type = /obj/item/clothing/mask/vampire
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE

/obj/item/clothing/mask/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 15, "mask", FALSE)

/obj/item/clothing/mask/gas/vampire/magadon
	name = "magadon gas mask"
	desc = "A high-tech gas mask branded belonging to Magadon Incorporated."
	icon_state = "gas_magadon"
	inhand_icon_state = "gas_magadon"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH | PEPPERPROOF

