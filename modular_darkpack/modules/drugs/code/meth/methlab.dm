/obj/structure/methlab
	name = "chemical laboratory"
	desc = "\"Jesse... It's not about style, it's about science... I forgor in what order... But you should mix gasoline, 2 potassium iodide pills or mix of full coffee cup and vodka bottle... then add 3-4 ephedrine pills and mix it... May your ass not be blown off...\""
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "methlab"
//	plane = GAME_PLANE
//	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	var/troll_explode = FALSE	//HE FAILED THE ORDER (
	var/added_ephed = 0		//we need to add 3 pills each
	var/added_iod = 0		//gonna be 2 iod pills or coffee+vodka
	var/added_gas = FALSE	//fill it up boi

/obj/structure/methlab/movable
	name = "movable chemical lab"
	desc = "Not an RV, but it moves..."
	anchored = FALSE
	var/health = 20

/obj/structure/methlab/movable/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to [anchored ? "un" : ""]secure [src] [anchored ? "from" : "to"] the ground.")

	if(health == 20)
		. += span_notice("[src] is in good condition.")
	else if(health > 16)
		. += span_notice("[src] is lightly damaged.")
	else if(health > 10)
		. += span_warning("[src] has sustained some damage.")
	else if(health > 6)

		. += span_warning("[src] is close to breaking!")
	else
		. += span_warning("[src] is about to fall apart!")

/obj/structure/methlab/click_alt(mob/user)
	if(!user.Adjacent(src))
		return
	to_chat(user, span_notice("You start [anchored ? "unsecuring" : "securing"] [src] [anchored ? "from" : "to"] the ground."))
	if(do_after(user, 15))
		if(anchored)
			to_chat(user, span_notice("You unsecure [src] from the ground."))
			anchored = FALSE
			return
		else
			to_chat(user, span_notice("You secure [src] to the ground."))
			anchored = TRUE
			return

/obj/structure/methlab/movable/attackby(obj/item/used_item, mob/user, params)
	if(..(used_item, user, params))
		if(health <= 0)
			to_chat(user, span_warning("[src] is too damaged to use!"))
			return
		return TRUE

	if(added_ephed == 3 && added_iod == 2 && added_gas == TRUE)
		playsound(src, 'modular_darkpack/modules/deprecated/sounds/methcook.ogg', 50, TRUE)
		spawn(3 SECONDS)
			health -= 1
			if(health <= 16)
				var/probability
				if(health >= 10)
					probability = 5
				else if(health >= 6)
					probability = 10
				else if(health > 0)
					probability = 20
				else
					probability = 100
				if(prob(probability))
					explosion(loc,0,1,3,4)
	return

/obj/structure/methlab/attackby(obj/item/used_item, mob/user, params)
	if(istype(used_item, /obj/item/reagent_containers/pill/ephedrine))
		if(added_ephed != 3)
			added_ephed = min(3, added_ephed+1)
			to_chat(user, "You [pick("insert", "add", "mix")] [added_ephed] [used_item] in [src].")
			qdel(used_item)
	if(istype(used_item, /obj/item/reagent_containers/pill/potassiodide))
		if(added_iod != 2)
			if(!added_ephed)
				troll_explode = TRUE
			added_iod = min(2, added_iod+1)
			to_chat(user, "You [pick("insert", "add", "mix")] [added_iod] [used_item] in [src].")
			if(prob(20))
				to_chat(user, "Reagents start to react strangely...")
			qdel(used_item)
	if(istype(used_item, /obj/item/reagent_containers/food/drinks/coffee/vampire))
		if(!added_iod)
			added_iod = 1
			to_chat(user, "You [pick("throw", "blow", "spit")] [used_item] in [src].")
			if(prob(20))
				to_chat(user, "Reagents start to react strangely...")
			qdel(used_item)
	if(istype(used_item, /obj/item/reagent_containers/food/drinks/bottle/vodka))
		if(added_iod == 1)
			added_iod = 2
			to_chat(user, "You [pick("throw", "blow", "spit")] [used_item] in [src].")
			if(prob(20))
				to_chat(user, "Reagents start to react strangely...")
			qdel(used_item)
	if(istype(used_item, /obj/item/gas_can))
		var/obj/item/gas_can/G = used_item
		if(G.stored_gasoline && !added_gas)
			if(!added_ephed)
				troll_explode = TRUE
			if(!added_iod)
				troll_explode = TRUE
			G.stored_gasoline = max(0, G.stored_gasoline-100)
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/gas_fill.ogg', 25, TRUE)
			to_chat(user, "You [pick("spill", "add", "blender")] [used_item] in [src].")
			added_gas = TRUE
			if(prob(20))
				to_chat(user, "Something may be going wrong, or may not...")
	if(added_ephed == 3 && added_iod == 2 && added_gas == TRUE)
		playsound(src, 'modular_darkpack/modules/deprecated/sounds/methcook.ogg', 50, TRUE)
		spawn(3 SECONDS)
			playsound(src, 'modular_darkpack/modules/deprecated/sounds/methcook.ogg', 100, TRUE)
			if(troll_explode)
				explosion(loc,0,1,3,4)
			else
				var/amount = 4
				for(var/i = 1 to amount)
					new /obj/item/reagent_containers/food/drinks/meth(get_turf(src))
				added_ephed = 0
				added_iod = 0
				added_gas = FALSE
				troll_explode = FALSE
