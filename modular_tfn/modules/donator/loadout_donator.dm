// DONATOR LOADOUT
/datum/loadout_category/donator
	var/max_allowed = 6

/datum/loadout_category/donator/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/category_items = list()
	for(var/datum/loadout_item/donator/item in all_loadout_items)
		if(istype(item, type_to_generate))
			category_items += item

	if(length(category_items) >= max_allowed)
		manager.deselect_item(category_items[1])
	return TRUE

/datum/loadout_category/donator/general
	category_name = "Fledgeling"
	category_ui_icon = FA_ICON_DOG
	category_info = "For Fledgeling tier donators and above! Thanks for your support!"
	type_to_generate = /datum/loadout_item/donator/general
	tab_order = /datum/loadout_category/head::tab_order
	donator_tier_required = DONATOR_FLEDGLING

/datum/loadout_item/donator
	abstract_type = /datum/loadout_item/donator
	donator_tier_required = DONATOR_FLEDGLING // the base level

// fledgeling
/datum/loadout_item/donator/general
	group = "General"
	abstract_type = /datum/loadout_item/donator/general

/datum/loadout_item/donator/general/skateboard
	name = "Skateboard"
	item_path = /obj/item/melee/skateboard/pro
	loadout_flags = LOADOUT_FLAG_ALLOW_NAMING

/datum/loadout_item/donator/general/scooter
	name = "Scooter (Kit)"
	item_path = /obj/item/donator/box/scooter_box

/datum/loadout_item/donator/general/infinite_spraycan
	name = "Extended Capacity Spray Can"
	item_path = /obj/item/toy/crayon/spraycan/infinite

/datum/loadout_item/donator/general/plush
	group = "Plushies"
	abstract_type = /datum/loadout_item/donator/general/plush
	loadout_flags = LOADOUT_FLAG_ALLOW_NAMING

/datum/loadout_item/donator/general/plush/bee
	name = "Plush (Bee)"
	item_path = /obj/item/toy/plush/beeplushie

/datum/loadout_item/donator/general/plush/carp
	name = "Plush (Carp)"
	item_path = /obj/item/toy/plush/carpplushie

/datum/loadout_item/donator/general/plush/lizard_greyscale
	name = "Plush (Lizard, Colorable)"
	item_path = /obj/item/toy/plush/lizard_plushie/greyscale

/datum/loadout_item/donator/general/plush/lizard_random
	name = "Plush (Lizard, Random)"
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING
	ui_icon = 'icons/obj/fluff/previews.dmi'
	ui_icon_state = "plushie_lizard_random"
	item_path = /obj/item/toy/plush/lizard_plushie

/datum/loadout_item/donator/general/plush/moth
	name = "Plush (Moth)"
	item_path = /obj/item/toy/plush/moth

/datum/loadout_item/donator/general/plush/nukie
	name = "Plush (Nukie)"
	item_path = /obj/item/toy/plush/nukeplushie

/datum/loadout_item/donator/general/plush/peacekeeper
	name = "Plush (Peacekeeper)"
	item_path = /obj/item/toy/plush/pkplush

/datum/loadout_item/donator/general/plush/plasmaman
	name = "Plush (Plasmaman)"
	item_path = /obj/item/toy/plush/plasmamanplushie

/datum/loadout_item/donator/general/plush/human
	name = "Plush (human)"
	item_path = /obj/item/toy/plush/human

/datum/loadout_item/donator/general/plush/rouny
	name = "Plush (Rouny)"
	item_path = /obj/item/toy/plush/rouny

/datum/loadout_item/donator/general/plush/snake
	name = "Plush (Snake)"
	item_path = /obj/item/toy/plush/snakeplushie

/datum/loadout_item/donator/general/plush/horse
	name = "Plush (Horse)"
	item_path = /obj/item/toy/plush/horse

/datum/loadout_item/donator/general/plush/shark
	name = "Plush (Blahaj)"
	item_path = /obj/item/toy/plush/shark

// ancilla
/datum/loadout_category/donator/ancilla
	category_name = "Ancilla"
	category_ui_icon = FA_ICON_CAT
	category_info = "For Ancilla tier donators and above! Thanks for your support!"
	type_to_generate = /datum/loadout_item/donator/ancilla
	tab_order = /datum/loadout_category/head::tab_order
	max_allowed = 3
	donator_tier_required = DONATOR_ANCILLA

/datum/loadout_item/donator/ancilla
	abstract_type = /datum/loadout_item/donator/ancilla
	donator_tier_required = DONATOR_ANCILLA

/datum/loadout_item/donator/ancilla/pet_crate
	name = "Pet Crate"
	item_path = /obj/item/donator/pet_crate
	donator_tier_required = DONATOR_ANCILLA
