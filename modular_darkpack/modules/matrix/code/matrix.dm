#define DOAFTER_SOURCE_MATRIX "doafter_matrix"

/turf/closed/indestructible/the_matrix
	name = "matrix"
	desc = "Suicide is no exit..."
	icon = 'modular_darkpack/modules/matrix/icons/props.dmi'
	icon_state = "matrix"

/turf/closed/indestructible/the_matrix/attack_hand(mob/user)
	if(!user.client)
		return FALSE
	if(!do_after(user, 10 SECONDS, src, interaction_key = DOAFTER_SOURCE_MATRIX))
		return FALSE
	matrix_mob(user, src)
	return TRUE

/obj/the_matrix
	name = "matrix (depricated)"
	desc = "Suicide is no exit... This is an old evil version, please contact a mapper to replace this with a turf one if you are reading this"
	icon = 'modular_darkpack/modules/matrix/icons/props.dmi'
	icon_state = "matrix"
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	opacity = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/the_matrix/attack_hand(mob/user)
	if(!user.client)
		return FALSE
	if(!do_after(user, 10 SECONDS, src, interaction_key = DOAFTER_SOURCE_MATRIX))
		return FALSE
	matrix_mob(user, src)
	return TRUE

proc/matrix_mob(mob/living/despawning_mob)
	message_admins("[ADMIN_LOOKUP(despawning_mob)] has exited through the matrix.")
	log_game("[despawning_mob] has exited through the matrix.")

	SSjob.FreeRole(despawning_mob.mind.assigned_role)

	GLOB.joined_player_list -= despawning_mob.ckey

	//handle_objectives()
	despawning_mob.ghostize(FALSE)
	QDEL_NULL(despawning_mob)

#undef DOAFTER_SOURCE_MATRIX
