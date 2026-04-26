/datum/quirk/darkpack/devil_mark
	name = "Devil's Mark"
	desc = "Whether product of your Embrace or gained through exposure to infernal or other unholy power, you’ve been branded with the “Devil’s Mark,” an anatomical aberration that manifests the taint of the demonic. Possible deformities include, but are not limited to: bestial or inhuman eyes, hooves, horns, unnaturally colored or scaly skin, a birthmark in the form of a sigil, parasitic infestation, claws, misshapen teeth. or ineffectual (perhaps additional) limbs. You may never remove or “improve” these disfigurements, although magic or Disciplines can hide them from plain sight."
	value = -3
	mob_trait = TRAIT_HORRIFIC_APPEARANCE
	gain_text = span_notice("You are possessed of a bizarre mutation!")
	lose_text = span_notice("Your body returns to normal.")
	allowed_splats = list(SPLAT_KINDRED) //All kindred can actually have this, not just Baali.
  excluded_clans = list(VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_NOSFERATU)
	icon = FA_ICON_STAR
	failure_message = "Your body returns to normal."

/datum/quirk/darkpack/devil_mark/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(ishuman(new_holder))
		var/datum/splat/vampire/kindred/owner_splat = get_kindred_splat(owner)
	  owner_splat.clan.accessories = list(
		  "baali_full",
		  "baali_left",
	  	"baali_right",
	  	"baali_broken",
	  	"baali_round",
	  	"baali_oni",
	  	"baali_devil"
  	)
    owner_splat.clan.default_accessory = "baali_full"

/datum/quirk/darkpack/devil_mark/remove(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(ishuman(new_holder))
		var/datum/splat/vampire/kindred/owner_splat = get_kindred_splat(owner)
	  owner_splat.clan.accessories = NULL
    owner_splat.clan.default_accessory = NULL
