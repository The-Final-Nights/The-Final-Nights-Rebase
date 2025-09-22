/obj/item/reagent_containers/cup/glass/meth
	name = "blue package"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "package_meth"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	list_reagents = list(/datum/reagent/drug/methamphetamine = 30)
	spillable = FALSE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST

/obj/item/reagent_containers/cup/glass/meth/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 300, "meth", TRUE, -1, 4)
