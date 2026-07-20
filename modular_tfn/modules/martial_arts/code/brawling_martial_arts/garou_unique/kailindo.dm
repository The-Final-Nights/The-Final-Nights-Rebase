// From WW Players Guide - Second Edition; we take some creative liberties.
#define DECEPTIVE_WIND "DHD"
#define BINDING_WIND "GH"
#define TORNADO_KICK "HDH"
#define WHIRLWIND "HHG"

/datum/martial_art/darkpack_kailindo
	name = "Kailindo"
	id = MARTIALART_DARKPACK_KAILINDO
	help_verb = "Remember The Basics"
	display_combos = TRUE
	var/datum/storyteller_roll/brawl_dex/dex_attack
	var/datum/storyteller_roll/brawl_strength/str_attack
	var/datum/storyteller_roll/brawl_defend/athletics/knockdown_check

/datum/martial_art/darkpack_kailindo/activate_style(mob/living/new_holder)
	. = ..()
	//RegisterSignal(new_holder, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(new_holder, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(check_dodge_parry))
	if(iscarbon(new_holder))
		var/list/obj/item/bodypart/affected_bodyparts
		var/mob/living/carbon/human/carbon_owner = new_holder
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(!istype(limb, /obj/item/bodypart/arm) && !istype(limb, /obj/item/bodypart/leg))
				continue

			LAZYADD(affected_bodyparts, limb)

			limb.unarmed_damage_low += 5
			limb.unarmed_damage_high += 5
			//We remove Crinos from having agg damage; instead they get meatier combos and the bonus raw damage to punches.
			limb.attack_type = BRUTE

/datum/martial_art/darkpack_kailindo/deactivate_style(mob/living/remove_from)
	UnregisterSignal(remove_from, list(COMSIG_LIVING_CHECK_BLOCK))
	return ..()

// Messy way of checking the attacker's form to make sure they are in Crinos or are not in Crinos. Avoids transforming and keeping the agg damage.
/datum/martial_art/darkpack_kailindo/proc/check_form(mob/living/carbon/attacker)
	if(iscrinos(attacker))	//Removes agg damage fallback
		for(var/obj/item/bodypart/limb as anything in attacker.bodyparts)
			if(!istype(limb, /obj/item/bodypart/arm) && !istype(limb, /obj/item/bodypart/leg))
				continue
			limb.attack_type = BRUTE
	if(islupus(attacker))	//Prevents combo-gain; you shouldn't be doing combos
		return

/datum/martial_art/darkpack_kailindo/proc/check_streak(mob/living/attacker, mob/living/defender)
	// Way of checking on combo what form the attackers in; prevents lupus combos and ensures no agg damage w/ crinos
	check_form(attacker)

	//Stops you from comboing unconcious people.
	if(defender.IsUnconscious())
		reset_streak()
		return

	//If you get knockedown or otherwise stunned your streak resets.
	if(attacker.IsKnockdown() || attacker.IsParalyzed() || attacker.IsStun() || attacker.body_position == LYING_DOWN)
		reset_streak()
		return

	if(findtext(streak,DECEPTIVE_WIND))
		reset_streak()
		return deceptive_wind(attacker, defender)

	if(findtext(streak,BINDING_WIND))
		reset_streak()
		return binding_wind(attacker, defender)

	if(findtext(streak,TORNADO_KICK))
		reset_streak()
		return tornado_kick(attacker, defender)

	if(findtext(streak,WHIRLWIND))
		reset_streak()
		return whirlwind(attacker, defender)

	return FALSE

