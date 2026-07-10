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

/mob/living/carbon/human/npc
	COOLDOWN_DECLARE(call_911_cooldown)
	var/static/list/open_carrying_phrases = list(
		"Is that...?!",
		"Are you carrying a weapon?!",
		"Oh my god, are you carrying a weapon?",
		"Someone needs to call the police, that's crazy.",
		"Just rob a bank or something?",
		"That's illegal, you know.",
		"Open carrying a weapon in 2016 is crazy.",
		"That's a crime, you know.",
		"You should put that weapon away.",
		"Are you crazy? You can't just carry a weapon around like that.",
		"This is California, psycho. Put the weapon away.",
		"In what world is it okay to open carry a weapon like that? Put it away.",
	)

/mob/living/carbon/human/npc/proc/call_911(atom/attacker, open_carrying = FALSE)
	if(!COOLDOWN_FINISHED(src, call_911_cooldown))
		return
	var/area/vtm/crime_area = astype(get_area(src))
	if(!crime_area || crime_area.zone_type != ZONE_MASQUERADE)
		return
	if(prob(20)) // some RNG to if they call or not
		return
	if(!istype(l_store, /obj/item/smartphone) && !istype(r_store, /obj/item/smartphone))
		return
	if(HAS_TRAIT(src, TRAIT_INCAPACITATED) || HAS_TRAIT(src, TRAIT_RESTRAINED) || staying)
		return
	COOLDOWN_START(src, call_911_cooldown, 10 SECONDS)
	var/turf/crime_turf = get_turf(src)
	var/crime = CRIME_BATTERY
	var/clothing_desc = null
	if(istype(attacker, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = attacker
		if(istype(H.get_active_held_item(), /obj/item/gun) || istype(H.get_inactive_held_item(), /obj/item/gun))
			crime = CRIME_FIREFIGHT
		if(open_carrying)
			crime = CRIME_OPEN_CARRYING
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
	var/mob/living/carbon/human/H = astype(attacker, /mob/living/carbon/human)
	if(H)
		H.witnessed_crimes += 1
		addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, remove_crime_stack)), 1 MINUTES)
		if(H.witnessed_crimes >= 10 && !H.warrant)
			H.warrant = TRUE
			SEND_SOUND(H, sound('modular_darkpack/modules/deprecated/sounds/suspect.ogg', volume = 75))
			to_chat(H, span_userdanger("<b>ALL-POINTS BULLETIN ISSUED!</b>"))
			to_chat(H, span_warning("The police are now able to track you down and will pursue you on sight. Lay low for a while and they will eventually stop looking for you."))
		else if(!H.warrant)
			SEND_SOUND(H, sound('modular_darkpack/modules/deprecated/sounds/sus.ogg', volume = 75))
			to_chat(H, span_userdanger("<b>SUSPICIOUS ACTION ([crime])</b>"))
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, crime, crime_turf, clothing_desc)
	staying = FALSE

/obj/item/proc/is_scary_weapon() // NPCs don't like seeing scary weapons
	if(force > 10)
		return TRUE
	var/obj/item/storage/belt/sheath/sword_sheath = astype(src, /obj/item/storage/belt/sheath)
	var/obj/item/gun/ballistic/gun = astype(src, /obj/item/gun/ballistic)
	if(sword_sheath)
		return !isnull(sword_sheath.stored_blade)
	if(gun)
		return !isnull(gun.serial_type) // we check for a serial number so NPCs dont freak out over donksoft foam guns
	return FALSE

/datum/proximity_monitor/advanced/violation_check_aoe/proc/check_criminal_violation(mob/living/carbon/human/entered_mob)
	var/threatcount = 0
	var/datum/job/entered_job = SSjob.get_job(entered_mob?.job)
	if(entered_job?.departments_bitflags & DEPARTMENT_BITFLAG_POLICE)
		return 0 // dont call 911 on the police
	for(var/obj/item/thing in entered_mob?.held_items) //they're holding it!
		if(thing.is_scary_weapon())
			threatcount += 11 // 11 so that if they have 5 charisma and 5 intimidation, they still have a tiny chance of getting snitched on
	if(entered_mob?.belt?.is_scary_weapon() || entered_mob?.back?.is_scary_weapon())
		threatcount += 5 //not an immediate threat, but still a threat
	return threatcount

/datum/proximity_monitor/advanced/violation_check_aoe/on_entered(turf/source, atom/movable/entered, turf/old_loc)
	. = ..()
	var/mob/living/carbon/human/entered_mob = astype(entered, /mob/living/carbon/human)
	var/mob/living/carbon/human/npc/host_mob = astype(host, /mob/living/carbon/human/npc)
	if(!entered_mob || !host_mob || !entered_mob.client || istype(entered_mob, /mob/living/carbon/human/npc))
		return
	var/severity = check_criminal_violation(entered_mob)
	if(!severity)
		return
	var/call_chance = severity - (entered_mob.st_get_stat(STAT_CHARISMA) + entered_mob.st_get_stat(STAT_INTIMIDATION))
	if(prob(call_chance))
		INVOKE_ASYNC(host_mob, TYPE_PROC_REF(/mob/living/carbon/human/npc, call_911), entered_mob, open_carrying = TRUE)
		return // if they call, dont yap after
	if(prob(1)) // if they don't call, the npc might just yap
		host_mob.point_at(entered_mob)
		host_mob.realistic_say(pick(host_mob.open_carrying_phrases))

/mob/living/carbon/human/proc/remove_crime_stack()
	if(QDELETED(src))
		return
	witnessed_crimes = max(0, witnessed_crimes - 1) // each witnessed crime stack lasts 1 minute. police pursue them after 10 stacks.
	if(!warrant)
		return
	to_chat(src, span_warning("(APB) Estimated police search timer: [witnessed_crimes] minutes remaining."))
	if(witnessed_crimes == 0)
		to_chat(src, span_info("(APB) The police call off their search for you. You are no longer wanted."))
		warrant = FALSE
