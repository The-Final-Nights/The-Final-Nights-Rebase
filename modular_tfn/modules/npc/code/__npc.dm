/mob/living/carbon/human/npc/handle_attacked(datum/source, atom/attacker, attack_flags)
	if(attack_flags & (ATTACKER_STAMINA_ATTACK|ATTACKER_SHOVING))
		return
	for(var/mob/living/carbon/human/npc/nearby_npcs in oviewers(DEFAULT_SIGHT_DISTANCE, src))
		nearby_npcs.Aggro(attacker)
	Aggro(attacker, TRUE)

/mob/living/carbon/human/npc/Aggro(mob/living/victim, attacked = FALSE)
	. = ..()
	if(attacked)
		return
	if(aggressive)
		return
	INVOKE_ASYNC(src, PROC_REF(call_911), victim)

/mob/living/carbon/human/npc/proc/call_911(atom/attacker)
	var/area/vtm/crime_area = astype(get_area(src))
	if(!crime_area || crime_area.zone_type != ZONE_MASQUERADE)
		return
	if(prob(20)) // some RNG to if they call or not
		return
	if(!istype(l_store, /obj/item/smartphone) && !istype(r_store, /obj/item/smartphone))
		return
	if(HAS_TRAIT(src, TRAIT_INCAPACITATED) || HAS_TRAIT(src, TRAIT_RESTRAINED))
		return
	var/turf/crime_turf = get_turf(src)
	var/crime = CRIME_BATTERY
	var/clothing_desc = null
	if(istype(attacker, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = attacker
		if(istype(H.get_active_held_item(), /obj/item/gun) || istype(H.get_inactive_held_item(), /obj/item/gun))
			crime = CRIME_FIREFIGHT
		var/list/worn = list()
		if(H.head) worn += H.head
		if(H.wear_suit) worn += H.wear_suit
		if(H.w_uniform) worn += H.w_uniform
		if(H.shoes) worn += H.shoes
		if(length(worn))
			clothing_desc = pick(worn):name
	GLOB.move_manager.stop_looping(src)
	var/saved_danger = danger_source
	danger_source = null
	manual_emote("takes out [p_their()] phone and starts dialing 911!")
	staying = TRUE
	if(!do_after(src, 5 SECONDS, target = src, icon = 'modular_darkpack/modules/phones/icons/phone.dmi', iconstate = "phone"))
		staying = FALSE
		if(saved_danger)
			danger_source = saved_danger
		return
	if(clothing_desc)
		realistic_say("[pick("Police!", "Hello, police?!")] [pick(pick(socialrole.help_phrases), "Wearing [clothing_desc]!")]")
	else
		realistic_say("[pick("Police!", "Hello, police?!")] [pick(socialrole.help_phrases)]")
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, crime, crime_turf, clothing_desc)
	staying = FALSE
