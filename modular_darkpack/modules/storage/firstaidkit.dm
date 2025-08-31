// Inside is: Standard, Doctor, Advanced, Brute, Burn, Oxygen, Toxins, IFAK & Combat First aid/Medical kits

/obj/item/storage/darkpack/firstaid
	name = "first-aid kit"
	desc = "A first aid kit ideal for handling common, non-life threatening injuries."
	icon_state = "firstaid"
	icon = 'modular_darkpack/modules/storage/icons/firstaidkit.dmi'
	onflooricon = 'modular_darkpack/modules/storage/icons/firstaidkit.dmi'
	lefthand_file = 'modular_darkpack/modules/storage/icons/firstaidkit_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/storage/icons/firstaidkit_righthand.dmi'
	drop_sound = 'sound/items/handling/medkit/medkit_drop.ogg'
	pickup_sound = 'sound/items/handling/medkit/medkit_pick_up.ogg'
	throw_speed = 3
	throw_range = 7
	storage_type = /datum/storage/medkit
	w_class = WEIGHT_CLASS_NORMAL
	var/empty = FALSE

/obj/item/storage/darkpack/firstaid/standard
	name = "first-aid kit"
	desc = "A handheld medical kit ideal for handling common, non-life threatening injuries."

/obj/item/storage/darkpack/firstaid/standard/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/doctor
	name = "doctors kit"
	desc = "A handheld medical suite containing basic medical tools and some surgery equipment."
	icon_state = "firstaid_doctor"
	inhand_icon_state = "firstaid_doctor"
	storage_type = /datum/storage/medkit/darkpack/doctor

/obj/item/storage/darkpack/firstaid/doctor/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/scalpel = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/advanced
	name = "advanced first-aid kit"
	desc = "A handheld medical kit designed for handling advanced injuries."
	icon_state = "firstaid_advanced"
	inhand_icon_state = "firstaid_advanced"

/obj/item/storage/darkpack/firstaid/advanced/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/applicator/patch/synthflesh = 3,
		/obj/item/reagent_containers/hypospray/medipen/atropine = 2,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/storage/pill_bottle/penacid = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/brute
	name = "brute treatment kit"
	desc = "A handheld medical kit ideal for handling someone who has found the front of a moving truck."
	icon_state = "firstaid_brute"
	inhand_icon_state = "firstaid_brute"

/obj/item/storage/darkpack/firstaid/brute/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/applicator/patch/libital = 3,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/storage/pill_bottle/probital = 1,
		/obj/item/reagent_containers/hypospray/medipen/salacid = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/burn
	name = "burn treatment kit"
	desc = "A handheld medical kit ideal for handling someone who has fought fire."
	icon_state = "firstaid_burn"
	inhand_icon_state = "firstaid_burn"

/obj/item/storage/darkpack/firstaid/burn/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/applicator/patch/aiuri = 3,
		/obj/item/reagent_containers/spray/hercuri = 1,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/oxy
	name = "o2 treatment kit"
	desc = "A handheld medical kit ideal for handling someone who has been left breathless."
	icon_state = "firstaid_oxy"
	inhand_icon_state = "firstaid_oxy"

/obj/item/storage/darkpack/firstaid/oxy/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/applicator/patch/aiuri = 3,
		/obj/item/reagent_containers/spray/hercuri = 1,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/tox
	name = "toxin treatment kit"
	desc = "A handheld medical kit ideal for handling someone who has fallen into a vat of radioactive goop."
	icon_state = "firstaid_tox"
	inhand_icon_state = "firstaid_tox"

/obj/item/storage/darkpack/firstaid/tox/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/storage/pill_bottle/multiver/less = 1,
		/obj/item/reagent_containers/syringe/syriniver = 3,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/ifak
	name = "IFAK"
	desc = "An Individual First-Aid Kit, for when it's just you and me."
	icon_state = "firstaid_ifak"
	inhand_icon_state = "firstaid_ifak"

/obj/item/storage/darkpack/firstaid/ifak/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/medipen/ifak = 3,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/healthanalyzer = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/darkpack/firstaid/combat
	name = "combat medical kit"
	desc = "A medical suite designed for when you need your strongest potions to take into battle."
	icon_state = "firstaid_combat"
	inhand_icon_state = "firstaid_combat"
	storage_type = /datum/storage/medkit/darkpack/combat

/obj/item/storage/darkpack/firstaid/combat/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze,
		/obj/item/defibrillator/compact/combat/loaded,
		/obj/item/reagent_containers/hypospray/combat,
		/obj/item/reagent_containers/applicator/patch/libital = 2,
		/obj/item/reagent_containers/applicator/patch/aiuri = 2,
		/obj/item/clothing/glasses/hud/health/night)
	generate_items_inside(items_inside,src)


/datum/storage/medkit/darkpack/doctor/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
    holdables = list_of_everything_medkits_can_hold
    return ..()

/datum/storage/medkit/darkpack/combat/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
    holdables = list_of_everything_medkits_can_hold
    return ..()
