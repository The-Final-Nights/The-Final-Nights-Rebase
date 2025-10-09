//Regular blooc packs are considered O-, due to being the all-purpose donation blood type.
/obj/item/reagent_containers/blood
	icon = 'modular_darkpack/modules/vitae/icons/bloodpack.dmi'
	lefthand_file = 'modular_darkpack/modules/vitae/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/vitae/icons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/vitae/icons/onfloor.dmi')
	icon_state = "blood100"
	inhand_icon_state = "blood100"
	initial_reagent_flags = OPENCONTAINER | REFILLABLE | DRAWABLE

/obj/item/reagent_containers/blood/Initialize(mapload, vol)
	. = ..()
	update_appearance()

/obj/item/reagent_containers/blood/update_appearance(updates)
	. = ..()
	var/percent = round((reagents.total_volume / volume) * 100)
	switch(percent)
		if(76 to 100)
			icon_state = "blood100"
		if(51 to 75)
			icon_state = "blood75"
		if(26 to 50)
			icon_state = "blood50"
		if(1 to 25)
			icon_state = "blood25"
		if(0)
			icon_state = "blood0"
	inhand_icon_state = icon_state
	onflooricon_state = icon_state

/obj/item/reagent_containers/blood/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!canconsume(M, user))
		return
	if(!do_after(user, 3 SECONDS, M))
		return
	reagents.trans_to(M, reagents.total_volume, transferred_by = user, methods = INGEST, show_message = FALSE)
	playsound(M.loc, 'sound/items/drink.ogg', 50, TRUE)
	update_appearance()
	//SEND_SIGNAL(M, COMSIG_MASQUERADE_VIOLATION)

/obj/item/reagent_containers/blood/empty
	blood_type = null

/obj/item/reagent_containers/blood/ab_plus
	blood_type = BLOOD_TYPE_AB_PLUS

/obj/item/reagent_containers/blood/ab_minus
	blood_type = BLOOD_TYPE_AB_MINUS

/obj/item/reagent_containers/blood/vitae
	name = "\improper vampire vitae pack (full)"
	blood_type = BLOOD_TYPE_KINDRED

/////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/blood/bweedpack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/bweedpack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/drug/cannabis, 20)
	reagents.add_reagent(/datum/reagent/toxin/lipolicide, 20)
	reagents.add_reagent(/datum/reagent/blood, 160,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = random_human_blood_type_name(),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()

/obj/item/reagent_containers/blood/cokepack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/cokepack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/drug/methamphetamine, 15)
	reagents.add_reagent(/datum/reagent/blood, 185,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = random_human_blood_type_name(),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()

/obj/item/reagent_containers/blood/morphpack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/morphpack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/toxin/chloralhydrate, 10)
	reagents.add_reagent(/datum/reagent/medicine/morphine, 10)
	reagents.add_reagent(/datum/reagent/blood, 180,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = random_human_blood_type_name(),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()

/obj/item/reagent_containers/blood/methpack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/methpack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/drug/methamphetamine, 15)
	reagents.add_reagent(/datum/reagent/blood, 185,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = random_human_blood_type_name(),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()
