// area overrides for our ambience module
/area/vtm
	ambient_buzz = null

/area/vtm/play_ambience(mob/M, client/C, volume)
	return

/area/vtm/outside/proc/stop_ocean_ambience(mob/M)
	if(!M.client)
		return
	SEND_SOUND(M, sound(null, repeat = 0, wait = 0, channel = CHANNEL_AMBIENCE))

// the main background noise for areas, using the existing ambient_buzz
/area/vtm/outside
	ambient_buzz = 'modular_tfn/modules/ambience/sound/city/downtown_main.ogg'
	ambient_buzz_vol = 30
	max_ambience_cooldown = 30 SECONDS

/area/vtm/outside/forest
	ambient_buzz = 'modular_tfn/modules/ambience/sound/outdoors/outdoors1.ogg'
	ambient_buzz_vol = 30
	max_ambience_cooldown = 10 SECONDS

/area/vtm/planetgeneration
	ambient_buzz = 'modular_tfn/modules/ambience/sound/outdoors/outdoors1.ogg'
	ambient_buzz_vol = 30

/area/vtm/planetgeneration/woodland
	ambient_buzz = 'modular_tfn/modules/ambience/sound/outdoors/outdoors1.ogg'
	ambient_buzz_vol = 30

/area/vtm/outside/baywalk
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 30
	max_ambience_cooldown = 10 SECONDS

/area/vtm/outside/baywalk/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/outside/northbeach
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 30
	max_ambience_cooldown = 10 SECONDS

/area/vtm/outside/northbeach/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/outside/fishermanswharf
	ambient_buzz = 'modular_tfn/modules/ambience/sound/ocean/surf_lite_loop.ogg'
	ambient_buzz_vol = 28
	max_ambience_cooldown = 10 SECONDS

/area/vtm/outside/fishermanswharf/Exited(atom/movable/AM, area/new_area)
	. = ..()
	if(ismob(AM))
		stop_ocean_ambience(AM)

/area/vtm/interior/sewer
	ambient_buzz = 'modular_tfn/modules/ambience/sound/sewer/sewer_ambience.ogg'
	ambient_buzz_vol = 30

/area/vtm/interior/hotel
	max_ambience_cooldown = 90 SECONDS

/area/vtm/interior/shop
	max_ambience_cooldown = 90 SECONDS
