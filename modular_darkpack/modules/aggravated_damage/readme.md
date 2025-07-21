<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/DarkPack13/SecondCity/pull/28<!--PR Number-->

## Aggravated damage <!--Title of your addition.-->

Module ID: AGGRAVATED_DAMAGE<!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:

Implements aggravated damage from the Storyteller System TTRPGs. This is usually
supernatural or exceptionally grievous damage, and is incredibly difficult to heal
unless you have some kind of supernatural ability for it.

<!-- Here, try to describe what your PR does, what features it provides and any other directly useful information. -->

### TG Proc/File Changes:

- [code/modules/mob/living/damage_procs.dm](/code/modules/mob/living/damage_procs.dm):
	- `/mob/living/proc/apply_damage()`
	- `/mob/living/proc/heal_damage_type()`
	- `/mob/living/proc/get_current_damage_of_type()`
	- `/mob/living/proc/get_total_damage()`
	- `/mob/living/proc/apply_damages()`
	- `/mob/living/proc/heal_bodypart_damage()`
	- `/mob/living/proc/take_bodypart_damage()`
	- `/mob/living/proc/heal_overall_damage()`
	- `/mob/living/proc/take_overall_damage()`
- [code/modules/mob/living/living.dm](/code/modules/mob/living/living.dm):
	- `/mob/living/proc/updatehealth()`
	- `/mob/living/vv_get_header()`
	- `/mob/living/proc/heal_and_revive()`
	- `/mob/living/proc/fully_heal()`
- [code/modules/mob/living/carbon/carbon.dm](/code/modules/mob/living/carbon/carbon.dm)
	- `/mob/living/carbon/updatehealth()`
	- `/mob/living/carbon/update_damage_hud()`
	- `/mob/living/carbon/proc/can_defib()`
- [code/__DEFINES/dcs/signals/signals_mob/signals_mob_living.dm](/code/__DEFINES/dcs/signals/signals_mob/signals_mob_living.dm)
	- `#define COMSIG_LIVING_ADJUST_STANDARD_DAMAGE_TYPES`
- [code/__DEFINES/mobs.dm](/code/__DEFINES/mobs.dm):
	- `#define HEAL_DAMAGE`
- [code/controllers/subsystem/blackbox.dm](/code/controllers/subsystem/blackbox.dm):
	- `/datum/controller/subsystem/blackbox/proc/ReportDeath()`
- [code/modules/admin/tag.dm](/code/modules/admin/tag.dm)
	- `#define TAG_CARBON_HEALTH()`
- [code/modules/admin/topic.dm](/code/modules/admin/topic.dm)
	- `/datum/admins/Topic()`
- [code/modules/admin/view_variables/topic.dm](/code/modules/admin/view_variables/topic.dm)
	- `/client/proc/view_var_Topic()`
- [SQL/tgstation_schema.sql](/SQL/tgstation_schema.sql)
	- `CREATE TABLE \`death\``
- [SQL/tgstation_schema_prefixed.sql](/SQL/tgstation_schema_prefixed.sql)
	- `CREATE TABLE \`death\``
- [code/modules/mob/living/carbon/human/death.dm](/code/modules/mob/living/carbon/human/death.dm)
	- `/mob/living/carbon/human/death()`
- [code/modules/unit_tests/full_heal.dm](/code/modules/unit_tests/full_heal.dm)
	- `/datum/unit_test/full_heal_damage_types/Run()`
- [code/modules/unit_tests/mob_damage.dm](/code/modules/unit_tests/mob_damage.dm)
	- `/datum/unit_test/mob_damage/proc/verify_damage()`
	- `/datum/unit_test/mob_damage/proc/apply_damage()`
	- `/datum/unit_test/mob_damage/proc/set_damage()`
	- `/datum/unit_test/mob_damage/animal/verify_damage()`
	- `/datum/unit_test/mob_damage/animal/Run()`
	- `/datum/unit_test/mob_damage/animal/test_sanity_simple()`
