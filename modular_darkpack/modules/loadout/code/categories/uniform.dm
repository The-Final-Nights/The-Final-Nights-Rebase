/datum/loadout_category/uniform
	category_name = "Uniform"
	category_ui_icon = FA_ICON_SHIRT
	type_to_generate = /datum/loadout_item/uniform
	tab_order = /datum/loadout_category/head::tab_order + 9

/datum/loadout_item/uniform
	abstract_type = /datum/loadout_item/uniform

/datum/loadout_item/uniform/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(outfit.uniform)
		LAZYADD(outfit.backpack_contents, outfit.uniform)
	outfit.uniform = item_path

/datum/loadout_item/uniform/punk
	name = "Punk attire"
	item_path = /obj/item/clothing/under/vampire/brujah

/datum/loadout_item/uniform/punk_female
	name = "Punk attire (female)"
	item_path = /obj/item/clothing/under/vampire/brujah/female
