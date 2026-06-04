// ambient soundscapes, mostly from bloodlines 1
/area/vtm
	ambient_buzz = null

var/static/list/ocean_waves = list(
	'modular_tfn/modules/ambience/sound/ocean/waves_1.ogg',
	'modular_tfn/modules/ambience/sound/ocean/waves_2.ogg',
	'modular_tfn/modules/ambience/sound/ocean/waves_3.ogg',
	'modular_tfn/modules/ambience/sound/ocean/waves_4.ogg',
	'modular_tfn/modules/ambience/sound/ocean/waves_6.ogg',
	'modular_tfn/modules/ambience/sound/ocean/waves_7.ogg',
	'modular_tfn/modules/ambience/sound/ocean/waves_9.ogg',
)

var/static/list/stems = list(
	'modular_tfn/modules/ambience/sound/stems/vampire_extra_musicstem2.ogg',
	'modular_tfn/modules/ambience/sound/stems/vampire_extra_musicstem10.ogg',
	'modular_tfn/modules/ambience/sound/stems/vampire_extra_musicstem11.ogg',
)

var/static/list/nature_noises = list(
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/bats_flapping2.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/bats_flapping3.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/cricket_1.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/cricket_2.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/cricket_single1.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/cricket_single2.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/cricket_single3.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/crows_1.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/hedge_movement.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/hedge_movement2.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/hedge_movement3.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/hedge_movement4.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/hedge_movement5.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/owl3.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/raven1.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/raven2.ogg',
	'modular_tfn/modules/ambience/sound/outdoors/forest_sounds/raven4.ogg',
)

var/static/list/sewer_noises = list(
	'modular_tfn/modules/ambience/sound/sewer/pipes_cooling2.ogg',
	'modular_tfn/modules/ambience/sound/sewer/running_pipes8.ogg',
	'modular_tfn/modules/ambience/sound/sewer/water_dribbling_01.ogg',
)

var/static/list/city_noises = list(
	'modular_tfn/modules/ambience/sound/city/airliner_overhead_1.ogg',
	'modular_tfn/modules/ambience/sound/city/airliner_overhead_2.ogg',
	'modular_tfn/modules/ambience/sound/city/airliner_overhead_3.ogg',
	'modular_tfn/modules/ambience/sound/city/airliner_overhead_4.ogg',
	'modular_tfn/modules/ambience/sound/city/cars_passing_on_highway.ogg',
	'modular_tfn/modules/ambience/sound/city/truck_passing_3.ogg',
	'modular_tfn/modules/ambience/sound/city/truck_passing_4.ogg',
)

/mob/refresh_looping_ambience()
	if(!client || isobserver(client.mob))
		return
	var/area/my_area = get_area(src)
	var/sound_to_use = my_area.ambient_buzz
	var/volume_modifier = client.prefs.read_preference(/datum/preference/numeric/volume/sound_ship_ambience_volume)
	if(!sound_to_use || !volume_modifier || HAS_TRAIT(src, TRAIT_DEAF))
		SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = CHANNEL_BUZZ))
		client.current_ambient_sound = null
		return
	if(sound_to_use == client.current_ambient_sound)
		return
	client.current_ambient_sound = sound_to_use
	SEND_SOUND(src, sound(sound_to_use, repeat = 1, wait = 0, volume = my_area.ambient_buzz_vol * (volume_modifier / 100), channel = CHANNEL_BUZZ))

/area/vtm/outside/proc/stop_ocean_ambience(mob/M)
	if(!M.client)
		return
	SEND_SOUND(M, sound(null, repeat = 0, wait = 0, channel = CHANNEL_AMBIENCE))

/datum/component/vtm_ambience
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/ambience_timer
	var/sound/active_positional_sound
	var/turf/positional_sound_source
	var/positional_sound_max_dist = 0
	var/positional_sound_timer
	var/obj/structure/flora/bush/nature_sound_bush
	COOLDOWN_DECLARE(stem_cooldown)
	COOLDOWN_DECLARE(noise_cooldown)

/datum/component/vtm_ambience/Initialize(...)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/M = parent
	M.become_area_sensitive(type)
	RegisterSignal(M, COMSIG_ENTER_AREA, PROC_REF(on_entering))
	RegisterSignal(M, COMSIG_MOB_LOGOUT, PROC_REF(on_logout))
	on_entering(M, get_area(M))

