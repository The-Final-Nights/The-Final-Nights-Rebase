/datum/surgery/fleshcraft/height_change
	name = "Height Change"
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/change_spine,
		/datum/surgery_step/close
		)

	replaced_by = null

/datum/surgery_step/change_spine
	name = "Manipulate Spine"
	accept_hand = TRUE
	time = 100
	repeatable = TRUE

/datum/surgery_step/change_spine/preop(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to manipulate [target]'s spine like taffy."),
		span_notice("[user] begins to manipulate [target]'s spine like taffy!"),
		span_notice("[user] begins to manipulate [target]'s spine like taffy!"),
	)
	display_pain(target, "You feel like your spine is carving its way through your back!")

/datum/surgery_step/change_spine/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/list/heights = list(
		"Taller" = HUMAN_HEIGHT_TALLER,
		"Tall" = HUMAN_HEIGHT_TALL,
		"Average" = HUMAN_HEIGHT_MEDIUM,
		"Short" = HUMAN_HEIGHT_SHORT,
		"Shorter" = HUMAN_HEIGHT_SHORTEST,
		)

	var/new_height = tgui_input_list(user, "Choose a height", "Height change", heights)
	new_height = heights[new_height]
	if(!new_height)
		return FALSE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	target.set_mob_height(new_height)
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the height of [target]."))
	return TRUE
