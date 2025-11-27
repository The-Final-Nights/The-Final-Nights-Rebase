/datum/surgery/fleshcraft/appearance_change
	name = "Appearance Change"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/reshape_appearance, /datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_HEAD)
	replaced_by = null
	requires_tech = TRUE

/datum/surgery_step/reshape_appearance
	name = "Reshape Face"
	implements = list(TOOL_SCALPEL = 100, TOOL_KNIFE = 50, TOOL_WIRECUTTER = 35)
	time = 64
	repeatable = TRUE

/datum/surgery_step/reshape_appearance/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to alter [target]'s appearance."),
		span_notice("[user] begins to alter [target]'s appearance."),
		span_notice("[user] begins to make an incision in [target]'s face!"),
	)
	display_pain(target, "You feel your face being split apart!")

/datum/surgery_step/reshape_appearance/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/newname = sanitize_name(tgui_input_text(user, "Choose a new name.", "Name change", target.name, MAX_NAME_LEN))
	if(!newname || newname == target.name)
		return FALSE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	target.real_name = newname
	target.name = newname
	if(target.dna)
		target.dna.real_name = newname
	if(target.mind)
		target.mind.name = newname
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the name of [target]."))
	return TRUE
