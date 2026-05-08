// spider infestation event where a nest of spiders emerges somewhere in the city! oh no!
/obj/effect/landmark/spider_spawn
	name = "spider spawn"

/mob/living/basic/spider/growing/young/event

/mob/living/basic/spider/growing/young/event/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOB_CHANGED_TYPE, PROC_REF(on_grown))

/mob/living/basic/spider/growing/young/event/proc/on_grown(datum/source, mob/living/basic/spider/giant/grown)
	SIGNAL_HANDLER
	var/matrix/spooder_size = matrix()
	spooder_size.Scale(0.7, 0.7) // so theyre big, but not tg station big
	grown.transform = spooder_size

/mob/living/basic/spider/giant/set_name()
	. = ..()
	name = "giant tarantula"
	real_name = name
