/obj/item/bodypart
	///The current amount of aggravated damage the limb has
	var/aggravated_dam = 0
	/// Aggravated damage gets multiplied by this on receive_damage()
	var/aggravated_modifier = 1

	var/light_aggravated_msg = "bruised and feels numb"
	var/medium_aggravated_msg = "torn apart"
	var/heavy_aggravated_msg = "like pieces are falling off"
