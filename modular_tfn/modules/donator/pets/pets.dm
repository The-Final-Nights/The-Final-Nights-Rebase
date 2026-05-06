/mob/living/basic/rabbit/pet/brown/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/animal_variety, icon_prefix, "brown", TRUE)

/mob/living/basic/rabbit/pet/black/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/animal_variety, icon_prefix, "black", TRUE)

/mob/living/basic/rabbit/pet/white/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/animal_variety, icon_prefix, "white", TRUE)

// Dogs
/mob/living/basic/pet/dog/darkpack
	name = "\improper dog"
	desc = "A loyal companion! They need lots of attention, but will love you unconditionally."
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	icon_state = "dog"
	icon_living = "dog"
	icon_dead = "dog_dead"

/mob/living/basic/pet/dog/darkpack/fox
	name = "\improper fox"
	desc = "A sly little fox! They can be a bit mischievous, but they sure are cute."
	icon = 'icons/mob/simple/pets.dmi'
	icon_state = "fox"
	icon_living = "fox"
	icon_dead = "fox_dead"

// Birds
/mob/living/basic/pet/bird
	name = "\improper black bird"
	desc = "Adorable! They make such a racket though."
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	icon_state = "black"
	icon_living = "black"
	icon_dead = "spiralblack_rest"
	butcher_results = list(/obj/item/food/meat/slab/chicken = 1) //taaaahstts liiiike chiiiickun... -roi


/mob/living/basic/pet/bird/white
	name = "\improper white bird"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	icon_state = "white"
	icon_living = "white"
	icon_dead = "spiralwhite_rest"

/mob/living/basic/pet/bird/gray
	name = "\improper gray bird"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	icon_state = "gray"
	icon_living = "gray"
	icon_dead = "spiralgray_rest"

/mob/living/basic/pet/bird/red
	name = "\improper red bird"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	icon_state = "red"
	icon_living = "red"
	icon_dead = "spiralred_rest"

/mob/living/basic/pet/bird/green
	name = "\improper green bird"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	icon_state = "green"
	icon_living = "green"
	icon_dead = "spiralgreen_rest"

/mob/living/basic/pet/bird/brown
	name = "\improper brown bird"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	icon_state = "brown"
	icon_living = "brown"
	icon_dead = "spiralbrown_rest"

/mob/living/basic/pet/bird/bat
	name = "\improper bat"
	desc = "A cute little bat! It looks like it could be a pet, but it might be a little high maintenance."
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"

// Cats
/mob/living/basic/pet/cat/darkpack/black
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	bloodpool = 2
	maxbloodpool = 2
	mob_size = MOB_SIZE_SMALL
	icon_state = "cat1"

/mob/living/basic/pet/cat/darkpack/gray
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	bloodpool = 2
	maxbloodpool = 2
	mob_size = MOB_SIZE_SMALL
	icon_state = "cat2"

/mob/living/basic/pet/cat/darkpack/brown
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	bloodpool = 2
	maxbloodpool = 2
	mob_size = MOB_SIZE_SMALL
	icon_state = "cat3"

/mob/living/basic/pet/cat/darkpack/white
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	bloodpool = 2
	maxbloodpool = 2
	mob_size = MOB_SIZE_SMALL
	icon_state = "cat4"

/mob/living/basic/pet/cat/darkpack/tabby
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	bloodpool = 2
	maxbloodpool = 2
	mob_size = MOB_SIZE_SMALL
	icon_state = "cat5"

/mob/living/basic/pet/cat/darkpack/bw
	icon = 'icons/mob/simple/pets.dmi'
	bloodpool = 2
	maxbloodpool = 2
	mob_size = MOB_SIZE_SMALL
	icon_state = "cat"

/mob/living/basic/pet/cat/darkpack/bw/Initialize()
	. = ..()
	icon_state = "cat" // because the parent sets a random cat sprite
	icon_living = "cat"
	icon_dead = "cat_dead"

/mob/living/basic/pet/cat/darkpack/bw/Life()
	. = ..()

/obj/item/donator/pet_crate
	name = "pet crate"
	desc = "Unveil your favorite pet!"
	icon = 'icons/obj/pet_carrier.dmi'
	icon_state = "pet_carrier_closed"

