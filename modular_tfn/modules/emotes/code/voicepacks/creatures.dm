/datum/voicepack/werewolf

/datum/voicepack/werewolf/get_sound(key)
	var/used
	switch(key)
		if("aggro", "rage")
			used = 'modular_tfn/modules/emotes/sound/vo/mobs/wwolf/roar.ogg'
		if("deathgurgle")
			used = 'modular_tfn/modules/emotes/sound/vo/mobs/wwolf/death.ogg'
		if("firescream", "agony")
			used = 'modular_tfn/modules/emotes/sound/vo/mobs/wwolf/painscream.ogg'
		if("jump", "leap")
			used = list('modular_tfn/modules/emotes/sound/vo/mobs/wwolf/jump_1.ogg','modular_tfn/modules/emotes/sound/vo/mobs/wwolf/jump_2.ogg','modular_tfn/modules/emotes/sound/vo/mobs/wwolf/jump_3.ogg')
		if("pain", "paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/mobs/wwolf/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/mobs/wwolf/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/mobs/wwolf/pain_3.ogg')
		if("painscream")
			used = 'modular_tfn/modules/emotes/sound/vo/mobs/wwolf/painscream.ogg'
		if("scream", "howl")
			used = list('modular_tfn/modules/emotes/sound/vo/mobs/wwolf/howl_1.ogg','modular_tfn/modules/emotes/sound/vo/mobs/wwolf/howl_2.ogg')
	return used
