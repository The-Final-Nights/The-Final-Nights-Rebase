/obj/item/clothing/mask/vampire/gas/magadon
	name = "magadon gas mask"
	desc = "A high-tech gas mask branded belonging to Magadon Incorporated."
	icon_state = "gas_magadon"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH | PEPPERPROOF
	TFN_CLOTHING_ADDITION

/obj/item/clothing/mask/gas/atmos/faceplate
	name = "faceplate mask"
	desc = "A solid mask that completely covers the face, or a lack of one."
	icon = 'icons/map_icons/clothing/mask.dmi'
	worn_icon = 'modular_tfn/modules/clothes/icons/clothing/worn/greyscale_worn.dmi'
	icon_state = "faceplate"
	post_init_icon_state = "faceplate"
	tint = 0
	greyscale_colors = "#FFFFFF"
	greyscale_config = /datum/greyscale_config/faceplate
	greyscale_config_worn = /datum/greyscale_config/faceplate/worn
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING
	flags_1 = IS_PLAYER_COLORABLE_1
	actions_types = list(/datum/action/item_action/adjust)
	toggle_message = "You wear the mask tight to your face."
	alt_toggle_message = "You wear the mask loosely, letting you eat."

/obj/item/clothing/mask/gas/atmos/faceplate/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state || initial(post_init_icon_state)]"

/obj/item/clothing/mask/gas/atmos/faceplate/why_so_eyes
	icon_state = "faceplate_eyes"
	post_init_icon_state = "faceplate_eyes"
	greyscale_colors = "#FFFFFF#333333"
	greyscale_config = /datum/greyscale_config/faceplate_eyes
	greyscale_config_worn = /datum/greyscale_config/faceplate_eyes/worn

/obj/item/clothing/mask/neck_gaiter
	name = "neck gaiter"
	desc = "A cloth for covering your neck, and usually a part of your face too, but that part's optional."
	actions_types = list(/datum/action/item_action/adjust)
	alternate_worn_layer = UNIFORM_LAYER
	icon = 'icons/map_icons/clothing/mask.dmi'
	worn_icon = 'modular_tfn/modules/clothes/icons/clothing/worn/greyscale_worn.dmi'
	icon_state = "neck_gaiter"
	post_init_icon_state = "gaiter"
	inhand_icon_state = "balaclava"
	greyscale_config = /datum/greyscale_config/neck_gaiter
	greyscale_config_worn = /datum/greyscale_config/neck_gaiter/worn
	greyscale_colors = "#444444"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT|MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	flags_1 = IS_PLAYER_COLORABLE_1
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/neck_gaiter/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/neck_gaiter/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/neck_gaiter/click_alt_secondary(mob/user)
	alternate_worn_layer = (alternate_worn_layer == initial(alternate_worn_layer) ? NONE : initial(alternate_worn_layer))
	user.update_clothing(ITEM_SLOT_MASK)
	balloon_alert(user, "wearing [alternate_worn_layer == initial(alternate_worn_layer) ? "below" : "above"] suits")

/obj/item/clothing/mask/neck_gaiter/examine(mob/user)
	. = ..()
	. += span_notice("[src] can be worn above or below your suit. Alt-Right-click to toggle.")
	. += span_notice("Alt-click [src] to adjust it.")

/obj/item/clothing/mask/duelmask
	name = "zorro mask"
	desc = "A black cloth mask for those masked duelists, doesn't grant any protection, but covers your eyes, and your identity... somehow."
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "duelmask"
	worn_icon = 'modular_tfn/modules/clothes/icons/clothing/worn/color_worn.dmi'
	flags_inv = HIDEFACE
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_MASK
	flags_cover = MASKCOVERSEYES