/obj/item/donator/pet_crate/attack_self(mob/user)
	ui_interact(user)

/obj/item/donator/pet_crate/ui_interact(mob/user, datum/tgui/ui)
	if(user.client?.prefs?.donator_rank < DONATOR_ANCILLA) // ancilla and above
		to_chat(user, span_notice("You must be an Ancilla donator or above to use this item! If you have just donated, please run the ?verifydonator command in Discord and try again."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DonatorPetCrate")
		ui.open()

/obj/item/donator/pet_crate/ui_data(mob/user)
	var/list/data = list()

	var/list/dogs = list()
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/darkpack",
		"name" = "Dog",
		"desc" = "A loyal companion! They need lots of attention, but will love you unconditionally.",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "dog"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/corgi",
		"name" = "Corgi",
		"desc" = "A small herding dog breed known for its short legs and long body. Friendly and intelligent.",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "corgi"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/bullterrier",
		"name" = "Bull Terrier",
		"desc" = "A strong and sturdy dog breed. Loyal and protective.",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "bullterrier"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/pug",
		"name" = "Pug",
		"desc" = "An affront to God and her creations. Still cute though.",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "pug"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/corgi/puppy",
		"name" = "Corgi Puppy",
		"desc" = "Tiny corgi! So much fluff! Such little legs!",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "puppy"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/darkpack/ginger",
		"name" = "Ginger Dog",
		"desc" = "A loyal companion! They need lots of attention, but will love you unconditionally.",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "dog1"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/darkpack/white",
		"name" = "White Dog",
		"desc" = "A loyal companion! They need lots of attention, but will love you unconditionally.",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "dog2"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/darkpack/black",
		"name" = "Black Dog",
		"desc" = "A loyal companion! They need lots of attention, but will love you unconditionally.",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "dog3"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/darkpack/gray",
		"name" = "Gray Dog",
		"desc" = "A loyal companion! They need lots of attention, but will love you unconditionally.",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "dog4"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/darkpack/red",
		"name" = "Red Dog",
		"desc" = "A loyal companion! They need lots of attention, but will love you unconditionally.",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "dog5"), user, sourceonly = TRUE)
	))
	dogs += list(list(
		"type" = "/mob/living/basic/pet/dog/darkpack/fox",
		"name" = "Fox",
		"desc" = "Foxes are dogs... Right?",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "fox"), user, sourceonly = TRUE)
	))
	var/list/cats = list()
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/darkpack/bw",
		"name" = "B&W Cat",
		"desc" = "Kitty!!",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "cat"), user, sourceonly = TRUE)
	))
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/darkpack/black",
		"name" = "Black Cat",
		"desc" = "Kitty!!",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "cat1"), user, sourceonly = TRUE)
	))
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/darkpack/gray",
		"name" = "Gray Cat",
		"desc" = "Kitty!!",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "cat2"), user, sourceonly = TRUE)
	))
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/darkpack/brown",
		"name" = "Brown Cat",
		"desc" = "Kitty!!",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "cat3"), user, sourceonly = TRUE)
	))
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/darkpack/white",
		"name" = "White Cat",
		"desc" = "Kitty!!",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "cat4"), user, sourceonly = TRUE)
	))
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/darkpack/tabby",
		"name" = "Tabby Cat",
		"desc" = "Kitty!!",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "cat5"), user, sourceonly = TRUE)
	))
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/",
		"name" = "Calico Cat",
		"desc" = "Kitty!!",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "cat2"), user, sourceonly = TRUE)
	))
	cats += list(list(
		"type" = "/mob/living/basic/pet/cat/kitten",
		"name" = "Calico Kitten",
		"desc" = "D'aaawwww.",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "kitten"), user, sourceonly = TRUE)
	))

	var/list/birds = list()
	birds += list(list(
		"type" = "/mob/living/basic/pet/bird",
		"name" = "Black Bird",
		"desc" = "Adorable! They make such a racket though.",
		"icon" = icon2html(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi', "black"), user, sourceonly = TRUE)
	))
	birds += list(list(
		"type" = "/mob/living/basic/pet/bird/white",
		"name" = "White Bird",
		"desc" = "Adorable! They make such a racket though.",
		"icon" = icon2html(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi', "white"), user, sourceonly = TRUE)
	))
	birds += list(list(
		"type" = "/mob/living/basic/pet/bird/gray",
		"name" = "Gray Bird",
		"desc" = "Adorable! They make such a racket though.",
		"icon" = icon2html(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi', "gray"), user, sourceonly = TRUE)
	))
	birds += list(list(
		"type" = "/mob/living/basic/pet/bird/red",
		"name" = "Red Bird",
		"desc" = "Adorable! They make such a racket though.",
		"icon" = icon2html(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi', "red"), user, sourceonly = TRUE)
	))
	birds += list(list(
		"type" = "/mob/living/basic/pet/bird/green",
		"name" = "Green Bird",
		"desc" = "Adorable! They make such a racket though.",
		"icon" = icon2html(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi', "green"), user, sourceonly = TRUE)
	))
	birds += list(list(
		"type" = "/mob/living/basic/pet/bird/brown",
		"name" = "Brown Bird",
		"desc" = "Adorable! They make such a racket though.",
		"icon" = icon2html(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi', "brown"), user, sourceonly = TRUE)
	))
	birds += list(list(
		"type" = "/mob/living/basic/pet/bird/bat",
		"name" = "Bat",
		"desc" = "It's a bat!",
		"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "bat"), user, sourceonly = TRUE)
	))

	var/list/other = list()
	other += list(list(
		"type" = "/mob/living/basic/rabbit/pet/brown",
		"name" = "Brown Rabbit",
		"desc" = "An adorable little rabbit.",
		"icon" = icon2html(icon('icons/mob/simple/rabbit.dmi', "rabbit_brown"), user, sourceonly = TRUE)
	))
	other += list(list(
		"type" = "/mob/living/basic/rabbit/pet/black",
		"name" = "Black Rabbit",
		"desc" = "An adorable little rabbit.",
		"icon" = icon2html(icon('icons/mob/simple/rabbit.dmi', "rabbit_black"), user, sourceonly = TRUE)
	))
	other += list(list(
		"type" = "/mob/living/basic/rabbit/pet/white",
		"name" = "White Rabbit",
		"desc" = "An adorable little rabbit.",
		"icon" = icon2html(icon('icons/mob/simple/rabbit.dmi', "rabbit_white"), user, sourceonly = TRUE)
	))
	other += list(list(
		"type" = "/mob/living/basic/stoat",
		"name" = "Stoat",
		"desc" = "Cutest little rat catcher around!",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "stoat"), user, sourceonly = TRUE)
	))
	other += list(list(
		"type" = "/mob/living/basic/stoat/kit",
		"name" = "Stoat Kit",
		"desc" = "A tiny stoat kit. Just a baby.",
		"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "kit_stoat"), user, sourceonly = TRUE)
	))

	data["categories"] = list(
		list(
			"key" = "dogs",
			"label" = "Dogs",
			"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "dog"), user, sourceonly = TRUE),
			"pets" = dogs
		),
		list(
			"key" = "cats",
			"label" = "Cats",
			"icon" = icon2html(icon('modular_darkpack/master_files/icons/mobs/simple/pets.dmi', "cat1"), user, sourceonly = TRUE),
			"pets" = cats
		),
		list(
			"key" = "birds",
			"label" = "Birds",
			"icon" = icon2html(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi', "white"), user, sourceonly = TRUE),
			"pets" = birds
		),
		list(
			"key" = "other",
			"label" = "Other",
			"icon" = icon2html(icon('icons/mob/simple/pets.dmi', "stoat"), user, sourceonly = TRUE),
			"pets" = other
		)
	)
	return data

/obj/item/donator/pet_crate/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("choose_pet")
			var/pet_type = text2path(params["pet_type"])
			var/location = get_turf(src)
			visible_message(span_warning("\The [src] springs open!"))
			new pet_type(location)
			visible_message(span_notice("A [name] hops out of the crate!"))
			new /obj/item/pet_carrier(location) //swap out the fake crate for a real one
			to_chat(usr, span_notice("You have received a [pet_type]! Use the collar to name your pet!"))
			new /obj/item/clothing/neck/petcollar(location)
			qdel(src)
			return TRUE