/datum/component/vtm_ambience/Destroy(...)
	var/mob/M = parent
	REMOVE_TRAIT(M, TRAIT_AREA_SENSITIVE, type)
	UnregisterSignal(M, list(COMSIG_ENTER_AREA, COMSIG_MOB_LOGOUT, COMSIG_MOVABLE_MOVED))
	deltimer(ambience_timer)
	deltimer(positional_sound_timer)
	active_positional_sound = null
	positional_sound_source = null
	positional_sound_max_dist = 0
	positional_sound_timer = null
	nature_sound_bush = null
	return ..()

/datum/component/vtm_ambience/proc/on_logout(mob/source)
	SIGNAL_HANDLER
	deltimer(ambience_timer)
	ambience_timer = null

/datum/component/vtm_ambience/proc/try_play_stem(mob/M, volume, chance = 100)
	if(!COOLDOWN_FINISHED(src, stem_cooldown) || !prob(chance))
		return
	var/stem_file = pick(stems)
	var/stem_length = SSsounds.get_sound_length(stem_file)
	SEND_SOUND(M, sound(stem_file, repeat = 0, wait = 0, volume = volume * 0.3, channel = CHANNEL_AMBIENCE_STEMS))
	COOLDOWN_START(src, stem_cooldown, stem_length)

/datum/component/vtm_ambience/proc/try_play_nature_sounds(mob/living/M, volume, chance = 100)
	if(!COOLDOWN_FINISHED(src, noise_cooldown) || !prob(chance))
		return
	var/list/nearby = list()
	for(var/obj/structure/flora/bush/bush in range(7, M))
		if(get_dist(M, bush) >= 4)
			nearby += bush
	if(!length(nearby))
		return
	var/obj/structure/flora/bush/target = pick(nearby)
	var/noise_file = pick(nature_noises)
	var/noise_length = SSsounds.get_sound_length(noise_file)

	nature_sound_bush = target
	target.balloon_alert(M, "♪")
	play_positional_sound(M, noise_file, noise_length, get_turf(target), volume)

	COOLDOWN_START(src, noise_cooldown, noise_length)

/datum/component/vtm_ambience/proc/play_positional_sound(mob/M, noise_file, noise_length, turf/source, volume, environment = SOUND_ENVIRONMENT_NONE, max_distance = 15)
	positional_sound_source = source
	positional_sound_max_dist = max_distance
	active_positional_sound = sound(noise_file, repeat = 0, wait = 0, channel = CHANNEL_AMBIENCE_POSITIONAL)
	active_positional_sound.volume = volume
	active_positional_sound.falloff = 2
	active_positional_sound.y = 1
	active_positional_sound.environment = environment

	update_positional_sound(M)
	active_positional_sound.status = SOUND_UPDATE

	UnregisterSignal(M, COMSIG_MOVABLE_MOVED)
	RegisterSignal(M, COMSIG_MOVABLE_MOVED, PROC_REF(update_positional_sound))
	positional_sound_timer = addtimer(CALLBACK(src, PROC_REF(stop_positional_sound), M), noise_length, TIMER_STOPPABLE)

/datum/component/vtm_ambience/proc/update_positional_sound(mob/M)
	SIGNAL_HANDLER
	if(!active_positional_sound || !positional_sound_source)
		return
	var/turf/listener_turf = get_turf(M)
	if(!listener_turf)
		return
	if(positional_sound_max_dist && get_dist(listener_turf, positional_sound_source) > positional_sound_max_dist)
		stop_positional_sound(M)
		return
	active_positional_sound.x = positional_sound_source.x - listener_turf.x
	active_positional_sound.z = positional_sound_source.y - listener_turf.y
	SEND_SOUND(M, active_positional_sound)

/datum/component/vtm_ambience/proc/stop_positional_sound(mob/M)
	if(!active_positional_sound)
		return
	deltimer(positional_sound_timer)
	positional_sound_timer = null
	UnregisterSignal(M, COMSIG_MOVABLE_MOVED)
	SEND_SOUND(M, sound(null, repeat = 0, wait = 0, channel = CHANNEL_AMBIENCE_POSITIONAL))
	active_positional_sound = null
	positional_sound_source = null
	positional_sound_max_dist = 0
	nature_sound_bush = null

