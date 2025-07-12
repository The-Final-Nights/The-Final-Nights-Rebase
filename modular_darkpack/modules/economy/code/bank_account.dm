/proc/create_bank_code()
	var/bank_code = ""
	for(var/i = 1 to 4)
		bank_code += "[rand(0, 9)]"
	return bank_code

/datum/bank_account
	var/account_owner = ""
	var/bank_id = 0
	var/balance = 0
	var/code = ""
	var/list/credit_cards = list()

/datum/bank_account/New()
	..()
	if(!code || code == "")
		code = create_bank_code()
		var/random_id = rand(1, 999999)
		bank_id = random_id
		GLOB.bank_account_list += src
