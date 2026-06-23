/obj/item/intel_report
	name = "intelligence report"
	desc = "A file with information of note on local operations, listing persons of interests."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "docs_part"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/masquerade_contract
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/intel_report/attack_self(mob/user, modifiers)
	. = ..()
	if(issupernatural(user))
		return
	var/turf/current_location = get_turf(user)
	to_chat(user, "[span_bold("YOU")], [get_area_name(user)]")
	for(var/mob/living/breacher in GLOB.supernatural_breakers_list)
		var/turf/turf = get_turf(breacher)
		var/direction = get_dir(current_location, turf)
		var/disttext = dir2text(direction)
		to_chat(user, span_info("[breacher.real_name], [get_area_name(turf)], [disttext]"))

	if(!GLOB.supernatural_breakers_list)
		to_chat(user, span_info("No available freaks of nature in city..."))
