/datum/bank_account
	var/bank_pin

/datum/bank_account/New(newname, job, modifier = 1, player_account = TRUE)
	. = ..()
	if(!bank_pin)
		bank_pin = "[rand(0, 9)][rand(0, 9)][rand(0, 9)][rand(0, 9)]"
