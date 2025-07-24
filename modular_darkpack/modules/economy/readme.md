<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/DarkPack13/SecondCity/pull/14<!--PR Number-->

## Economy <!--Title of your addition.-->

Module ID: ECONOMY <!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:

<!-- Here, try to describe what your PR does, what features it provides and any other directly useful information. -->

### TG Proc/File Changes:

<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g:
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

- `code/game/objects/items/cards_ids.dm`: `proc/obj/item/card/id/Initialize`, `proc/obj/item/card/id/examine`
- `code/modules/jobs/job_types/_job.dm`: `proc/datum/outfit/job/post_equip`
- `modular_darkpack/master_files/code/modules/economy/account.dm`: `/datum/bank_account/New`

### Modular Overrides:

- `modular_darkpack/master_files/code/modules/economy/account.dm`
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g:
- `modular_nova/master_files/sound/my_cool_sound.ogg`
- `modular_nova/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Defines:

- `code/__DEFINES/~darkpack/economy.dm`: `#define is_creditcard()`
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- `code/__DEFINES/~darkpack/economy.dm`
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