/datum/component/vtm_ambience/proc/play_forest_ambience(mob/M, volume = 75)
	if(HAS_TRAIT(M, TRAIT_DEAF))
		return 1 MINUTES
	var/base_volume = volume * (M.client?.prefs.read_preference(/datum/preference/numeric/volume/sound_ambience_volume) / 100)
	try_play_stem(M, base_volume, 5)
	try_play_nature_sounds(M, base_volume, 50)
	return 1 MINUTES

/datum/component/vtm_ambience/proc/play_oneshot(mob/M, list/sound_list, volume)
	var/sound_file = pick(sound_list)
	SEND_SOUND(M, sound(sound_file, repeat = 0, wait = 0, volume = volume, channel = CHANNEL_AMBIENCE))
	return SSsounds.get_sound_length(sound_file)

/datum/component/vtm_ambience/proc/play_ocean_ambience(mob/M, volume = 75)
	if(HAS_TRAIT(M, TRAIT_DEAF))
		return 1 MINUTES
	var/volume_modifier = (M.client?.prefs.read_preference(/datum/preference/numeric/volume/sound_ambience_volume)) / 100
	var/base_volume = volume * volume_modifier

	var/list/nearby_ocean = list()
	for(var/turf/ocean_turf in range(10, M))
		if(!istype(ocean_turf, /turf/open/water/beach/vamp))
			continue
		if(get_dist(M, ocean_turf) >= 4)
			nearby_ocean += ocean_turf

	var/noise_file = pick(ocean_waves)
	var/noise_length = SSsounds.get_sound_length(noise_file)

	if(length(nearby_ocean))
		play_positional_sound(M, noise_file, noise_length, pick(nearby_ocean), base_volume)

	try_play_stem(M, base_volume, 5)
	var/area/ocean_area = get_area(M)
	return noise_length + rand(ocean_area.min_ambience_cooldown, ocean_area.max_ambience_cooldown)

/datum/component/vtm_ambience/proc/play_city_ambience(mob/M, volume = 75)
	if(HAS_TRAIT(M, TRAIT_DEAF))
		return 1 MINUTES
	var/base_volume = volume * (M.client?.prefs.read_preference(/datum/preference/numeric/volume/sound_ambience_volume) / 100)
	var/adjusted_volume = (prob(50) && (base_volume - 10 > 0)) ? base_volume - 20 : base_volume

	var/list/nearby_asphalt = list()
	for(var/turf/open/floor/plating/asphalt/asphalt_turf in range(10, M))
		if(get_dist(M, asphalt_turf) >= 6)
			nearby_asphalt += asphalt_turf

	var/noise_file = pick(city_noises)
	var/noise_length = SSsounds.get_sound_length(noise_file)

	if(length(nearby_asphalt) && prob(25))
		play_positional_sound(M, noise_file, noise_length, pick(nearby_asphalt), adjusted_volume - 10)

	try_play_stem(M, base_volume, 5)
	var/area/city_area = get_area(M)
	return noise_length + rand(city_area.min_ambience_cooldown, city_area.max_ambience_cooldown)

/datum/component/vtm_ambience/proc/play_sewer_ambience(mob/M, volume = 75)
	if(HAS_TRAIT(M, TRAIT_DEAF))
		return 1 MINUTES
	var/base_volume = volume * (M.client?.prefs.read_preference(/datum/preference/numeric/volume/sound_ambience_volume) / 100)

	var/list/nearby_pipes = list()
	for(var/obj/structure/vampipe/pipe in range(10, M))
		if(get_dist(M, pipe) >= 6)
			nearby_pipes += pipe

	var/noise_file = pick(sewer_noises)
	var/noise_length = SSsounds.get_sound_length(noise_file)

	if(!length(nearby_pipes))
		return 10 SECONDS

	var/obj/structure/vampipe/target = pick(nearby_pipes)
	play_positional_sound(M, noise_file, noise_length, get_turf(target), base_volume, SOUND_ENVIRONMENT_SEWER_PIPE, 12)

	var/area/sewer_area = get_area(M)
	return noise_length + rand(sewer_area.min_ambience_cooldown, sewer_area.max_ambience_cooldown)

