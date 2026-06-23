GLOBAL_VAR_INIT(police_crime_reporting_cooldown, 0)

/obj/machinery/radio_tranceiver/police
	var/turf/crime_nav_location = null
	var/crime_type = ""

/obj/machinery/radio_tranceiver/police/crime_reported(datum/source, crime, turf/location, suspect_desc)
	var/area/vtm/crime_area = astype(get_area(location))
	if(!crime_area || crime_area.zone_type != ZONE_MASQUERADE)
		return
	if(istype(crime_area, /area/vtm/interior/clinic))
		return
	if(crime == CRIME_EMERGENCY)
		return ..()
	if(!COOLDOWN_FINISHED(GLOB, police_crime_reporting_cooldown))
		return
	COOLDOWN_START(GLOB, police_crime_reporting_cooldown, 4 SECONDS)
	crime_nav_location = location
	crime_type = crime
	var/gps = "<a href='byond://?src=[REF(src)];navigate_to=1'>\[GPS\]</a>"
	var/description = suspect_desc ? "Suspect last seen wearing [suspect_desc]. " : ""
	switch(crime)
		if(CRIME_GUNSHOTS)
			radio.talk_into(radio, "Active gunshots have been reported [pick("at", "in the area of", "near")] [get_area_name(location, TRUE)]. [description][gps]", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_FIREFIGHT)
			radio.talk_into(radio, "An active firefight in progress has been reported [pick("at", "in the area of", "near")] [get_area_name(location, TRUE)]. [description][gps]", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_MURDER)
			radio.talk_into(radio, "An unresponsive person has been reported [pick("at", "in the area of", "near")] [get_area_name(location, TRUE)]. [gps]", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_BURGLARY)
			radio.talk_into(radio, "A burglary has been reported [pick("at", "in the area of", "near")] [get_area_name(location, TRUE)]. [gps]", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_ATM_TAMPERING)
			radio.talk_into(radio, "An ATM was tampered with [pick("at", "in the area of", "near")] [get_area_name(location, TRUE)]. [gps]", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_BATTERY)
			radio.talk_into(radio, "An assault has been reported [pick("at", "in the area of", "near")] [get_area_name(location, TRUE)]. [description][gps]", FREQ_POLICE, list(SPAN_ROBOT))

/obj/machinery/radio_tranceiver/police/Topic(href, href_list)
	if(href_list["navigate_to"])
		var/mob/living/carbon/human/clicker = usr
		if(HAS_TRAIT(clicker, TRAIT_INCAPACITATED) || !crime_nav_location)
			return
		var/atom/movable/screen/alert/police_gps/alert = clicker.throw_alert("police_gps", /atom/movable/screen/alert/police_gps)
		if(alert)
			alert.tracking_target = crime_nav_location
			alert.crime_label = crime_type
			alert.name = "GPS: [crime_type]"
		balloon_alert(clicker, "gps updated")
	return ..()
