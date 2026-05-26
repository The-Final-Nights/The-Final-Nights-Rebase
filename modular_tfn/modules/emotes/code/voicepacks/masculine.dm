/datum/voicepack/human/male/get_sound(key)
	var/used
	switch(key)
		if("attack")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/attack_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/attack_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/attack_3.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/attack_4.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/attack_5.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/attack_6.ogg')
		if("agony")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/agony_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/agony_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/agony_3.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/agony_4.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/agony_5.ogg')
		if("breathgasp")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/breathgasp_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/breathgasp_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/breathgasp_3.ogg')
		if("burp")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/burp.ogg'
		if("choke")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/choke.ogg'
		if("chuckle")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/chuckle.ogg'
		if("clearthroat")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/clearthroat_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/clearthroat_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/clearthroat_3.ogg')
		if("cough")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/cough_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/cough_2.ogg')
		if("cry", "sob")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/cry_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/cry_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/cry_3.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/cry_4.ogg')
		if("deathgurgle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/deathgurgle_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/deathgurgle_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/deathgurgle_3.ogg')
		if("drown")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/drown_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/drown_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/drown_3.ogg')
		if("embed")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/embed_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/embed_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/embed_3.ogg')
		if("fatigue")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/fatigue.ogg'
		if("firescream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/firescream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/firescream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/firescream_3.ogg')
		if("gag")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/gag_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/gag_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/gag_3.ogg')
		if("gasp")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/gasp.ogg'
		if("groan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/groan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/groan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/groan_3.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/groan_4.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/groan_5.ogg')
		if("grumble")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/grumble.ogg'
		if("haltyell")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/haltyell_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/haltyell_2.ogg')
		if("hmm")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/hmm.ogg'
		if("hmph")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/hmph_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/hmph_2.ogg')
		if("huh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/huh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/huh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/huh_3.ogg')
		if("hum")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/hum_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/hum_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/hum_3.ogg')
		if("jump")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/jump.ogg'
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/laugh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/laugh_3.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/laugh_4.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/laugh_5.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/laugh_6.ogg')
		if("leap")
			used = 'modular_tfn/modules/emotes/sound/vo/male/gen/leap.ogg'
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/pain_3.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/paincrit_2.ogg')
		if("painmoan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/painmoan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/painmoan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/painmoan_3.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/painmoan_4.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/painmoan_5.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/painscream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/painscream_3.ogg')
		if("rage")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/rage_1.ogg','modular_tfn/modules/emotes/sound/vo/male/gen/rage_2.ogg')
	return used


/datum/voicepack/human/male/foppish

/datum/voicepack/human/male/foppish/get_sound(key)
	var/used
	switch(key)
		if("attack")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/attack_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/attack_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/attack_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/attack_4.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/attack_5.ogg')
		if("cackle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/cackle_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/cackle_2.ogg')
		if("chuckle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/chuckle_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/chuckle_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/chuckle_3.ogg')
		if("clearthroat")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/clearthroat_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/clearthroat_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/clearthroat_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/clearthroat_4.ogg')
		if("cry", "sob")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/cry_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/cry_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/cry_3.ogg')
		if("gasp")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/gasp_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/gasp_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/gasp_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/gasp_4.ogg')
		if("giggle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/giggle_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/giggle_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/giggle_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/giggle_4.ogg')
		if("groan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/groan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/groanfrust_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/groanfrust_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/groanfrust_3.ogg')
		if("hmm")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/hmm_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hmm_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hmm_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hmm_4.ogg')
		if("hmph")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/hmph_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hmph_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hmph_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hmph_4.ogg')
		if("huh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/huh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/huh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/huh_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/huh_4.ogg')
		if("hum")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/hum_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hum_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hum_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/hum_4.ogg')
		if("jump")
			used = list('modular_tfn/modules/emotes/sound/vo/male/gen/jump.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/jump_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/jump_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/jump_3.ogg')
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/laugh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/laugh_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/laugh_5.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/laugh_6.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/laugh_7.ogg')
		if("moan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/moan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/moan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/moan_3.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/young/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/young/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/young/pain_3.ogg','modular_tfn/modules/emotes/sound/vo/male/young/pain_4.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/young/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/young/paincrit_2.ogg','modular_tfn/modules/emotes/sound/vo/male/young/paincrit_3.ogg')
		if("painmoan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/painmoan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/painmoan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/painmoan_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/painmoan_4.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/painscream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/painscream_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/painscream_4.ogg')
		if("pleased")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/pleased_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/pleased_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/pleased_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/pleased_4.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/pleased_5.ogg')
		if("rage")
			used = 'modular_tfn/modules/emotes/sound/vo/male/foppish/rage_1.ogg'
		if("sigh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/sigh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/sigh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/sigh_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/sigh_4.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/sigh_5.ogg')
		if("sniff")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/sniff.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/sniff_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/sniff_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/sniff_4.ogg')
		if("sneeze")
			used = 'modular_tfn/modules/emotes/sound/vo/male/foppish/sneeze.ogg'
		if("snore")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/snore_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/snore_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/snore_3.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/snore_4.ogg')
		if("yawn")
			used = list('modular_tfn/modules/emotes/sound/vo/male/foppish/yawn_1.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/yawn_2.ogg','modular_tfn/modules/emotes/sound/vo/male/foppish/yawn_3.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/stern

/datum/voicepack/human/male/stern/get_sound(key)
	var/used
	switch(key)
		if("attack")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/attack_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/attack_2.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/attack_3.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/attack_4.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/attack_5.ogg')
		if("chuckle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/chuckle_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/chuckle_2.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/chuckle_3.ogg')
		if("groan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/groan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/groan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/groan_3.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/groan_4.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/groan_5.ogg')
		if("hmm")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/hmm_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/hmm_2.ogg')
		if("huh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/huh_1.ogg')
		if("jump")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/jump_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/jump_2.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/jump_3.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/jump_4.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/jump_5.ogg')
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/laugh_2.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pain_3.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pain_4.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pain_5.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/paincrit_2.ogg')
		if("painmoan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/painmoan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/painmoan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/painmoan_3.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/painmoan_4.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/painscream_2.ogg')
		if("pleased")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/pleased_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pleased_2.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pleased_3.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pleased_4.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pleased_5.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/pleased_6.ogg')
		if("snore")
			used = list('modular_tfn/modules/emotes/sound/vo/male/stern/snore_1.ogg','modular_tfn/modules/emotes/sound/vo/male/stern/snore_2.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/warrior

/datum/voicepack/human/male/warrior/get_sound(key)
	var/used
	switch(key)
		if("firescream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/warrior/firescream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/firescream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/firescream_3.ogg')
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/warrior/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/laugh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/laugh_3.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/warrior/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_3.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_4.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_5.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_6.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_7.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_8.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_9.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/pain_10.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/warrior/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/paincrit_2.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/paincrit_3.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/warrior/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/painscream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/painscream_3.ogg')
		if("rage")
			used = list('modular_tfn/modules/emotes/sound/vo/male/warrior/rage_1.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/rage_2.ogg','modular_tfn/modules/emotes/sound/vo/male/warrior/rage_3.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/knight

/datum/voicepack/human/male/knight/get_sound(key)
	var/used
	switch(key)
		if("agony")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/agony_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/agony_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/agony_3.ogg')
		if("firescream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/firescream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/firescream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/firescream_3.ogg')
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/laugh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/laugh_3.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/laugh_4.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/pain_3.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/pain_4.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/pain_5.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/pain_6.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/paincrit_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/paincrit_3.ogg')
		if("painmoan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/painmoan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/painmoan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/painmoan_3.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/painmoan_4.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/painscream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/painscream_3.ogg')
		if("rage")
			used = list('modular_tfn/modules/emotes/sound/vo/male/knight/rage_1.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/rage_2.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/rage_3.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/rage_4.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/rage_5.ogg','modular_tfn/modules/emotes/sound/vo/male/knight/rage_6.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/elf

/datum/voicepack/human/male/elf/get_sound(key)
	var/used
	switch(key)
		if("agony")
			used = 'modular_tfn/modules/emotes/sound/vo/male/elf/agony.ogg'
		if("chuckle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/chuckle_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/chuckle_2.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/chuckle_3.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/chuckle_4.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/chuckle_5.ogg')
		if("cry", "sob")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/cry_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/cry_2.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/cry_3.ogg')
		if("embed")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/embed_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/embed_2.ogg')
		if("firescream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/firescream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/firescream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/firescream_3.ogg')
		if("gasp")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/gasp_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/gasp_2.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/gasp_3.ogg')
		if("grumble")
			used = 'modular_tfn/modules/emotes/sound/vo/male/elf/grumble.ogg'
		if("haltyell")
			used = 'modular_tfn/modules/emotes/sound/vo/male/elf/haltyell.ogg'
		if("huh")
			used = 'modular_tfn/modules/emotes/sound/vo/male/elf/huh.ogg'
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/laugh_3.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/pain_3.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/paincrit_2.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/paincrit_3.ogg')
		if("painmoan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/painmoan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/painmoan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/painmoan_3.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/painscream_2.ogg')
		if("rage")
			used = list('modular_tfn/modules/emotes/sound/vo/male/elf/rage_1.ogg','modular_tfn/modules/emotes/sound/vo/male/elf/rage_2.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/dwarf

/datum/voicepack/human/male/dwarf/get_sound(key)
	var/used
	switch(key)
		if("chuckle")
			used = 'modular_tfn/modules/emotes/sound/vo/male/dwarf/chuckle.ogg'
		if("cough")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/cough_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/cough_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/cough_3.ogg')
		if("firescream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/firescream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/firescream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/firescream_3.ogg')
		if("haltyell")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/haltyell_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/haltyell_2.ogg')
		if("hmm")
			used = 'modular_tfn/modules/emotes/sound/vo/male/dwarf/hmm.ogg'
		if("hum")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/hum_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/hum_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/hum_3.ogg')
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/laugh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/laugh_3.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/laugh_4.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/laugh_5.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/pain_3.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/paincrit_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/paincrit_3.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/painscream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/painscream_3.ogg')
		if("rage")
			used = list('modular_tfn/modules/emotes/sound/vo/male/dwarf/rage_1.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/rage_2.ogg','modular_tfn/modules/emotes/sound/vo/male/dwarf/rage_3.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/goblin

/datum/voicepack/human/male/goblin/get_sound(key)
	var/used
	switch(key)
		if("chuckle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/goblin/chuckle_1.ogg','modular_tfn/modules/emotes/sound/vo/male/goblin/chuckle_3.ogg')
		if("giggle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/goblin/giggle_2.ogg','modular_tfn/modules/emotes/sound/vo/male/goblin/giggle_3.ogg')
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/goblin/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/goblin/laugh_2.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/evil

/datum/voicepack/human/male/evil/get_sound(key)
	var/used
	switch(key)
		if("firescream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/evil/firescream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/firescream_2.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/firescream_3.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/firescream_4.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/firescream_5.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/firescream_6.ogg')
		if("grumble")
			used = 'modular_tfn/modules/emotes/sound/vo/male/evil/grumble.ogg'
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/evil/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/laugh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/laugh_3.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/laugh_4.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/laugh_5.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/laugh_6.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/laugh_7.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/laugh_8.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/evil/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/pain_3.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/pain_4.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/pain_5.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/pain_6.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/pain_7.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/pain_8.ogg')
		if("painmoan")
			used = list('modular_tfn/modules/emotes/sound/vo/male/evil/painmoan_1.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/painmoan_2.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/painmoan_3.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/painmoan_4.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/painmoan_5.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/evil/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/painscream_2.ogg')
		if("rage")
			used = list('modular_tfn/modules/emotes/sound/vo/male/evil/rage_1.ogg','modular_tfn/modules/emotes/sound/vo/male/evil/rage_2.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/wizard

/datum/voicepack/human/male/wizard/get_sound(key)
	var/used
	switch(key)
		if("laugh")
			used = 'modular_tfn/modules/emotes/sound/vo/male/wizard/laugh.ogg'
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/jester

/datum/voicepack/human/male/jester/get_sound(key)
	var/used
	switch(key)
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/jester/laugh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/jester/laugh_2.ogg','modular_tfn/modules/emotes/sound/vo/male/jester/laugh_3.ogg')
	if(!used)
		used = ..()
	return used


/datum/voicepack/human/male/zeth

/datum/voicepack/human/male/zeth/get_sound(key)
	var/used
	switch(key)
		if("chuckle")
			used = list('modular_tfn/modules/emotes/sound/vo/male/zeth/chuckle.ogg')
		if("grumble")
			used = list('modular_tfn/modules/emotes/sound/vo/male/zeth/grumble_1.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/grumble_2.ogg')
		if("laugh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/zeth/laugh.ogg')
		if("pain")
			used = list('modular_tfn/modules/emotes/sound/vo/male/zeth/pain_1.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/pain_2.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/pain_3.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/pain_4.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/pain_5.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/pain_6.ogg')
		if("paincrit")
			used = list('modular_tfn/modules/emotes/sound/vo/male/zeth/paincrit_1.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/paincrit_2.ogg')
		if("painscream", "scream")
			used = list('modular_tfn/modules/emotes/sound/vo/male/zeth/painscream_1.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/painscream_2.ogg')
		if("sigh")
			used = list('modular_tfn/modules/emotes/sound/vo/male/zeth/sigh_1.ogg','modular_tfn/modules/emotes/sound/vo/male/zeth/sigh_2.ogg')
	if(!used)
		used = ..()
	return used
