/* Adding onto [code/__DEFINES/combat.dm] */
//Damage defines
/// Incredibly hard to heal damage, mostly supernatural. [BURN] is a type of aggravated damage, this is everything else.
#define AGGRAVATED "aggravated"

//bitflag damage defines used for suicide_act
#define AGGLOSS (1<<8)

/* Adding onto [code/__DEFINES/dcs/signals/signals_mob/signals_mob_living.dm] */
/// Send when aggloss is modified (type, amount, forced)
#define COMSIG_LIVING_ADJUST_AGGRAVATED_DAMAGE "living_adjust_aggravated_damage"

/* Adding onto [code/__DEFINES/mobs.dm] */
#define HEAL_AGGRAVATED (1<<19)

/* Adding onto [code/__DEFINES/mobs.dm] */
#define DEFAULT_AGGRAVATED_EXAMINE_TEXT "cellular damage"
