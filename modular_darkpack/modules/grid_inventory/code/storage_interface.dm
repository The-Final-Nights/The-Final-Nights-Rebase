
///darkpack subtype of storage interface used by us.
/datum/storage_interface/darkpack

	/// Storage that owns us
	var/datum/storage/darkpack/darkpack_parent_storage

/datum/storage_interface/darkpack/New(ui_style, datum/storage/parent_storage, mob/user)
	..()
	darkpack_parent_storage = parent_storage

/datum/storage_interface/darkpack/Destroy(force)
	darkpack_parent_storage = null
	return ..()

/datum/storage_interface/darkpack/add_items(
	screen_start_x,
	screen_pixel_x,
	screen_start_y,
	screen_pixel_y,
	columns,
	rows,
	mob/user_looking,
	atom/real_location,
	list/datum/numbered_display/numbered_contents,
)

	var/turf/our_turf = get_turf(real_location)

	var/list/obj/storage_contents = list()
	if (islist(numbered_contents))
		for(var/content_type in numbered_contents)
			var/datum/numbered_display/numberdisplay = numbered_contents[content_type]
			storage_contents[numberdisplay.sample_object] = MAPTEXT("<font color='white'>[(numberdisplay.number > 1)? "[numberdisplay.number]" : ""]</font>")
	else
		for(var/obj/item as anything in real_location)
			storage_contents[item] = ""

	for(var/obj/item as anything in storage_contents)
		item.mouse_opacity = MOUSE_OPACITY_OPAQUE
		item.maptext = storage_contents[item]
		SET_PLANE(item, ABOVE_HUD_PLANE, our_turf)

