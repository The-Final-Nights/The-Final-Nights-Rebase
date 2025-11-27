/datum/surgery/fleshcraft/hair
	name = "Change Hair Colour"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/modify_hair, /datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_HEAD)
	replaced_by = null
	requires_tech = TRUE

//reshape_face
/datum/surgery_step/modify_hair
	name = "Change Hair Colour"
	accept_hand = TRUE
	time = 20

/datum/surgery_step/modify_hair/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to reshape [target]'s hair."),
		span_notice("[user] begins to manipulate [target]'s head in truly horrific ways!"),
		span_notice("[user] begins to manipulate [target]'s head in truly horrific ways!"),
	)
	display_pain(target, "You feel your hair being pulled in excruciating pain!")

/datum/surgery_step/modify_hair/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/new_style = tgui_input_list(user, "Select a hairstyle", "Grooming", SSaccessories.hairstyles_list)
	if(!new_style)
		return FALSE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	target.set_hairstyle(new_style, update = TRUE)
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the hair style of [target]."))

	var/new_hair_color = input(user, "Choose a hair color", "Hair Color", target.hair_color) as color|null
	if(!new_hair_color)
		return FALSE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	target.set_haircolor(sanitize_hexcolor(new_hair_color))
	target.dna.update_ui_block(/datum/dna_block/identity/hair_color)
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the hair color of [target]."))
	return TRUE
