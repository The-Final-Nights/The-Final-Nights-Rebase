/**
 * Rolls a number of dice according to Storyteller system rules to find
 * success or number of successes.
 *
 * Rolls a number of 10-sided dice, counting them as a "success" if
 * they land on a number equal to or greater than the difficulty. Dice
 * that land on 1 subtract a success from the total, and the minimum
 * difficulty is 2. The number of successes is returned if numerical
 * is true, or the roll outcome (botch, failure, success) as a defined
 * number if false.
 *
 * Arguments:
 * * dice - number of 10-sided dice to roll.
 * * difficulty - the number that a dice must come up as to count as a success.
 * * numerical - whether the proc returns number of successes or outcome (botch, failure, success)
 */
/proc/storyteller_roll(dice = 1, difficulty = 6, numerical = FALSE)
	var/successes = 0
	var/had_one = FALSE
	var/had_success = FALSE

	if (dice < 1)
		if (numerical)
			return 0
		else
			return ROLL_FAILURE

	for (var/i in 1 to dice)
		var/roll = rand(1, 10)

		if (roll == 1)
			successes--
			if (!had_one)
				had_one = TRUE
			continue

		if (roll >= difficulty)
			successes++
			if (!had_success)
				had_success = TRUE

	if (numerical)
		return successes
	else
		if (!had_success && had_one)
			return ROLL_BOTCH
		else if (successes <= 0)
			return ROLL_FAILURE
		else
			return ROLL_SUCCESS

/proc/vampireroll(dices_num = 1, hardness = 1, atom/rollviewer)
	var/wins = 0
	var/crits = 0
	var/brokes = 0
	for(var/i in 1 to dices_num)
		var/roll = rand(1, 10)
		if(roll == 10)
			crits += 1
		if(roll == 1)
			brokes += 1
		else if(roll >= hardness)
			wins += 1
	if(crits > brokes)
		if(rollviewer)
			to_chat(rollviewer, "<b>Critical [span_nicegreen("hit")]!</b>")
			return DICE_CRIT_WIN
	if(crits < brokes)
		if(rollviewer)
			to_chat(rollviewer, "<b>Critical [span_danger("failure")]!</b>")
			return DICE_CRIT_FAILURE
	if(crits == brokes && !wins)
		if(rollviewer)
			to_chat(rollviewer, span_danger("Failed"))
			return DICE_FAILURE
	if(wins)
		switch(wins)
			if(1)
				to_chat(rollviewer, span_tinynotice("Maybe"))
				return DICE_WIN
			if(2)
				to_chat(rollviewer, span_smallnotice("Okay"))
				return DICE_WIN
			if(3)
				to_chat(rollviewer, span_notice("Good"))
				return DICE_WIN
			if(4)
				to_chat(rollviewer, span_notice("Lucky"))
				return DICE_WIN
			else
				to_chat(rollviewer, span_boldnotice("Phenomenal"))
				return DICE_WIN
