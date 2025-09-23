/obj/item/card/hunter
	COOLDOWN_DECLARE(detonation_timer)

/obj/item/card/hunter/attack_self(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, detonation_timer))
		return
	if(!user.mind)
		return
	if(user.mind.holy_role != HOLY_ROLE_PRIEST)
		return
	COOLDOWN_START(src, detonation_timer, 30 SECONDS)
	do_sparks(rand(5, 9), FALSE, user)
	playsound(user.loc, 'modular_darkpack/modules/deprecated/sounds/cross.ogg', 100, FALSE, 8, 0.9)
	for(var/mob/living/M in get_hearers_in_view(4, src))
		bang(get_turf(src), M, user)

/obj/item/card/hunter/proc/bang(turf/turf, mob/living/living_mob, mob/living/user)
	if(living_mob.stat == DEAD) //They're dead!
		return
	living_mob.show_message(span_warning(span_bold("GOD SEES YOU!")), MSG_AUDIBLE)

	if(HAS_TRAIT(living_mob, TRAIT_REPELLED_BY_HOLINESS))
		living_mob.emote("scream")
		living_mob.pointed(user)

	var/distance = max(0, get_dist(get_turf(src), turf))
	if(living_mob.flash_act(affect_silicon = 1))
		living_mob.Paralyze(max(10/max(1, distance), 5))
		living_mob.Knockdown(max(100/max(1, distance), 40))

/obj/item/card/hunter/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(!COOLDOWN_FINISHED(src, detonation_timer))
		return
	if(HAS_TRAIT(target, TRAIT_REPELLED_BY_HOLINESS))
		COOLDOWN_START(src, detonation_timer, 30 SECONDS)
		lightningbolt(target)
		to_chat(target, span_userdanger("The gods have punished you for your sins!"))

/obj/item/card/prince
	name = "leader badge"
	desc = "King in the castle!"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id6"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id6"

/obj/item/card/sheriff
	name = "head security badge"
	desc = "A badge which shows honour and dedication."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id4"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id4"

/obj/item/card/camarilla
	name = "security badge"
	desc = "A badge which shows honour and dedication."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id3"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id3"

/obj/item/card/clerk
	name = "clerk badge"
	desc = "A badge which shows buerocracy qualification."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id1"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id1"

/obj/item/card/bruiser
	name = "bruiser badge"
	desc = "A badge which shows grit."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "bruiser_badge"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "bruiser_badge"

/obj/item/card/sweeper
	name = "sweeper badge"
	desc = "A badge which shows perspective."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "sweeper_badge"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "sweeper_badge"

/obj/item/card/emissary
	name = "emissary badge"
	desc = "A badge which shows a favored voice, interlaced with gold thread."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "emissary_badge"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "emissary_badge"

/obj/item/card/baron
	name = "eagle badge"
	desc = "The badge of a leader. The eagle stands proud, surrounded by the gold of their nest."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "eagle_badge"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "eagle_badge"

/obj/item/card/clinic
	name = "medical badge"
	desc = "A badge which shows medical qualification."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id2"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id2"

/obj/item/card/clinic/director
	name = "clinic director's badge"
	desc = "A badge which shows not only medical qualification, but also an authority over the clinic."

/obj/item/card/archive
	name = "scholar badge"
	desc = "A badge which shows a love of culture."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id7"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id7"

/obj/item/card/regent
	name = "erudite scholar badge"
	desc = "A badge which shows a deep understanding of culture."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id7_regent"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id7_regent"

/obj/item/card/cleaning
	name = "janitor badge"
	desc = "A badge which shows cleaning employment."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id8"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id8"

/obj/item/card/graveyard
	name = "keeper badge"
	desc = "A badge which shows graveyard employment."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id8"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id8"

/obj/item/card/dealer
	name = "business badge"
	desc = "A badge which shows business."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id9"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id9"

/obj/item/card/supplytech
	name = "technician badge"
	desc = "A badge which shows supply employment."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id10"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id10"

/obj/item/card/hunter
	name = "cross"
	desc = "When you come into the land that the Lord your God is giving you, you must not learn to imitate the abhorrent practices of those nations. No one shall be found among you who makes a son or daughter pass through fire, or who practices divination, or is a soothsayer, or an augur, or a sorcerer, or one who casts spells, or who consults ghosts or spirits, or who seeks oracles from the dead. For whoever does these things is abhorrent to the Lord; it is because of such abhorrent practices that the Lord your God is driving them out before you (Deuteronomy 18:9-12)."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id11"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id11"

// POLICE
/obj/item/card/police
	name = "police officer badge"
	desc = "Sponsored by the Government."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id13"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id13"

/obj/item/card/government
	name = "emergency dispatcher badge"
	desc = "Sponsored by the Government."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id1"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id1"

/obj/item/card/police/sergeant
	name = "police sergeant badge"
	desc = "Sponsored by the Government. This one seems slightly more worn down than all the others."

/obj/item/card/police/chief
	name = "police chief badge"
	desc = "Sponsored by the Government. This one has a chrome plated finish."

/obj/item/card/police/fbi
	name = "fbi special agent badge"
	desc = "Sponsored by the Government. This one has all the bells and whistles."


// CULTISTS
/obj/item/card/bahari
	name = "cultist badge"
	desc = "This shows your devotion to the dark mother."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id14"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id14"

/obj/item/card/noddist
	name = "cultist badge"
	desc = "This shows your devotion to the dark father."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id15"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id15"

//TZIMISCE ROLES
/obj/item/card/voivode
	name = "ancient badge"
	desc = "You have to wear this filthy thing to be recognized."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id12"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id12"

/obj/item/card/bogatyr
	name = "dusty badge"
	desc = "You have to wear this because the Voivode wants you to."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id12"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id12"

// PRIMOGEN STUFF
/obj/item/card/primogen
	name = "mysterious primogen badge"
	desc = "Sponsored by the Shadow Government."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "id12"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "id12"

/obj/item/card/whip
	name = "primogen's whip badge"
	desc = "This badge shows your servitude to an important person."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "onyxBadge"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "onyxBadge"

/obj/item/card/steward
	name = "primogen's steward badge"
	desc = "This badge shows you're very good at taking care of someone else's property."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "emeraldBadge"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "emeraldBadge"

/obj/item/card/myrmidon
	name = "primogen's myrmidon badge"
	desc = "A badge which shows you're responsible enough to protect someone important but not responsible enough to protect the most important."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "rubyBadge"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	worn_icon_state = "rubyBadge"
