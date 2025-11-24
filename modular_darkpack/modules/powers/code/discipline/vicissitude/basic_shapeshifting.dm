#define CHANGE_HAIR "Change Hair"
#define CHANGE_BEARD "Change Beard"
#define CHANGE_SEX  "Change Sex"
#define CHANGE_NAME "Change Name"
#define CHANGE_EYES "Change Eyes"
#define CHANGE_RACE "Change Race"
#define CHOICE_OPTIONS list(CHANGE_HAIR, CHANGE_BEARD, CHANGE_SEX, CHANGE_EYES, CHANGE_NAME, CHANGE_RACE)

/datum/action/cooldown/mob_cooldown/basic_vicissitude
	name = "Vicissitude Shapeshfting"
	desc = "Shapeshift a body."
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "transform"
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_HANDS_BLOCKED | AB_CHECK_IMMOBILE | AB_CHECK_INCAPACITATED
	vampiric = TRUE
	var/list/choices = CHOICE_OPTIONS

	ranged_mousepointer = 'icons/effects/mouse_pointers/discipline.dmi'

/datum/action/cooldown/mob_cooldown/basic_vicissitude/New(Target, original)
	. = ..()
	update_choices()

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/update_choices()
	for(var/i in choices)
		choices[i] = icon('icons/hud/radial.dmi', i)

/datum/action/cooldown/mob_cooldown/basic_vicissitude/Activate(atom/target)
	if(!ishuman(target))
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, 1))
		owner.balloon_alert(owner, "too far!")
		return FALSE
	unset_click_ability(owner, refund_cooldown = FALSE)
	display_radial_menu(target)
	// StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/display_radial_menu(mob/target)
	var/chosen_option = show_radial_menu(owner, target, choices, target, radius = 36, tooltips = TRUE)
	if(!chosen_option)
		return TRUE

	switch(chosen_option)
		if(CHANGE_HAIR)
			change_hair(target)
		if(CHANGE_BEARD)
			change_beard(target)
		if(CHANGE_SEX)
			change_sex(target)
		if(CHANGE_NAME)
			change_name(target)
		if(CHANGE_EYES)
			change_eyes(target)
		if(CHANGE_RACE)
			change_race(target)
	return display_radial_menu(target)

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/change_sex(mob/living/carbon/human/target)
	var/chosen_sex = tgui_input_list(owner, "Choose a gender.", "Confirmation", list("Male", "Female", "Plural", "Neuter"))
	switch(chosen_sex)
		if("Male")
			target.gender = MALE
		if("Female")
			target.gender = FEMALE
		if("Plural")
			target.gender = PLURAL
		if("Neuter")
			target.gender = NEUTER

	var/chosen_physique = tgui_input_list(owner, "Alter physique as well?", "Confirmation", list("Masculine", "Feminine"))
	if(chosen_physique)
		target.physique = (chosen_physique == "Masculine") ? MALE : FEMALE

	target.dna.update_ui_block(/datum/dna_block/identity/gender)
	target.update_body(is_creating = TRUE) // or else physique won't change properly
	target.update_mutations_overlay() //(hulk male/female)
	target.update_clothing(ITEM_SLOT_ICLOTHING) // update gender shaped clothing
	to_chat(owner, span_notice("You finish altering the gender of [target]."))

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/change_eyes(mob/living/carbon/human/target)
	var/new_eye_color = input(owner, "Choose a eye color", "Eye Color", target.eye_color_left) as color|null
	if(isnull(new_eye_color))
		return TRUE
	target.set_eye_color(sanitize_hexcolor(new_eye_color))
	target.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
	target.update_body()
	to_chat(owner, span_notice("You finish altering the eye color of [target]."))

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/change_beard(mob/living/carbon/human/target)
	var/new_style = tgui_input_list(owner, "Select a facial hairstyle", "Grooming", SSaccessories.facial_hairstyles_list)
	if(isnull(new_style))
		return TRUE
	target.set_facial_hairstyle(new_style, update = TRUE)
	to_chat(owner, span_notice("You finish altering the facial style of [target]."))

	var/new_face_color = input(owner, "Choose a facial hair color", "Hair Color", target.facial_hair_color) as color|null
	if(new_face_color)
		target.set_facial_haircolor(sanitize_hexcolor(new_face_color))
		target.dna.update_ui_block(/datum/dna_block/identity/facial_color)
	to_chat(owner, span_notice("You finish altering the facial hair color of [target]."))
	return TRUE

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/change_hair(mob/living/carbon/human/target)
	var/new_style = tgui_input_list(owner, "Select a hairstyle", "Grooming", SSaccessories.hairstyles_list)
	if(isnull(new_style))
		return TRUE
	target.set_hairstyle(new_style, update = TRUE)
	to_chat(owner, span_notice("You finish altering the hair style of [target]."))

	var/new_hair_color = input(owner, "Choose a hair color", "Hair Color", target.hair_color) as color|null
	if(new_hair_color)
		target.set_haircolor(sanitize_hexcolor(new_hair_color))
		target.dna.update_ui_block(/datum/dna_block/identity/hair_color)
	to_chat(owner, span_notice("You finish altering the hair color of [target]."))
	return TRUE

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/change_name(mob/living/carbon/human/user)
	var/newname = sanitize_name(tgui_input_text(owner, "Who are we again?", "Name change", user.name, MAX_NAME_LEN))
	if(!newname)
		return TRUE
	user.real_name = newname
	user.name = newname
	if(user.dna)
		user.dna.real_name = newname
	if(user.mind)
		user.mind.name = newname
	return TRUE

/datum/action/cooldown/mob_cooldown/basic_vicissitude/proc/change_race(mob/living/carbon/human/user)
	var/new_s_tone = tgui_input_list(owner, "Choose a skin tone", "Race change", GLOB.skin_tones)
	if(new_s_tone)
		user.skin_tone = new_s_tone
		user.dna.update_ui_block(/datum/dna_block/identity/skin_tone)
	user.update_body(is_creating = TRUE)
	user.update_mutations_overlay()
	return TRUE

#undef CHANGE_HAIR
#undef CHANGE_BEARD
#undef CHANGE_SEX
#undef CHANGE_EYES
#undef CHOICE_OPTIONS
