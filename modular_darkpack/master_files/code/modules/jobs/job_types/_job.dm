/datum/job
	var/experience_addition = 5

/datum/outfit/job/post_equip(mob/living/carbon/human/H)
	. = ..()

	var/obj/item/storage/backpack/b = locate() in H
	if(b)
		var/obj/item/vamp/creditcard/card = locate() in b.contents
		if(card && card.has_checked == FALSE)
			for(var/obj/item/vamp/creditcard/caard in b.contents)
				if(caard)
					H.bank_id = caard.account.bank_id
					caard.account.account_owner = H.true_real_name
					caard.has_checked = TRUE
