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

/mob
	COOLDOWN_DECLARE(stem_cooldown)
	/// Whether the outdoor ambience loop is currently playing for this mob.
	var/playing_outdoor_loop = FALSE

// refresh ambience override
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

// override for coastal areas
/area/vtm/outside/proc/play_ocean_ambience(mob/M, volume = 27)
	if(HAS_TRAIT(M, TRAIT_DEAF))
		return

	var/volume_modifier = (M.client?.prefs.read_preference(/datum/preference/numeric/volume/sound_ambience_volume)) / 100

	var/wave_file = pick(ocean_waves)
	var/sound/wave_sound = sound(wave_file, repeat = 0, wait = 0, volume = volume * volume_modifier, channel = CHANNEL_AMBIENCE)
	SEND_SOUND(M, wave_sound)

	var/sound_length = SSsounds.get_sound_length(wave_file)

	if(prob(50) && COOLDOWN_FINISHED(M, stem_cooldown))
		var/stem_file = pick(stems)
		var/stem_length = SSsounds.get_sound_length(stem_file)
		var/sound/stem_sound = sound(stem_file, repeat = 0, wait = 0, volume = volume * volume_modifier * 0.7, channel = CHANNEL_AMBIENCE_STEMS)
		SEND_SOUND(M, stem_sound)
		COOLDOWN_START(M, stem_cooldown, stem_length + 3 SECONDS)

	return sound_length + rand(min_ambience_cooldown, max_ambience_cooldown)

/area/vtm/outside/proc/stop_ocean_ambience(mob/M)
	if(!M.client)
		return
	SEND_SOUND(M, sound(null, repeat = 0, wait = 0, channel = CHANNEL_AMBIENCE))
	//SEND_SOUND(M, sound(null, repeat = 0, wait = 0, channel = CHANNEL_AMBIENCE_STEMS))

/area/vtm/outside/play_forest_ambience(mob/M, volume = 27)
	if(HAS_TRAIT(M, TRAIT_DEAF))
		return 1 MINUTES

	var/base_volume = volume * (M.client?.prefs.read_preference(/datum/preference/numeric/volume/sound_ambience_volume) / 100)
	var/adjusted_volume = (prob(50) && (base_volume - 10 > 0)) ? base_volume - 10 : base_volume

	if(!M.playing_outdoor_loop)
		SEND_SOUND(M, sound('modular_tfn/modules/ambience/sound/outdoors/outdoors1.ogg', repeat = 1, wait = 0, volume = adjusted_volume, channel = CHANNEL_AMBIENCE))
		M.playing_outdoor_loop = TRUE

	if(prob(50) && COOLDOWN_FINISHED(M, stem_cooldown))
		var/stem_file = pick(stems)
		var/stem_length = SSsounds.get_sound_length(stem_file)
		SEND_SOUND(M, sound(stem_file, repeat = 0, wait = 0, volume = adjusted_volume * 0.7, channel = CHANNEL_AMBIENCE_STEMS))
		COOLDOWN_START(M, stem_cooldown, stem_length + 3 SECONDS)

	return 1 MINUTES

/area/vtm/outside/proc/stop_forest_ambience(mob/M)
	if(!M.client)
		return
	SEND_SOUND(M, sound(null, repeat = 0, wait = 0, channel = CHANNEL_AMBIENCE))
	M.playing_outdoor_loop = FALSE

/area/vtm/outside
	ambient_buzz = 'modular_tfn/modules/ambience/sound/city/downtown_main.ogg'
	ambient_buzz_vol = 30

/area/vtm/outside/forest
	ambient_buzz = null
	ambient_buzz_vol = 30

/area/vtm/outside/forest/play_ambience(mob/M, sound/override_sound, volume)
	return play_forest_ambience(M, volume)

/area/vtm/outside/forest/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_forest_ambience(AM)

/area/vtm/planetgeneration/play_ambience(mob/M, sound/override_sound, volume)
	return play_forest_ambience(M, volume)

/area/vtm/planetgeneration/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_forest_ambience(AM)


/area/vtm/outside/baywalk
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 30
	ambientsounds = list()

/area/vtm/outside/baywalk/play_ambience(mob/M, sound/override_sound, volume)
	return play_ocean_ambience(M, volume)

/area/vtm/outside/baywalk/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/outside/northbeach
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 30
	ambientsounds = list()

/area/vtm/outside/northbeach/play_ambience(mob/M, sound/override_sound, volume)
	return play_ocean_ambience(M, volume)

/area/vtm/outside/northbeach/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/outside/fishermanswharf
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 28
	ambientsounds = list()

/area/vtm/outside/fishermanswharf/play_ambience(mob/M, sound/override_sound, volume)
	return play_ocean_ambience(M, volume)

/area/vtm/outside/fishermanswharf/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)
