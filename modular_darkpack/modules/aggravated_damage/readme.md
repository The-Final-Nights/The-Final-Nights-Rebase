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
- [code/modules/mob/living/living.dm](/code/modules/mob/living/living.dm):
	- `/mob/living/proc/updatehealth()`
	- `/mob/living/vv_get_header()`
	- `/mob/living/proc/heal_and_revive()`
	- `/mob/living/proc/fully_heal()`
- [code/modules/mob/living/carbon/carbon.dm](/code/modules/mob/living/carbon/carbon.dm)
	- `/mob/living/carbon/updatehealth()`
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
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g:
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Modular Overrides:

- [modular_darkpack/master_files/code/modules/mob/living/living_defines.dm](/modular_darkpack/master_files/code/modules/mob/living/living_defines.dm): `var/aggloss = 0`
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
  <!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- [code/\_\_DEFINES/~darkpack/aggravated_damage.dm](/code/__DEFINES/~darkpack/aggravated_damage.dm)
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

- Created by @TheCarnalest

<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
