/// Returns if the given target is a homid
/// Not a moth, not a felinid (which are human subtypes), but a garou.
/proc/ishomid(target)
	if (!ishuman(target))
		return FALSE

	var/mob/living/carbon/human/human_target = target
	return human_target.dna?.species?.type == /datum/species/human/garou
