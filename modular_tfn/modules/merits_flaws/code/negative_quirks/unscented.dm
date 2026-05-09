/datum/quirk/darkpack/unscented
	name = "Unscented"
	desc = {"For some reason, you have no noticeable body odor.
		Your scent is so faint as to be practically undetectable by animals and Garou.
		This may work to your advantage while hiding from scent-driven predators (and many humans may prefer a neutral-smelling person), this fact is a decided disadvantage among Garou.
		They are likely to instinctually distrust anyone without a scent, suspecting that he or she is using supernatural means to hide Wyrm taint.
		No Gifts, such as Scent of the True Form, can reveal you as Kinfolk.
		Among a group of people who rely heavily on their sense of smell, you have a distinct disability."}
	value = -1
	gain_text = span_notice("You smell clean.")
	lose_text = span_notice("You feel distinctly less clean.")
	icon = FA_ICON_SOAP
	mob_trait = TRAIT_UNSCENTED
	allowed_splats = list(SPLAT_KINFOLK)
