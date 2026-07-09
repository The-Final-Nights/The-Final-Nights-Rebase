/obj/item/clothing/neck/long_cape
	name = "long cape"
	desc = "A graceful cloak that carefully surrounds your body."
	icon = 'modular_tfn/modules/clothes/icons/clothing/worn/color_worn.dmi'
	icon_state = "long_cape"
	post_init_icon_state = "long_cape"
	greyscale_config = /datum/greyscale_config/long_cape
	greyscale_config_worn = /datum/greyscale_config/long_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "cape")

/obj/item/clothing/neck/wide_cape
	name = "wide cape"
	desc = "A proud, broad-shouldered cloak with which you can protect the honor of your back."
	icon = 'modular_tfn/modules/clothes/icons/clothing/worn/color_worn.dmi'
	icon_state = "wide_cape"
	post_init_icon_state = "wide_cape"
	greyscale_config = /datum/greyscale_config/wide_cape
	greyscale_config_worn = /datum/greyscale_config/wide_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS
