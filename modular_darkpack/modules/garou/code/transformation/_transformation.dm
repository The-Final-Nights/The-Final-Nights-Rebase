#define TRANSFORMATION_DURATION 22
/// Will be removed once the transformation is complete.
#define TEMPORARY_TRANSFORMATION_TRAIT "temporary_transformation"

/mob/living/carbon/proc/transform_to_homid()
	if (transformation_timer || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	if(ishomid(src))
		return

	//Make mob invisible and spawn animation
	ADD_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)
	icon = null
	cut_overlays()

	var/obj/effect = new /obj/effect/temp_visual/monkeyify/humanify(loc)
	effect.SetInvisibility(invisibility)
	SetInvisibility(INVISIBILITY_MAXIMUM, id=type)

	transformation_timer = addtimer(CALLBACK(src, PROC_REF(finish_transform_to_homid)), TRANSFORMATION_DURATION, TIMER_UNIQUE)

/mob/living/carbon/proc/finish_transform_to_homid()
	transformation_timer = null
	REMOVE_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	icon = initial(icon)
	RemoveInvisibility(type)
	SEND_SIGNAL(src, COMSIG_MONKEY_HUMANIZE)
	return src

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
