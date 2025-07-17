ADMIN_VERB(roll_storyteller_dice, R_NONE, "Roll storyteller dice", "Roll storyteller dice at yourself.", ADMIN_CATEGORY_FUN)
	var/dice_count = tgui_input_number(usr, "Input amount of dice to roll:", "Dice", 5, 100, 1)
	var/difficulty = tgui_input_number(usr, "Input roll difficulty:", "Difficulty", 6, 10, 1)

	SSroll.storyteller_roll(dice_count, difficulty, usr, usr)
	BLACKBOX_LOG_ADMIN_VERB("Storyteller dice")