/datum/component/vtm_ambience/proc/tick_sewer_ambience(area/vtm/interior/sewer/source_area)
	var/mob/M = parent
	if(QDELETED(M) || !istype(get_area(M), /area/vtm/interior/sewer))
		return
	ambience_timer = addtimer(CALLBACK(src, PROC_REF(tick_sewer_ambience), source_area), play_sewer_ambience(M), TIMER_STOPPABLE)

// could do maybe a var on the areas to determine their type (forest, ocean, city, etc.) but this works for now
/datum/component/vtm_ambience/proc/tick_forest_ambience(area/vtm/source_area)
	var/mob/M = parent
	if(QDELETED(M) || !istype(get_area(M), /area/vtm/outside/forest) && !istype(get_area(M), /area/vtm/planetgeneration))
		return
	ambience_timer = addtimer(CALLBACK(src, PROC_REF(tick_forest_ambience), source_area), play_forest_ambience(M), TIMER_STOPPABLE)

/datum/component/vtm_ambience/proc/tick_ocean_ambience(area/vtm/outside/source_area)
	var/mob/M = parent
	var/area/current = get_area(M)
	if(QDELETED(M) || !istype(current, /area/vtm/outside/baywalk) && !istype(current, /area/vtm/outside/northbeach) && !istype(current, /area/vtm/outside/fishermanswharf))
		return
	ambience_timer = addtimer(CALLBACK(src, PROC_REF(tick_ocean_ambience), source_area), play_ocean_ambience(M), TIMER_STOPPABLE)

/datum/component/vtm_ambience/proc/tick_city_ambience(area/vtm/outside/source_area)
	var/mob/M = parent
	var/area/current = get_area(M)
	if(QDELETED(M) || !istype(current, /area/vtm/outside) || istype(current, /area/vtm/outside/forest))
		return
	ambience_timer = addtimer(CALLBACK(src, PROC_REF(tick_city_ambience), source_area), play_city_ambience(M), TIMER_STOPPABLE)

/datum/component/vtm_ambience/proc/on_entering(mob/source, area/new_area)
	SIGNAL_HANDLER
	deltimer(ambience_timer)
	if(istype(new_area, /area/vtm/outside/forest) || istype(new_area, /area/vtm/planetgeneration))
		INVOKE_ASYNC(src, PROC_REF(tick_forest_ambience), new_area)
	else if(istype(new_area, /area/vtm/outside/baywalk) || istype(new_area, /area/vtm/outside/northbeach) || istype(new_area, /area/vtm/outside/fishermanswharf))
		INVOKE_ASYNC(src, PROC_REF(tick_ocean_ambience), new_area)
	else if(istype(new_area, /area/vtm/outside))
		INVOKE_ASYNC(src, PROC_REF(tick_city_ambience), new_area)
	else if(istype(new_area, /area/vtm/interior/sewer))
		INVOKE_ASYNC(src, PROC_REF(tick_sewer_ambience), new_area)

/mob/living/Login()
	. = ..()
	src.AddComponent(/datum/component/vtm_ambience)

/area/vtm/outside
	ambient_buzz = 'modular_tfn/modules/ambience/sound/city/downtown_main.ogg'
	ambient_buzz_vol = 30

/area/vtm/outside/forest
	ambient_buzz = 'modular_tfn/modules/ambience/sound/outdoors/outdoors1.ogg'
	ambient_buzz_vol = 30

/area/vtm/planetgeneration
	ambient_buzz = 'modular_tfn/modules/ambience/sound/outdoors/outdoors1.ogg'
	ambient_buzz_vol = 30

/area/vtm/planetgeneration/woodland
	ambient_buzz = 'modular_tfn/modules/ambience/sound/outdoors/outdoors1.ogg'
	ambient_buzz_vol = 30

/area/vtm/outside/baywalk
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 30
	ambientsounds = list()

/area/vtm/outside/baywalk/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/outside/northbeach
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 30
	ambientsounds = list()

/area/vtm/outside/northbeach/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/outside/fishermanswharf
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 28
	ambientsounds = list()

/area/vtm/outside/fishermanswharf/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/interior/sewer
	ambient_buzz = 'modular_tfn/modules/ambience/sound/sewer/sewer_ambience.ogg'
	ambient_buzz_vol = 30
