/mob/living
	var/datum/storyteller_traits/trait_holder

/// This is the object used to store and manage a character's st_traits.
/datum/storyteller_traits
	/// A dictionary of st_traits. K: path -> V: instance.
	VAR_PRIVATE/list/st_traits = list()

/datum/storyteller_traits/New()
	. = ..()
	for(var/datum/path as anything in subtypesof(/datum/st_trait))
		st_traits[path] = new path

/datum/storyteller_traits/Destroy()
	. = ..()
	st_traits = null

/// Return the total or pure score of the given trait.
/datum/storyteller_traits/proc/get_stat(trait, include_bonus = TRUE)
	var/datum/st_trait/A = st_traits[trait]
	return A.get(include_bonus)

/// Sets the score of the given trait.
/datum/storyteller_traits/proc/set_stat(amount, trait)
	var/datum/st_trait/A = st_traits[trait]
	A.setter(amount)

/// Return the instance of the given trait.
/datum/storyteller_traits/proc/get_trait(trait)
	RETURN_TYPE(/datum/st_trait)
	var/datum/st_trait/A = st_traits[trait]
	return A

/datum/storyteller_traits/proc/set_buff(amount, trait, source)
	var/datum/st_trait/A = get_trait(trait)
	LAZYSET(A.modifiers, source, amount)
	A.update_modifiers()

/datum/storyteller_traits/proc/remove_buff(trait, source)
	var/datum/st_trait/A = get_trait(trait)
	if(LAZYACCESS(A.modifiers, source))
		A.modifiers -= source
		A.update_modifiers()
