// disposable duffelbag for putting loadout items in
// rather than rewrite storage code to account for lots of loadout items or dropping them on the ground at spawn
/obj/item/storage/backpack/duffelbag/loadout
	name = "disposable bag"
	desc = "A bag for delivering your stuff. Has no other use."

/obj/item/storage/backpack/duffelbag/loadout/Initialize(mapload)
	. = ..()
	RegisterSignal(atom_storage, COMSIG_STORAGE_REMOVED_ITEM, PROC_REF(on_item_removed))

/obj/item/storage/backpack/duffelbag/loadout/proc/on_item_removed(datum/storage/source, obj/item/removed, atom/remove_to_loc, silent = FALSE)
	SIGNAL_HANDLER
	if(length(src.contents) || istype(loc, /mob))
		return
	qdel(src)

/obj/item/storage/backpack/duffelbag/loadout/dropped(mob/user)
	. = ..()
	if(!length(src.contents))
		qdel(src)
