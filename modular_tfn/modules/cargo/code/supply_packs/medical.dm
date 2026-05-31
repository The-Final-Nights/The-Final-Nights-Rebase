/datum/supply_pack/medical/chemistry_set
	name = "DIY Chemistry Kit"
	desc = "Contains the necessary equipment for your average basement chemist"
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/obj/structure/chem_separator,
					/obj/machinery/space_heater/improvised_chem_heater,
					/obj/item/reagent_containers/dropper,
					/obj/item/pestle,
					/obj/item/reagent_containers/cup/mortar,
					/obj/item/ph_booklet,
					/obj/item/reagent_containers/cup/bottle/ethanol,
					/obj/item/assembly/igniter/condenser,
					/obj/item/storage/box/beakers
				)
	crate_name = "DIY Chemistry crate"
