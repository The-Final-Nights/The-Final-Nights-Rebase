/datum/blood_type/kindred
	name = BLOOD_TYPE_KINDRED
	reagent_type = /datum/reagent/blood/vitae
	color = LIGHT_COLOR_BLOOD_MAGIC
	compatible_types = list(
		/datum/blood_type/human/a_minus,
		/datum/blood_type/human/a_plus,
		/datum/blood_type/human/b_minus,
		/datum/blood_type/human/b_plus,
		/datum/blood_type/human/o_minus,
		/datum/blood_type/human/o_plus,
		/datum/blood_type/human/ab_minus,
		/datum/blood_type/human/ab_plus,
	)

/datum/blood_type/kindred/get_emissive_alpha(atom/source, is_worn = FALSE)
	return 125

/datum/blood_type/kindred/set_up_blood(obj/effect/decal/cleanable/blood/blood, new_splat = FALSE)
	. = ..()
	blood.emissive_alpha = max(blood.emissive_alpha, new_splat ? 125 : 63)
	if (new_splat)
		return
	blood.can_dry = FALSE
