/datum/voicepack/human/female/haughty/get_sound(key)
	var/used
	switch(key)
		if("giggle")
			used = list(
				'modular_tfn/modules/emotes/sound/vo/female/haughty/giggle_1.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/giggle_2.ogg',
			)
		if("sigh")
			used = list(
				'modular_tfn/modules/emotes/sound/vo/female/haughty/sigh_1.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/sigh_2.ogg',
			)
		if("gasp")
			used = list('modular_tfn/modules/emotes/sound/vo/female/haughty/gasp_2.ogg')
		if("cackle")
			used = list('modular_tfn/modules/emotes/sound/vo/female/haughty/cackle_1.ogg')
		if("chuckle")
			used = list(
				'modular_tfn/modules/emotes/sound/vo/female/haughty/chuckle_1.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/chuckle_2.ogg',
			)
		if("laugh")
			used = list(
				'modular_tfn/modules/emotes/sound/vo/female/haughty/laugh_2.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/laugh_3.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/laugh_4.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/old/noble/laugh_1.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/old/noble/laugh_2.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/old/noble/laugh_3.ogg',
			)
		if("painscream", "scream")
			used = list(
				'modular_tfn/modules/emotes/sound/vo/female/haughty/painscream_1.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/painscream_2.ogg',
			)
		if("painmoan")
			used = list(
				'modular_tfn/modules/emotes/sound/vo/female/haughty/painmoan_1.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/painmoan_2.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/painmoan_3.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/painmoan_4.ogg',
			)
		if("paincrit")
			used = list(
				'modular_tfn/modules/emotes/sound/vo/female/haughty/paincrit_1.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/paincrit_2.ogg',
				'modular_tfn/modules/emotes/sound/vo/female/haughty/paincrit_3.ogg',
			)
	if(!used)
		used = ..()
	return used
