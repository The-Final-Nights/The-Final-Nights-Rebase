/obj/machinery/atm
	name = "ATM Machine"
	desc = "Check your balance or make a transaction"
	icon = 'modular_darkpack/modules/economy/icons/atm.dmi'
	icon_state = "atm"
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/logged_in = FALSE
	var/entered_code

	var/atm_balance = 0
	var/obj/item/card/credit/current_card = null
	//light_system = STATIC_LIGHT
	light_color = COLOR_GREEN
	light_range = 2
	light_power = 1
	light_on = TRUE

/obj/machinery/atm/attackby(obj/item/P, mob/user, params)
	if(is_creditcard(P))
		if(logged_in)
			to_chat(user, span_notice("Someone is already logged in."))
			return
		current_card = P
		to_chat(user, span_notice("Card swiped."))
		return

	else if(iscash(P))
		if(!logged_in)
			to_chat(user, span_notice("You need to be logged in."))
			return
		else
			atm_balance += P.get_item_credit_value()
			to_chat(user, span_notice("You have deposited [P.get_item_credit_value()] dollars into the ATM. The ATM now holds [atm_balance] dollars."))
			qdel(P)
			return

/obj/machinery/atm/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Atm", name)
		ui.open()

/obj/machinery/atm/ui_data(mob/user)
	var/list/data = list()
	var/list/accounts = list()

	for(var/account_id in SSeconomy.bank_accounts_by_id)
		var/datum/bank_account/account = SSeconomy.bank_accounts_by_id[account_id]
		if(!account)
			continue
		if(account && account.account_holder)
			accounts += list(
				list("account_holder" = account.account_holder
				)
			)
		else
			accounts += list(
				list(
					"account_holder" = "Unnamed Account"
				)
			)

	data["logged_in"] = logged_in
	data["card"] = current_card ? TRUE : FALSE
	data["entered_code"] = entered_code
	data["atm_balance"] = atm_balance
	data["bank_account_list"] = json_encode(accounts)
	if(current_card)
		data["account_balance"] = current_card.registered_account.account_balance
		data["account_holder"] = current_card.registered_account.account_holder
		data["account_id"] = current_card.registered_account.account_id
		data["bank_pin"] = current_card.registered_account.bank_pin
	else
		data["account_balance"] = 0
		data["account_holder"] = ""
		data["account_id"] = ""
		data["bank_pin"] = ""

	return data

/obj/machinery/atm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("login")
			if(params["bank_pin"] == current_card.registered_account.bank_pin)
				logged_in = TRUE
				return TRUE
			else
				return FALSE
		if("logout")
			logged_in = FALSE
			entered_code = ""
			current_card = null
			return TRUE
		if("withdraw")
			var/amount = text2num(params["withdraw_amount"])
			if(amount != round(amount))
				to_chat(usr, "<span class='notice'>Withdraw amount must be a round number.")
			else if(current_card.registered_account.account_balance < amount)
				to_chat(usr, span_notice("Insufficient funds."))
			else
				while(amount > 0)
					var/drop_amount = min(amount, 1000)
					var/obj/item/stack/dollar/cash = new /obj/item/stack/dollar(loc, drop_amount)
					to_chat(usr, span_notice("You have withdrawn [drop_amount] dollars."))
					try_put_in_hand(cash, usr)
					amount -= drop_amount
					current_card.registered_account.account_balance -= drop_amount
			return TRUE
		if("transfer")
			var/amount = text2num(params["transfer_amount"])
			if(!amount || amount <= 0)
				to_chat(usr, span_notice("Invalid transfer amount."))
				return FALSE

			var/target_account_id = params["target_account"]
			if(!target_account_id)
				to_chat(usr, span_notice("Invalid target account ID."))
				return FALSE

			var/datum/bank_account/target_account = SSeconomy.bank_accounts_by_id[target_account_id]

			if(!target_account)
				to_chat(usr, span_notice("Invalid target account."))
				return FALSE
			if(current_card.registered_account.account_balance < amount)
				to_chat(usr, span_notice("Insufficient funds."))
				return FALSE

			current_card.registered_account.account_balance -= amount
			target_account.account_balance += amount
			to_chat(usr, span_notice("You have transferred [amount] dollars to account [target_account.account_holder]."))
			return TRUE

		if("change_pin")
			var/new_pin = params["new_pin"]
			current_card.registered_account.bank_pin = new_pin
			return TRUE
		if("deposit")
			if(atm_balance > 0)
				current_card.registered_account.account_balance += atm_balance
				to_chat(usr, span_notice("You have deposited [atm_balance] dollars into your card. Your new balance is [current_card.registered_account.account_balance] dollars."))
				atm_balance = 0
				return TRUE

			else
				to_chat(usr, span_notice("The ATM is empty. Nothing to deposit."))
				return TRUE
