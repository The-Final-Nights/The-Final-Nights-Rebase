GLOBAL_VAR_INIT(police_crime_reporting_cooldown, 0)

/obj/machinery/radio_tranceiver/police/crime_reported(datum/source, crime, turf/location)
	var/area/vtm/crime_area = astype(get_area(location))
	if(!crime_area || crime_area.zone_type != ZONE_MASQUERADE) // prevents sewer rats from reporting deaths
		return
	if(crime != CRIME_EMERGENCY)
		if(!COOLDOWN_FINISHED(GLOB, police_crime_reporting_cooldown))
			return
		COOLDOWN_START(GLOB, police_crime_reporting_cooldown, 5 SECONDS)
	return ..()
