/obj/item/card/credit
	name = "debit card"
	desc = "Used to access bank money."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "card1"
	inhand_icon_state = "card1"
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF | ACID_PROOF
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'

	var/owner = ""
	var/datum/bank_account/account
	var/code
	var/balance = 0
	var/has_checked = FALSE

/obj/item/card/credit/prince
	icon_state = "card2"
	inhand_icon_state = "card2"

/obj/item/card/credit/seneschal
	icon_state = "card2"
	inhand_icon_state = "card2"

/obj/item/card/credit/elder
	icon_state = "card3"
	inhand_icon_state = "card3"

/obj/item/card/credit/giovanniboss
	icon_state = "card2"
	inhand_icon_state = "card2"

/obj/item/card/credit/rich

/obj/item/card/credit/New(mob/user)
	..()
	if(!account || code == "")
		account = new /datum/bank_account()
	if(user)
		owner = user.ckey
	if(istype(src, /obj/item/card/credit/prince))
		account.balance = rand(10000, 15000)
	else if(istype(src, /obj/item/card/credit/elder))
		account.balance = rand(3000, 7000)
	else if(istype(src, /obj/item/card/credit/rich))
		account.balance = rand(1000, 4000)
	else if(istype(src, /obj/item/card/credit/giovanniboss))
		account.balance = rand(8000, 15000)
	else if(istype(src, /obj/item/card/credit/seneschal))
		account.balance = rand(4000, 8000)
	else
		account.balance = rand(600, 1000)

/datum/outfit/job/post_equip(mob/living/carbon/human/H)
	. = ..()

	var/obj/item/storage/backpack/b = locate() in H
	if(b)
		var/obj/item/card/credit/card = locate() in b.contents
		if(card && card.has_checked == FALSE)
			for(var/obj/item/card/credit/caard in b.contents)
				if(caard)
					H.bank_id = caard.account.bank_id
					caard.account.account_owner = H.true_real_name
					caard.has_checked = TRUE
