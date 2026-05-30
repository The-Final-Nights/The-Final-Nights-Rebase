/// Index to a define to point at a runtime-global list at compile-time.
#define NETWORK_ID 1
/// Index to a string, for the contact title.
#define OUR_ROLE 2
/// Index to a boolean, on whether to replace role with job title (or alt-title).
#define USE_JOB_TITLE 3

/obj/item/smartphone/bishop
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "Bishop", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/paladin
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "Manor Castellan", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/true_sabbat
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "Manor Subject", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/revenant
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "Manor Servant", USE_JOB_TITLE = TRUE)
		)

// Magadonification
/obj/item/smartphone/magadon_lead
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MAGADON_NETWORK, OUR_ROLE = "Magadon Branch Lead", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = MAGADON_LEADER_NETWORK, OUR_ROLE = "Magadon Branch Leader", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/magadon_exec
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MAGADON_NETWORK, OUR_ROLE = "Magadon Executive", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = MAGADON_LEADER_NETWORK, OUR_ROLE = "Magadon Executive", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/magadon_affairs
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MAGADON_NETWORK, OUR_ROLE = "Magadon Internal Affairs Agent", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/magadon_sec_chief
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MAGADON_NETWORK, OUR_ROLE = "Magadon Chief of Security", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/magadon_security
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MAGADON_NETWORK, OUR_ROLE = "Magadon Security Agent", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/magadon_employee
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MAGADON_NETWORK, OUR_ROLE = "Magadon Employee", USE_JOB_TITLE = TRUE)
		)
// Magadonification
#undef NETWORK_ID
#undef OUR_ROLE
#undef USE_JOB_TITLE