- [code/datums/components/dejavu.dm](/code/datums/components/dejavu.dm)
	- `/datum/component/dejavu/Initialize()`
	- `/datum/component/dejavu/proc/rewind_living()`
- [code/modules/mob/living/carbon/damage_procs.dm](/code/modules/mob/living/carbon/damage_procs.dm)
	- `/mob/living/carbon/human/get_incoming_damage_modifier()`
	- `/mob/living/carbon/proc/get_damaged_bodyparts()`
	- `/mob/living/carbon/proc/get_damageable_bodyparts()`
	- `/mob/living/carbon/heal_bodypart_damage()`
	- `/mob/living/carbon/take_bodypart_damage()`
	- `/mob/living/carbon/heal_overall_damage()`
	- `/mob/living/carbon/take_overall_damage()`
- [code/modules/surgery/bodyparts/_bodyparts.dm](/code/modules/surgery/bodyparts/_bodyparts.dm)
	- `/obj/item/bodypart/examine()`
	- `/obj/item/bodypart/proc/check_for_injuries()`
	- `/obj/item/bodypart/proc/receive_damage()`
	- `/obj/item/bodypart/proc/heal_damage()`
	- `/obj/item/bodypart/proc/set_initial_damage()`
	- `/obj/item/bodypart/proc/get_damage()`
	- `/obj/item/bodypart/proc/update_disabled()`
	- `/obj/item/bodypart/proc/update_bodypart_damage_state()`
- [code/modules/mob/living/carbon/human/human.dm](/code/modules/mob/living/carbon/human/human.dm)
	- `/mob/living/carbon/human/Topic()`
- [code/modules/mob/living/carbon/examine.dm](/code/modules/mob/living/carbon/examine.dm)
	- `/mob/living/carbon/examine()`
- [code/modules/mob/living/simple_animal/simple_animal.dm](/code/modules/mob/living/simple_animal/simple_animal.dm)
	- `var/list/damage_coeff`
- [code/modules/mob/living/basic/basic.dm](/code/modules/mob/living/simple_animal/simple_animal.dm)
	- `var/list/damage_coeff`
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g:
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Modular Overrides:

- [modular_darkpack/master_files/code/modules/mob/living/living_defines.dm](/modular_darkpack/master_files/code/modules/mob/living/living_defines.dm): `var/aggloss = 0`
- [modular_darkpack/master_files/code/datums/components/dejavu.dm](/modular_darkpack/master_files/code/datums/components/dejavu.dm): `var/aggravated_loss = 0`
- [modular_darkpack/master_files/code/modules/mob/living/carbon/human/physiology.dm](/modular_darkpack/master_files/code/modules/mob/living/carbon/human/physiology.dm): `var/aggravated_mod = 1`
- [modular_darkpack/master_files/code/modules/surgery/bodyparts/_bodyparts.dm](/modular_darkpack/master_files/code/modules/surgery/bodyparts/_bodyparts.dm):
	- `var/aggravated_dam = 0`
	- `var/aggravated_modifier = 1`
	- `var/light_aggravated_msg = "bruised and feels numb"`
	- `var/medium_aggravated_msg = "torn apart"`
	- `var/heavy_aggravated_msg = "like pieces are falling off"`
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g:
- `modular_nova/master_files/sound/my_cool_sound.ogg`
- `modular_nova/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Defines:

- [code/\_\_DEFINES/~darkpack/aggravated_damage.dm](/code/__DEFINES/~darkpack/aggravated_damage.dm):
	- `#define AGGRAVATED "aggravated"`
	- `#define AGGLOSS (1<<8)`
	- `#define COMSIG_LIVING_ADJUST_AGGRAVATED_DAMAGE "living_adjust_aggravated_damage"`
	- `#define HEAL_AGGRAVATED (1<<19)`
	- `#define MAX_REVIVE_AGGRAVATED_DAMAGE 100`
  <!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- [code/\_\_DEFINES/~darkpack/aggravated_damage.dm](/code/__DEFINES/~darkpack/aggravated_damage.dm)
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

- Created by @TheCarnalest

<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
