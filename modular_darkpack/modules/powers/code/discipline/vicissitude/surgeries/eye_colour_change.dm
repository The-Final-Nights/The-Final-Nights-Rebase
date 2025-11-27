/datum/surgery/fleshcraft/eye_colour_change
	name = "Change Eye Colour"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/modify_eyes, /datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_PRECISE_EYES)
	replaced_by = null
	requires_tech = TRUE

//reshape_face
/datum/surgery_step/modify_eyes
	name = "Change Eye Colour"
	accept_hand = TRUE
	time = 20
	repeatable = TRUE

/datum/surgery_step/modify_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to reshape [target]'s eyes."),
		span_notice("[user] begins to manipulate [target]'s head in truly horrific ways!"),
		span_notice("[user] begins to manipulate [target]'s head in truly horrific ways!"),
	)
	display_pain(target, "You feel a burning feeling in the back of your eyes!")

/datum/surgery_step/modify_eyes/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/new_eye_color = input(user, "Choose a eye color", "Eye Color", target.eye_color_left) as color|null
	if(!new_eye_color)
		return TRUE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	target.set_eye_color(sanitize_hexcolor(new_eye_color))
	target.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
	target.update_body()
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the eye color of [target]."))
	return TRUE
