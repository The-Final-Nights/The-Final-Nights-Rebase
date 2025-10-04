// Defines for Species IDs. Used to refer to the name of a species, for things like bodypart names or species preferences.
#define SPECIES_KINDRED "kindred"
#define SPECIES_GHOUL "ghoul"
#define SPECIES_GAROU "garou"

/// Health level where mobs who can Torpor will actually die
#define HEALTH_THRESHOLD_TORPOR_DEAD -200

#define iskindred(A) (is_species(A, /datum/species/human/kindred))
#define isghoul(A) (is_species(A, /datum/species/human/ghoul))
#define isgarou(A) (is_species(A, /datum/species/human/garou))
#define issupernatural(A) (isgarou(A) || isghoul(A) || iskindred(A))

#define iswerewolf(A) (istype(A, /mob/living/carbon/werewolf))
#define iscrinos(A) (istype(A, /mob/living/carbon/werewolf/crinos))
#define islupus(A) (istype(A, /mob/living/carbon/werewolf/lupus))

#define isnpc(A) (istype(A, /mob/living/carbon/human/npc))

#define SOUL_PRESENT 1
#define SOUL_ABSENT 2
#define SOUL_PROJECTING 3
