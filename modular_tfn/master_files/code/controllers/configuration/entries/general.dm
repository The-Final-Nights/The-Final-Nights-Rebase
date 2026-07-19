/// Enables sending certain actions to a Discord webhook for review
/datum/config_entry/flag/discord_overwatch

/datum/config_entry/string/discord_overwatch_webhook
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/admin_overwatch_webhook
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

// for the announcements UI
/datum/config_entry/string/announcements_webhook // camarilla announcements
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

// per clan announcements
/datum/config_entry/string/announcements_webhook_malkavian
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/announcements_webhook_banu_haqim
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/announcements_webhook_lasombra
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/announcements_webhook_nosferatu
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/announcements_webhook_toreador
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/announcements_webhook_tremere
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/announcements_webhook_ventrue
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN
