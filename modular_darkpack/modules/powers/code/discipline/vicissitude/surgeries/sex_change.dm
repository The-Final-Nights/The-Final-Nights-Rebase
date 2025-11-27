/datum/surgery/fleshcraft/sex_change
	name = "Sex Change"
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/sex_change,
				/datum/surgery_step/close)

	replaced_by = null

/datum/surgery_step/sex_change
	name = "Sex Change"
	accept_hand = TRUE
	time = 180
	repeatable = TRUE

/datum/surgery_step/sex_change/preop(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to reshape [target]..."),
		span_notice("[user] begins to manipulate [target]'s flesh in truly horrific ways!"),
		span_notice("[user] begins to manipulate [target]'s flesh in truly horrific ways!"),
	)
	display_pain(target, "You feel like your flesh is moving!")

/datum/surgery_step/sex_change/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(user, target, span_notice("You finish changing [target]'s sex!"),
		span_notice("[user] changes [target] into something... new."),
		span_notice("[user] finishes."))
	var/chosen_sex = tgui_input_list(user, "Choose a gender.", "Confirmation", list("Male", "Female", "Plural", "Neuter"))
	if(!chosen_sex)
		return FALSE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	switch(chosen_sex)
		if("Male")
			target.gender = MALE
		if("Female")
			target.gender = FEMALE
		if("Plural")
			target.gender = PLURAL
		if("Neuter")
			target.gender = NEUTER
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the gender of [target]."))

	var/chosen_physique = tgui_input_list(user, "Alter physique as well?", "Confirmation", list("Masculine", "Feminine"))
	if(!chosen_physique)
		return FALSE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	target.physique = (chosen_physique == "Masculine") ? MALE : FEMALE
	target.dna.update_ui_block(/datum/dna_block/identity/gender)
	target.update_body(is_creating = TRUE) // or else physique won't change properly
	target.update_mutations_overlay() //(hulk male/female)
	target.update_clothing(ITEM_SLOT_ICLOTHING) // update gender shaped clothing
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/deprecated/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the physique of [target]."))
	return TRUE
