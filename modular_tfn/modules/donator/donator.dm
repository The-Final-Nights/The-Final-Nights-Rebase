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
	save_preferences()

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

// items
/obj/item/donator/box
	name = "box"
	desc = "What's in the box?!"
	icon_state = "box"
	icon = 'modular_darkpack/modules/cargo/icons/box.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/donator/box/scooter_box
	name = "scooter assembly kit"

/obj/item/donator/box/scooter_box/attack_self(mob/user, modifiers)
	var/location = get_turf(src)
	visible_message(span_warning("\The [src] springs open!"))
	new /obj/vehicle/ridden/scooter(location)
	qdel(src)
	return TRUE

// item overrides
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
	if(!istype(new_collar) || !new_collar.tagdesc)
		return
	source.desc = "[new_collar.tagdesc]"

