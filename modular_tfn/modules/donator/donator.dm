/datum/preferences
	var/donator_rank = 0

/datum/preferences/proc/set_donator_rank(rank_string)
	switch(rank_string)
		if("Fledgling")
			donator_rank = DONATOR_FLEDGLING
		if("Ancilla")
			donator_rank = DONATOR_ANCILLA
		if("Elder")
			donator_rank = DONATOR_ELDER
		if("Antediluvian")
			donator_rank = DONATOR_ANTEDILUVIAN
		if("Caine")
			donator_rank = DONATOR_CAINE

/datum/preferences/proc/donator_rank_to_string(rank)
	switch(rank)
		if(DONATOR_FLEDGLING)
			return "Fledgling"
		if(DONATOR_ANCILLA)
			return "Ancilla"
		if(DONATOR_ELDER)
			return "Elder"
		if(DONATOR_ANTEDILUVIAN)
			return "Antediluvian"
		if(DONATOR_CAINE)
			return "Caine"

// DONATOR LOADOUT
/datum/loadout_category/donator/general
	category_name = "Fledgeling"
	category_ui_icon = FA_ICON_DOG
	category_info = "For Fledgeling tier donators and above! Thanks for your support!"
	type_to_generate = /datum/loadout_item/donator/general
	tab_order = /datum/loadout_category/head::tab_order
	donator_tier_required = DONATOR_FLEDGLING
	VAR_PRIVATE/max_allowed = 3 // how many they can pick from this category

/datum/loadout_item/donator
	abstract_type = /datum/loadout_item/donator
	donator_tier_required = DONATOR_FLEDGLING // the base level

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

/datum/loadout_category/donator/pets
	category_name = "Ancilla"
	category_ui_icon = FA_ICON_CAT
	category_info = "For Ancilla tier donators and above! Thanks for your support!"
	type_to_generate = /datum/loadout_item/donator/pets
	tab_order = /datum/loadout_category/head::tab_order
	VAR_PRIVATE/max_allowed = 3
	donator_tier_required = DONATOR_ANCILLA

/datum/loadout_item/donator/pets/pet_crate
	name = "Pet Crate"
	item_path = /obj/item/donator/pet_crate
	donator_tier_required = DONATOR_ANCILLA

// overrides
/obj/item/toy/crayon/spraycan/infinite/use_on(atom/target, mob/user, list/modifiers)
	if(!user.client?.prefs?.donator_rank)
		to_chat(user, span_notice("You must be a verified donator to use this item! If you have just donated, please run the ?verifydonator command in Discord and try again."))
		return
	. = ..()

/obj/item/clothing/neck/petcollar
	var/tagdesc = null

/obj/item/clothing/neck/petcollar/attack_self(mob/user)
	tagname = tgui_input_text(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	tagdesc = tgui_input_text(user, "Would you like to change the pet's examine description?", "Set custom examine text", "A fluffy little guy with a wet nose.", MAX_FLAVOR_LEN)
	to_chat(user, span_notice("You change the name on the collar to '[tagname]' which will also apply the examine description: \n '[tagdesc]'."))

/datum/element/wears_collar/on_content_enter(mob/living/source, obj/item/clothing/neck/petcollar/new_collar)
	. = ..()
	if(new_collar.tagdesc)
		source.desc = "[new_collar.tagdesc]"

