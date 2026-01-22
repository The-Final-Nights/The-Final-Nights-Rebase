/obj/effect/decal/fakelattice
	name = "lattice"
	desc = "A lightweight support lattice."
	icon = 'icons/obj/smooth_structures/lattice.dmi'
	icon_state = "lattice-255"
	density = TRUE

//TFN EDIT ADD - Map
/obj/effect/decal/fakelattice/NeverShouldHaveComeHere(turf/here_turf)
	return FALSE
//TFN EDIT END
