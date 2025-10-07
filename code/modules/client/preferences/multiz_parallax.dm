/// Whether or not to toggle multiz parallax, the parallax effect for lower z-levels.
/* DARKPACK EDIT -- Offsets Z levels to give the appearance of building stacking - This setting caused the lower plates to offset relative to the viewer's perspective
// Which gave the appearance that buildings 'bent' in relation to where you observed them.
/datum/preference/toggle/multiz_parallax
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "multiz_parallax"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE // DARKPACK EDIT ADD - Default to disabled

/datum/preference/toggle/multiz_parallax/apply_to_client(client/client, value)
	// DARKPACK EDIT ADD - Force disabled
	value = FALSE

	// Update the plane master group's Z transforms.

	var/datum/hud/my_hud = client.mob?.hud_used
	if(!my_hud)
		return

	for(var/group_key in my_hud.master_groups)
		var/datum/plane_master_group/group = my_hud.master_groups[group_key]
		group.build_planes_offset(my_hud, my_hud.current_plane_offset)
*/ // DARKPACK EDIT END -- Offsets Z levels to give the appearance of building 'stacking'
