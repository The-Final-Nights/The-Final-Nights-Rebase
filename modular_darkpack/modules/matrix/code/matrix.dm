#define DOAFTER_SOURCE_MATRIX "doafter_matrix"

/turf/closed/indestructible/the_matrix
	name = "matrix"
	desc = "Suicide is no exit..."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "matrix"

/turf/closed/indestructible/the_matrix/attack_hand(mob/user)
	if(user.client)
		if(do_after(user, 10 SECONDS, src, interaction_key = DOAFTER_SOURCE_MATRIX))
			despawn_mob(user, src)
	return TRUE

/turf/closed/indestructible/the_matrix/proc/despawn_mob(mob/living/despawning_mob)
	message_admins("[ADMIN_LOOKUP(despawning_mob)] has exited through the matrix.")
	log_game("[despawning_mob] has exited through the matrix.")

	SSjob.FreeRole(despawning_mob.mind.assigned_role)

	GLOB.joined_player_list -= despawning_mob.ckey

	//handle_objectives()
	despawning_mob.ghostize(FALSE)
	QDEL_NULL(despawning_mob)

/turf/closed/indestructible/edge
	name = "edge"
	desc = null
	icon = 'icons/turf/space.dmi'
	icon_state = "black"
	layer = SPACE_LAYER
	plane = FLOOR_PLANE
	rad_insulation = RAD_FULL_INSULATION

#undef DOAFTER_SOURCE_MATRIX
