/**
 * Morality defines
 */

/mob/living/carbon/human
	var/datum/morality/morality_path

#define MIN_PATH_SCORE 1
#define MAX_PATH_SCORE 10

// Very simplified version of virtues
#define MORALITY_HUMANITY "morality_humanity"
#define MORALITY_ENLIGHTENMENT "morality_enlightenment"

// Path hits
#define PATH_SCORE_DOWN -1
#define PATH_SCORE_UP 1

// Path hit signals
#define COMSIG_PATH_HIT "path_hit"

// Path cooldowns
#define COOLDOWN_PATH_HIT "path_hit_cooldown"

// Bearings
#define BEARING_MUNDANE (1<<0)
#define BEARING_RESOLVE (1<<1)
#define BEARING_JUSTICE (1<<2)
#define BEARING_INHUMANITY (1<<3)
#define BEARING_COMMAND (1<<4)
#define BEARING_INTELLECT (1<<5)
#define BEARING_DEVOTION (1<<6)
#define BEARING_HOLINESS (1<<7)
#define BEARING_SILENCE (1<<8)
#define BEARING_MENACE (1<<9)
#define BEARING_FAITH (1<<10)
#define BEARING_GUILT (1<<11)