// Deceptive Wind
// Described in player guide as a surprise blow, acting like a spring-coil attack via a feint and kick to the side.
/datum/martial_art/darkpack_kailindo/proc/deceptive_wind(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_KICK)
	jump_animation(attacker)	//To feint and hit you'd have to get some air-time; looks cooler anyway.
	var/atom/throw_target = get_edge_target_turf(defender, attacker.dir)
	var/throw_distance = clamp((attacker.st_get_stat(STAT_STRENGTH) - defender.st_get_stat(STAT_STAMINA)), 1, 3)

	defender.visible_message(
		span_warning("[attacker] feints [defender] before slamming their foot into their side, sending them flying!"),
		span_userdanger("You are kicked in the side by [attacker], sending you flying back!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("You feint and kick [defender] in the side, sending them flying back!"))
	playsound(attacker, 'modular_tfn/modules/martial_arts/sounds/frontalkick.ogg', 50, TRUE, -1)

	//If the attacker is Crinos, and defender is not, we toss this guy across the room like a rag-doll.
	if(iscrinos(attacker) && !iscrinos(defender))
		defender.throw_at(throw_target, throw_distance + 2, 2, attacker, spin = TRUE)
		defender.apply_damage(30, attacker.get_attack_type(), BODY_ZONE_CHEST)
		defender.apply_damage(30, STAMINA)
		if(!knockdown_check)
			knockdown_check = new()
		knockdown_check.difficulty = (attacker.st_get_stat(STAT_STRENGTH) + attacker.st_get_stat(STAT_BRAWL))
		var/defended_time = knockdown_check.st_roll(defender, attacker)
		var/knockdown_time = clamp((10 - defended_time), 0, 10)
		defender.Knockdown(knockdown_time SECONDS)
	else
		if(isglabro(attacker))
			defender.throw_at(throw_target, throw_distance + 1, 2, attacker)
			defender.apply_damage(20, attacker.get_attack_type(), BODY_ZONE_CHEST)
			defender.Knockdown(2 SECONDS)
			defender.apply_damage(25, STAMINA)
		else
			defender.throw_at(throw_target, throw_distance, 2, attacker)
			defender.apply_damage(15, attacker.get_attack_type(), BODY_ZONE_CHEST)
			defender.apply_damage(20, STAMINA)
	log_combat(attacker, defender, "Deceptive Winded (Kailindo)")
	return TRUE

/datum/martial_art/darkpack_kailindo/proc/jump_animation(mob/user)
	var/original_transform = user.transform
	animate(user, transform = user.transform.Translate(0, 4), time = 0.1 SECONDS, flags = ANIMATION_PARALLEL)
	animate(transform = original_transform, time = 0.1 SECONDS)

// Binding Wind - Based off sleeping carp's wrist-lock w/ modifications.
// Described in player guide as catching opponent by the wrist, using momentum to immobilize/disarm, and does non-agg damage.
/datum/martial_art/darkpack_kailindo/proc/binding_wind(mob/living/attacker, mob/living/defender)
	// Determine if our target has a functioning active arm. If not, return.
	var/obj/item/bodypart/affecting = defender.get_active_hand()
	if(!affecting)
		return FALSE

	//If the attacker is Crinos, and defender is not, we get a large bonus to wound - aka dislocate.
	if(iscrinos(attacker) && !iscrinos(defender))
		attacker.do_attack_animation(defender, ATTACK_EFFECT_CLAW)

		defender.visible_message(
		span_danger("[attacker] violently twists [defender]'s [affecting] and rips a claw across them!"),
		span_userdanger("[attacker] violently twists and rips your [affecting]!"),
		span_hear("You hear a sickening sound of bone snapping!"),
		null,
		attacker,
		)
		to_chat(attacker, span_danger("You violently twist and rip at [defender]'s [affecting]!"))
		playsound(defender, 'sound/items/weapons/slice.ogg', 25, TRUE, -1)

		defender.apply_damage(20, BRUTE, affecting, wound_bonus = 50)

		//Bonus roll for maximum damage; does another hit to their, idealy, neck and pins.
		if(!dex_attack)
			dex_attack = new()
		dex_attack.difficulty = defender.st_get_stat(STAT_DEXTERITY)
		var/roll_success = dex_attack.st_roll(attacker, defender)
		if(roll_success)
			attacker.do_attack_animation(defender, ATTACK_EFFECT_BITE)	//Another one....
			to_chat(span_danger("[attacker] bites down into [defender]'s neck, pinning them!"))
			defender.Knockdown(5 SECONDS)
			defender.apply_damage(20, BRUTE, BODY_ZONE_HEAD, wound_bonus = 50)
	else
		attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
		defender.visible_message(
			span_danger("[attacker] violently twists [defender]'s [affecting] and punches them!"),
			span_userdanger("[attacker] violently twists your [affecting]!"),
			span_hear("You hear a sickening sound of bone snapping!"),
			null,
			attacker,
		)
		to_chat(attacker, span_danger("You violently twist [defender]'s [affecting]!"))
		playsound(defender, 'sound/items/weapons/punch1.ogg', 25, TRUE, -1)

		if(isglabro(attacker))
			defender.apply_damage(20, BRUTE, affecting, wound_bonus = 30)
		else
			defender.apply_damage(20, BRUTE, affecting, wound_bonus = 20)

	defender.drop_all_held_items()
	log_combat(attacker, defender, "Binding Winded (Kailindo)")
	return TRUE

// Tornado Kick - semi-based off Sleeping Carp's dropkick
// Described in player guide as an incredibly speedy spinning back-kick such as in Tai Kwon Do. Disorients and knocks back a slight bit.
/datum/martial_art/darkpack_kailindo/proc/tornado_kick(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_KICK)
	attacker.emote("spin")	//SPIIIIIIN!!
	defender.visible_message(
			span_danger("[attacker] spins around and kicks [defender] in the head!"),
			span_userdanger("[attacker] spins and kicks you in the side of the head!"),
			span_hear("You hear your ears strat ringing!"),
			null,
			attacker,
	)
	to_chat(attacker, span_danger("You spin quickly and slam your foot into [defender]'s head!"))
	playsound(attacker, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	var/atom/throw_target = get_edge_target_turf(defender, attacker.dir)
	var/armor_block = defender.run_armor_check(BODY_ZONE_HEAD, MELEE)
	//Crinos get better knockback slightly, more damage, and chance to deafen target for a time
	if(iscrinos(attacker) && !iscrinos(defender))
		defender.apply_damage(30, attacker.get_attack_type(), BODY_ZONE_HEAD, blocked = armor_block)
		defender.adjust_dizzy_up_to(5 SECONDS, 10 SECONDS)
		defender.adjust_eye_blur_up_to(3 SECONDS, 3 SECONDS)
		defender.throw_at(throw_target, 2, 2, attacker)
		//Bonus roll for maximum damage; does another hit to their, idealy, neck and pins.
		if(!dex_attack)
			dex_attack = new()
		dex_attack.difficulty = defender.st_get_stat(STAT_STAMINA)
		var/roll_success = dex_attack.st_roll(attacker, defender)
		if(roll_success)
			defender.apply_damage(40, STAMINA)
			var/obj/item/organ/ears/ears = defender.get_organ_slot(ORGAN_SLOT_EARS)
			ears?.adjust_temporary_deafness(2 SECONDS)
			defender.adjust_dizzy_up_to(5 SECONDS, 10 SECONDS)
			defender.adjust_temp_blindness_up_to(1 SECONDS, 3 SECONDS)
		else
			defender.apply_damage(20, STAMINA)
	else
		defender.apply_damage(20, attacker.get_attack_type(), BODY_ZONE_HEAD)
		defender.adjust_dizzy_up_to(5 SECONDS, 5 SECONDS)
		defender.adjust_eye_blur_up_to(3 SECONDS, 3 SECONDS)
		if(isglabro(attacker))
			defender.throw_at(throw_target, 1, 2, attacker)
			defender.apply_damage(25, STAMINA)
		else
			defender.apply_damage(20, STAMINA)

	log_combat(attacker, defender, "Binding Winded (Kailindo)")
	return TRUE

// Whirlwind
// Described in player guide as a flurry of attacks within one turn; we instead make it like throwing rapid succession hits based on successes of dice rolling.
/datum/martial_art/darkpack_kailindo/proc/whirlwind(mob/living/attacker, mob/living/defender)
	if(iscrinos(attacker))
		attacker.do_attack_animation(defender, ATTACK_EFFECT_SLASH)
	if(!iscrinos(attacker))
		attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)

	defender.visible_message(
			span_danger("[attacker] unleashes a flurry of attacks against [defender]!"),
			span_userdanger("[attacker] unlashes multiple hits into you!"),
			span_hear("You hear a sickening sound of bone snapping!"),
			null,
			attacker,
	)
	to_chat(attacker, span_danger("unleash a furry of punches into [defender]!"))

	var/successes
	if(!dex_attack)
		dex_attack = new()
	dex_attack.difficulty = defender.st_get_stat(STAT_DEXTERITY)
	successes = dex_attack.st_roll(attacker, defender)
	if(iscrinos(attacker))
		successes += 1	//Mild bonus to Crinos, you're larger so harder to do this but raw power.
	if(isglabro(attacker))
		successes += 2	//More notable bonus for Galbro, gives an encouragement to not go beast-mode + you're not huge so more nimble still.
	var/armor_block = defender.run_armor_check(BODY_ZONE_CHEST, MELEE)
	//var/total_damage = str_attack.st_roll(attacker, defender)	//Brawl + strength, should cap at ~10 normally
	//total_damage = clamp((total_damage * 2), 0, 30)				//We times by 2, should cap at ~20 normally. 22 for Galbro, 24 for war-form.
	defender.apply_damage(20 * successes, attacker.get_attack_type(), BODY_ZONE_CHEST, blocked = armor_block)
	defender.apply_damage(20 * successes, STAMINA)
	defender.adjust_eye_blur_up_to(successes SECONDS, 10 SECONDS)

	return TRUE

/datum/martial_art/darkpack_kailindo/grab_act(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 0, "[attacker]'s grab", UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("G", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS
	defender.apply_damage(15, STAMINA)
	return MARTIAL_ATTACK_INVALID //Boxing is not known for holds

/datum/martial_art/darkpack_kailindo/harm_act(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 10, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("H", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	return MARTIAL_ATTACK_INVALID //You're gonna punch someone in the face normally and like it

/datum/martial_art/darkpack_kailindo/disarm_act(mob/living/attacker, mob/living/defender)
	if(!can_deflect(attacker)) //you arent swiping at someone on the ground
		return MARTIAL_ATTACK_INVALID
	if(defender.check_block(attacker, 0, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("D", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS
	//playsound(defender, 'modular_tfn/modules/martial_arts/sounds/swipe.ogg', 25, TRUE, -1) SFX didnt feel good using it
	defender.apply_damage(20, STAMINA)
	return MARTIAL_ATTACK_INVALID //Essentially taking a swipe at their face

/datum/martial_art/darkpack_kailindo/proc/dodge_animation(mob/living/user)
	var/new_pixel_x
	var/new_pixel_y
	var/userdir = user.dir
	switch(userdir)
		if(EAST)
			new_pixel_x = rand(-16, -8)
			new_pixel_y = rand(-24, 24)
		if(WEST)
			new_pixel_x = rand(8, 16)
			new_pixel_y = rand(-24, 24)
		if(NORTH)
			new_pixel_x = rand(-16,16)
			new_pixel_y = rand(-16, -8)
		if(SOUTH)
			new_pixel_x = rand(-16,16)
			new_pixel_y = rand(8, 16)
	animate(user, alpha = 200, pixel_x = new_pixel_x, pixel_y = new_pixel_y, time = 0.2 SECONDS)

/datum/martial_art/darkpack_kailindo/proc/reset_animation(mob/living/user, fadein)
	if(fadein)
		animate(user, alpha = 225, time = 0.1 SECONDS)
		return
	else
		animate(user, alpha = 225, pixel_x = 0, pixel_y = 0, time = 0.1 SECONDS)

/datum/martial_art/darkpack_kailindo/proc/can_deflect(mob/living/user)
	if(!can_use(user) || !user.combat_mode)
		return FALSE
	if(INCAPACITATED_IGNORING(user, INCAPABLE_GRAB)) //NO STUN
		return FALSE
	if(!(user.mobility_flags & MOBILITY_USE)) //IF YOU CANT MOVE, YOU CANT DODGE
		return FALSE
	if(HAS_TRAIT(user, TRAIT_HULK)) //NO HULK
		return FALSE
	if(!isturf(user.loc)) //NO MOTHERFLIPPIN MECHS!
		return FALSE
	return TRUE

/* This is a unique type of dodging, it goes as follows:
- Humans and Galbro get normal dodge chances to melee and unarmed attacks, akin to street-boxing though to a lower level
- Crinos get no dodge bonus
- Lupis cannot use combos but get a double to dodging those same human and galbro hits x2
*/
/datum/martial_art/darkpack_kailindo/proc/check_dodge_parry(mob/living/user, atom/movable/hitby, damage, attack_text, attack_type, ...)
	SIGNAL_HANDLER
	if(iscrinos(user))				 //NO CRINOS DODGING!
		return FALSE
	var/determine_avoidance = ((user.st_get_stat(STAT_ATHLETICS) + user.st_get_stat(STAT_DEXTERITY) + user.st_get_stat(STAT_BRAWL))) //Theoretically caps at roughly 15%, bit higher for Galbro
	if(islupus(user))
		determine_avoidance *= 2	//This can stack with throw mode. Should be about 30% base, 60% on throw.
	if(user.throw_mode)
		determine_avoidance *= 2	//Normally should be 30% max on galbro/human while on throw, 60% on lupus

	if(attack_type != (UNARMED_ATTACK || MELEE_ATTACK))
		return NONE

	if(!prob(determine_avoidance))
		return NONE

	if(attack_type == UNARMED_ATTACK)
		playsound(user.loc, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
		user.visible_message(
		span_danger("[user] cleanly dodges [attack_text] with incredible speed!"),
		span_userdanger("You dodge [attack_text]"),
		)
	if(attack_type == MELEE_ATTACK)
		playsound(user.loc, 'sound/items/weapons/parry.ogg', 25, TRUE, -1)
		user.visible_message(
		span_danger("[user] cleanly parrys [attack_text] with incredible speed!"),
		span_userdanger("You parry [attack_text]"),
		)

	var/mob/living/attacker = GET_ASSAILANT(hitby)
	user.setDir(turn(attacker.dir, 180))
	var/mob/living/carbon/human/dodger = user
	dodge_animation(dodger)
	addtimer(CALLBACK(src, PROC_REF(reset_animation), dodger, FALSE), 0.1 SECONDS)

	return SUCCESSFUL_BLOCK


/datum/martial_art/darkpack_kailindo/get_style_help()
	. = list()

	. += "<b><i>You try to remember some of the basics of Kailindo.</i></b>"

	. += "[span_notice("Deceptive Wind")]: Shove Punch Shove. First, a front-kick feint before you quickly turn and nail them in the side, taking them off guard. Not only will you harm them, but wind, and in larger forms knock them away and down such as Glabro or Crinos!"
	. += "[span_notice("Tornado Kick")]: Punch Shove Punch. Using your incredible speed you are able to lean and spin into a kick, landing a hit directly into your targets head! This will disorient them, even possibly blinding or deafening in larger forms such as Glabro or Crinos!"
	. += "[span_notice("Binding Wind")]: Grab Punch. By using your speed you may grab your opponent by their arm and disarm them, possibly dislocating their arm in the process! Glabro get bonus damage, in Crinos form you may also lock your target down to floor using your maw! "
	. += "[span_notice("Whirlwind")]: Punch Punch Grab. Unleash a flurry of punches upon your opponent in a single, quick action. Rolls dice based on your dexterity and brawl. Crinos receive a free bonus success, Glabro receive two free bonus successes."
	. += "[span_notice("Dodging/Parrying")]: The art of Kailindo has hightened your reaction time, you are able to avoid attacks thrown at you while in Combat Mode. In Lupus form you will increase avoidance chance. Throw mode also increases the avoidance chance. Large forms such as Crinos though leave you unable to dodge most attacks."

	return .

#undef DECEPTIVE_WIND
#undef BINDING_WIND
#undef TORNADO_KICK
#undef WHIRLWIND
