#define MAX_STARTUP_MESSAGES 10 // max messages displayed at once on the HUD
GLOBAL_LIST_EMPTY(startup_messages)

/mob/dead/new_player/proc/get_title_html()
	var/dat = SStitle.title_html
	if(SSticker.current_state == GAME_STATE_STARTUP)
		dat += {"<img src="loading_screen.png" class="bg" alt="">"}
		dat += {"
			<div class="container_tv">
				<img src="tv_static.gif" class="tv_screen" alt="">
				<div class="tv_crt"></div>
				<img src="tv_base.png" class="tv_frame" alt="">
			</div>
		"}
		dat += {"<div class="container_terminal" id="terminal"></div>"}
		dat += {"<div class="container_progress" id="progress_container"><div class="progress_bar" id="progress"></div></div>"}

		dat += {"
		<script language="JavaScript">
			var terminal = document.getElementById("terminal");
			var terminal_lines = \[
		"}

		for(var/message in GLOB.startup_messages)
			dat += {""[replacetext(message, "\"", "\\\"")]","}

		dat += {"
			\];

			function append_terminal_text(text) {
				if(text) {
					terminal_lines.push(text);
				}
				while(terminal_lines.length > [MAX_STARTUP_MESSAGES]) {
					terminal_lines.shift();
				}

				terminal.innerHTML = terminal_lines.join("");
			}

			append_terminal_text();

			var progress_bar = document.getElementById("progress");
			var progress_current_position = 0;

			function update_loading_progress(received, expected) {
				expected = parseFloat(expected);
				if (!expected) {
					return;
				}
				progress_current_position = Math.min(Math.max(parseFloat(received) / expected * 100, progress_current_position), 95);
				progress_bar.style.width = "" + progress_current_position + "%";
			}

			function update_current_character() {}
			function update_tv_info() {}
		</script>
		"}

	else
		dat += {"<img src="loading_screen.png" class="bg" alt="">"}

		dat += {"
			<div class="container_tv">
				<img src="tv_on.png" class="tv_screen" alt="">
				<div class="tv_text">
					<span id="tv_active">[LAZYLEN(GLOB.clients)] logged in</span>
					<span id="tv_spawned">[LAZYLEN(GLOB.alive_player_list) > 0 ? "[LAZYLEN(GLOB.alive_player_list)] in the city" : ""]</span>
					<span id="tv_timer">[round_timestamp()]</span>
				</div>
				<div class="tv_crt"></div>
				<img src="tv_base.png" class="tv_frame" alt="">
			</div>
		"}

		dat += {"
			<div class="container_title">
				<span id="intro-text">these are...</span>
				<div class="title_wrap">
					<span id="main-title"></span>
					<span id="subtitle"></span>
				</div>
			</div>
		"}

		if(SStitle.current_notice)
			dat += {"
			<div class="container_notice">
				<p class="menu_notice">[SStitle.current_notice]</p>
			</div>
		"}

		dat += {"<div class="container_nav">"}

		if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
			dat += {"<a id="ready" class="menu_button" href='byond://?src=[text_ref(src)];toggle_ready=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>[ready == PLAYER_READY_TO_PLAY ? "<span class='checked'>☑</span> READY" : "<span class='unchecked'>☒</span> READY"]</a>"}
		else
			dat += {"
				<a class="menu_button" href='byond://?src=[text_ref(src)];late_join=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>Join Game</a>
				<a class="menu_button" href='byond://?src=[text_ref(src)];view_manifest=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>Manifest</a>
			"}

		dat += {"<a class="menu_button" href='byond://?src=[text_ref(src)];observe=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>Observe</a>"}

		dat += {"
			<a class="menu_button" href='byond://?src=[text_ref(src)];character_setup=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>Setup Character (<span id="character_slot">[client.prefs.read_preference(/datum/preference/name/real_name)]</span>)</a>
			<a class="menu_button" href='byond://?src=[text_ref(src)];game_options=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>Game Options</a>
			<a class="menu_button" href='byond://?src=[text_ref(src)];wiki=1' onmouseover='location.href="byond://?src=[text_ref(src)];button_hover=1"'>Wiki</a>
		"}

		if(!is_guest_key(src.key))
			dat += playerpolls()

		dat += "</div>"
		dat += {"
		<script language="JavaScript">
			var ready_int = 0;
			var ready_mark = document.getElementById("ready");
			var ready_marks = \[ "<span class='unchecked'>☒</span> Ready", "<span class='checked'>☑</span> Ready" \];
			function toggle_ready(setReady) {
				if(setReady) {
					ready_int = setReady;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
				else {
					ready_int++;
					if (ready_int === ready_marks.length)
						ready_int = 0;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
			}

			var character_name_slot = document.getElementById("character_slot");
			function update_current_character(name) {
				character_name_slot.textContent = name.toUpperCase();
			}

			var tv_active = document.getElementById("tv_active");
			var tv_spawned = document.getElementById("tv_spawned");
			var tv_timer = document.getElementById("tv_timer");
			function update_tv_info(active, spawned, timer) {
				tv_active.textContent = active + " logged in";
				tv_spawned.textContent = spawned > 0 ? spawned + " in the city" : "";
				tv_timer.textContent = timer;
			}

			function append_terminal_text() {}
			function update_loading_progress() {}
		</script>
		"}

		dat += {"
		<script language="JavaScript">
			(function() {
				var splashes = \[
					"As seen on TV!", "Awesome!", "Flashing letters!", "Mostly Made by Xeonmations!", "Gadabout approved!", "Made in Lithuania!",
					"World of Darkness!", "The bee's knees!", "Down with Lasombra!", "Open source!", "Not on steam!", "Awesome community!",
					"Pixels!", "Now with difficulty!", "Ask your doctor!", "Minors Not Welcome!", "Euclidian!", "Tell Xeon to grow their hair out!",
					"Free Palestine!", "Monster infighting!", "Loved by Malkavians!", "The Regime Knows Best!", "4815162342 lines of code!",
					"The Work of Xeon and Buffy!", "Bomby used to be dead!", "I miss my childe!", "Now in color!", "The Rebase Knows Best!",
					"Dozer is the new top dog!", "Representing San Fran!", "Woo, Anarchs!", "Woo, dog girls!", "Woo, BYOND!", "Woo, Theo Bell!",
					"Now supports Tremere!", "Give us Trujah!", "Athena Sawyer has two first names!", "Powered by Monster!", "Haha, LOL!",
					"Running on Windows!", "Fully automatic!", "Is this your apartment?", "Yippee!", "Original!", "So fresh, so clean!",
					"Slow acting portals!", "Try the Sabbat!", "Don't look directly at the bugs!", "Oh, ok, Malkavian!", "Finally with Garou!",
					"Scary!", "Play World of Darkness!", "Powershell automated!", "Failing checks!", "Oriyirah is neat!", "Lore Team Takeover!",
					"Maintainer Shadow Government Approved!", "Welcome to your Doom!", "Age verified!", "'Almost never' is an interesting concept!",
					"Lots of truthiness!", "The Brujah is a spy!", "Turing complete!", "It's groundbreaking!", "Let our battles begin!",
					"The sky is the limit!", "Soreyew has amazing hair!", "Rosy has amazing art!", "Read more books!",
					"Less addictive than TV Tropes!", "Try the downstreams!", "Feature packed!", "Blood bags!", "Does barrel rolls!",
					"Meeting expectations!", "8th generation!", "You what?!", "Déjà vu!", "Déjà vu!", "Nimi!!"
				\];

				var titleElement = document.getElementById("main-title");
				var titleText = "The Final Nights";
				var titleBaseDelay = 1.0;
				var titleLetterDelayIncrement = 0.24;
				var titleLetterAnimationDuration = 3.0;
				var originalTitleHTML = "";

				titleElement.textContent = "";

				titleText.split("").forEach(function(char, index) {
					var span = document.createElement("span");
					span.classList.add("letter-span");
					if (char === " ") {
						span.classList.add("space-span");
						span.innerHTML = "&nbsp;";
					} else {
						span.innerHTML = char;
					}
					var delay = titleBaseDelay + index * titleLetterDelayIncrement;
					span.style.animationDelay = delay + "s";
					titleElement.appendChild(span);
				});

				originalTitleHTML = titleElement.innerHTML;

				var lastLetterStartTime = titleBaseDelay + (titleText.length - 1) * titleLetterDelayIncrement;
				var titleEndTime = lastLetterStartTime + titleLetterAnimationDuration;

				setTimeout(function() {
					titleElement.classList.add("initial-fade-complete");
				}, titleEndTime * 1000);

				var glitchTarget = document.getElementById("main-title");
				var glitchMinInterval = 25000;
				var glitchMaxInterval = 60000;
				var glitchDuration = 500;
				var randomWords = \[ "The Gehenna Nights", "The Sabbat Nights", "The Nimi Nights", "The Regime Knows Best", "The Xeon Nights", "The Day 'n Nites" \];

				function scheduleNextGlitch(delay) {
					setTimeout(triggerGlitch, delay);
				}

				function triggerGlitch() {
					if (glitchTarget && glitchTarget.classList.contains("initial-fade-complete")) {
						var randomWord = randomWords\[Math.floor(Math.random() * randomWords.length)\];
						glitchTarget.innerHTML = "";
						randomWord.split("").forEach(function(char) {
							var span = document.createElement("span");
							span.classList.add("letter-span");
							if (char === " ") {
								span.classList.add("space-span");
								span.innerHTML = "&nbsp;";
							} else {
								span.innerHTML = char;
							}
							span.style.opacity = "1";
							span.style.animation = "none";
							glitchTarget.appendChild(span);
						});

						glitchTarget.classList.add("glitching");

						setTimeout(function() {
							glitchTarget.classList.remove("glitching");
							glitchTarget.innerHTML = originalTitleHTML;
							glitchTarget.querySelectorAll(".letter-span").forEach(function(span) {
								span.style.opacity = "1";
								span.style.animation = "none";
								span.style.animationDelay = "0s";
							});
						}, glitchDuration);
					}
					var nextDelay = Math.random() * (glitchMaxInterval - glitchMinInterval) + glitchMinInterval;
					scheduleNextGlitch(nextDelay);
				}

				var initialGlitchWait = titleEndTime * 1000;
				setTimeout(function() {
					scheduleNextGlitch(Math.random() * (glitchMaxInterval - glitchMinInterval) + glitchMinInterval);
				}, initialGlitchWait);

				setTimeout(function() {
					var subtitleElement = document.getElementById("subtitle");
					if (subtitleElement) {
						var randomSplash = splashes\[Math.floor(Math.random() * splashes.length)\];
						subtitleElement.textContent = randomSplash;
					}
				}, initialGlitchWait);
			})();
		</script>
		"}

	if(!title_screen_is_ready)
		dat += {"
			<script>
				location.href = "byond://?src=[text_ref(src)];title_is_ready=1";
			</script>
		"}

	dat += "</body></html>"

	return dat

#undef MAX_STARTUP_MESSAGES
