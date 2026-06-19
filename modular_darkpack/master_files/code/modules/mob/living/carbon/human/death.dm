/mob/living/carbon/human/death(gibbed)
	var/death_turf = get_turf(src) // TFN ADDITION
	. = ..()
	if(!.)
		return .
	// TFN EDIT START
	var/witnessed = FALSE // only report someone they actually saw die, to prevent infinite reporting of corpses
	var/area/vtm/crime_area = astype(get_area(src))
	if(!crime_area || crime_area.zone_type != ZONE_MASQUERADE)
		return
	for(var/mob/living/carbon/human/npc/nearby_npcs in oviewers(DEFAULT_SIGHT_DISTANCE, src))
		witnessed = TRUE
		break
	if(witnessed) // jump straight to sending the report to punish murders in masquerade zones in front of witnesses
		addtimer(CALLBACK(src, PROC_REF(report_murder_to_police), death_turf), rand(5 SECONDS, 20 SECONDS))
	// TFN EDIT END
	GLOB.masquerade_breakers_list -= src
	GLOB.sabbatites -= src
	last_death_info = new()
	last_death_info.record_death(src)


// Not an override. Usecases will be spread out across modules so it goes here.
/datum/death_report
	var/area
	var/last_words
	var/last_attacker_name
	var/suicide

/datum/death_report/proc/record_death(mob/living/carbon/human/dead_guy)
	area = get_area(dead_guy)
	last_attacker_name = dead_guy.lastattacker
	last_words = dead_guy.last_words
	suicide = HAS_TRAIT(dead_guy, TRAIT_SUICIDED)

// TFN EDIT START
/mob/living/carbon/human/proc/report_murder_to_police(turf/death_turf)
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_MURDER, death_turf)
// TFN EDIT END
