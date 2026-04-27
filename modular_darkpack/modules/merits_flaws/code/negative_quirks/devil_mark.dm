/datum/quirk/darkpack/devil_mark
	name = "Devil's Mark"
	desc = "Whether product of your Embrace or gained through exposure to infernal or other unholy power, you’ve been branded with the “Devil’s Mark,” an anatomical aberration that manifests the taint of the demonic. Possible deformities include, but are not limited to: bestial or inhuman eyes, hooves, horns, unnaturally colored or scaly skin, a birthmark in the form of a sigil, parasitic infestation, claws, misshapen teeth. or ineffectual (perhaps additional) limbs. You may never remove or “improve” these disfigurements, although magic or Disciplines can hide them from plain sight."
	value = -3
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	gain_text = span_notice("You are possessed of a bizarre mutation!")
	lose_text = span_notice("Your body returns to normal.")
	allowed_splats = list(SPLAT_KINDRED) //All kindred can actually have this, not just Baali.
	excluded_clans = list(VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_KIASYD) //The removal process causes difficulties for any clans with existing accessories, and they're not compatible anwyay. 
	icon = FA_ICON_STAR
	failure_message = "Your body returns to normal."

/datum/quirk/darkpack/devil_mark/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(ishuman(new_holder))
		var/datum/splat/vampire/kindred/owner_splat = get_kindred_splat(new_holder)
		owner_splat.clan.accessories = list("baali_full", "baali_left", "baali_right", "baali_broken", "baali_round", "baali_oni", "baali_devil", "baali_legs_and_tail", "baali_claws")
		owner_splat.clan.accessories_layers = list("baali_full" = BODY_FRONT_LAYER, "baali_left" = BODY_FRONT_LAYER, "baali_right" = BODY_FRONT_LAYER, "baali_broken" = BODY_FRONT_LAYER, "baali_round" = BODY_FRONT_LAYER, "baali_devil" = BODY_FRONT_LAYER, "baali_oni" = BODY_FRONT_LAYER, "baali_legs_and_tail" = BODY_FRONT_LAYER, "baali_claws" = BODY_FRONT_LAYER, "none" = BODY_FRONT_LAYER)
		owner_splat.clan.default_accessory = "baali_full"

/datum/quirk/darkpack/devil_mark/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder 
	var/datum/splat/vampire/kindred/owner_splat = get_kindred_splat(human_holder)
	owner_splat.clan.accessories = "none"
	owner_splat.clan.accessories_layers = null
	owner_splat.clan.default_accessory = "none"
