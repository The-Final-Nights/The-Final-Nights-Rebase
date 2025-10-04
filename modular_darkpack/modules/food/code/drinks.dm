//---------DRINKS---------//

/obj/item/reagent_containers/cup/glass/coffee/vampire
	name = "coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "coffee"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	//foodtype = BREAKFAST

/obj/item/reagent_containers/cup/glass/coffee/vampire/robust
	name = "robust coffee"
	icon_state = "coffee-alt"

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire
	name = "beer"
	desc = "Beer."
	icon_state = "beer"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/blue_stripe
	name = "blue stripe"
	desc = "Blue stripe beer, brought to you by King Breweries and Distilleries!"
	icon_state = "beer_blue"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/light = 25, /datum/reagent/toxin/amatoxin = 5)

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/typhon
	name = "Typhon's Beer"
	desc = "A sanguine drink to sate those of vampiric tastes"
	icon_state = "typhon"
//	foodtype = SANGUINE
//	list_reagents = list(/datum/reagent/consumable/ethanol/beer/typhon = 30)

/*
/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/typhon/attack(mob/living/M, mob/user, def_zone)
	. = ..()
	reagents.trans_to(M, gulp_size, transfered_by = user, methods = VAMPIRE)
*/

/obj/item/reagent_containers/cup/glass/vampirecola
	name = "two liter cola bottle"
	desc = "Coca cola espuma..."
	icon_state = "colared"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/space_cola = 100)
	volume = 100
	age_restricted = FALSE

/obj/item/reagent_containers/cup/glass/vampirecola/blue
	desc = "Pep Cola. Put some pep in your step"
	list_reagents = list(/datum/reagent/consumable/space_up = 100)
	icon_state = "colablue"

/obj/item/reagent_containers/cup/glass/vampirewater
	name = "water bottle"
	desc = "H2O."
	icon_state = "water1"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	isGlass = FALSE
	list_reagents = list(/datum/reagent/water = 50)
	age_restricted = FALSE

/obj/item/reagent_containers/cup/soda_cans/vampirecola
	name = "cola"
	desc = "Coca cola espuma..."
	icon_state = "colared2"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/space_cola = 30)

/obj/item/reagent_containers/cup/soda_cans/vampirecola/blue
	desc = "Pep cola. Put some Pep in your step"
	icon_state = "colablue2"
	list_reagents = list(/datum/reagent/consumable/space_up = 30)

/obj/item/reagent_containers/cup/soda_cans/vampiresoda
	name = "soda"
	desc = "More water..."
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/sodawater = 30)

/obj/item/reagent_containers/cup/soda_cans/summer_thaw
	name = "summer thaw"
	desc = "A refreshing drink. Brought to you by King Breweries and Distilleries!"
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/space_cola = 20, /datum/reagent/medicine/muscle_stimulant = 5, /datum/reagent/toxin/amatoxin = 5)

/obj/item/reagent_containers/cup/soda_cans/thaw_club
	name = "thaw club soda"
	desc = "For your energy needs. Brought to you by King Breweries and Distilleries!"
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/monkey_energy = 30)

/obj/item/reagent_containers/condiment/milk
	name = "milk"
	desc = "More milk..."
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

/obj/item/reagent_containers/condiment/milk/malk
	desc = "a carton of fish-brand milk, a subsidary of malk incorporated."

/obj/item/reagent_containers/glass/mixing_bowl
	name = "mixing bowl"
	desc = "A mixing bowl. It can hold up to 50 units. Perfect for cooking"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	icon_state = "mixingbowl"
	custom_materials = list(/datum/material/glass=500)
