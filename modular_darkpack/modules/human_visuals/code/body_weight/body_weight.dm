/**
 * Changes the body model (weight) of a human
 * between slim, normal, and fat, then updates icons
 * and limbs_id to match.
 *
 * Arguments:
 * * new_body_weight - Body model the human is being given.
 */
/mob/living/carbon/human/proc/set_body_weight(new_body_weight = AVERAGE_BODY_WEIGHT)
	// Change all bodyparts to the new body model
	for (var/obj/item/bodypart/bodypart as anything in bodyparts)
		bodypart.body_weight = new_body_weight

	// Assign clothing sprites for new body model
	switch (new_body_weight)
		if (SLIM_BODY_WEIGHT)
			if (gender == FEMALE)
				AddComponent(/datum/component/clothes_weight_sprites, 'modular_darkpack/modules/clothes/icons/worn_slim_f.dmi')
			else
				AddComponent(/datum/component/clothes_weight_sprites, 'modular_darkpack/modules/clothes/icons/worn_slim_m.dmi')
		if (AVERAGE_BODY_WEIGHT)
			var/datum/component/weight_icon_component = GetComponent(/datum/component/clothes_weight_sprites)
			qdel(weight_icon_component)
		if (FAT_BODY_WEIGHT)
			AddComponent(/datum/component/clothes_weight_sprites, 'modular_darkpack/modules/clothes/icons/worn_fat.dmi')

	update_body_parts()
