#!/bin/bash

#Run this in the repo root after compiling
#First arg is path to where you want to deploy
#creates a work tree free of everything except what's necessary to run the game

#second arg is working directory if necessary
if [[ $# -eq 2 ]] ; then
  cd $2
fi

mkdir -p \
    $1/_maps \
    $1/code/datums/greyscale/json_configs \
    $1/data/spritesheets \
    $1/icons \
    $1/sound/runtime \
    $1/strings \
    $1/tgui/public \
    $1/tgui/packages/tgfont/dist

if [ -d ".git" ]; then
  mkdir -p $1/.git/logs
  cp -r .git/logs/* $1/.git/logs/
fi
# DARKPACK EDIT ADDITION START - Get all the .dmis from modular_darkpack
mkdir -p \
		$1/modular_darkpack \

find modular_darkpack/ -name \*.dmi -exec cp --parents {} $1 \;
# DARKPACK EDIT ADDITION END

# TFN EDIT ADDITION START - Get all the .dmis from modular_tfn
mkdir -p \
		$1/modular_tfn \

find modular_tfn/ -name \*.dmi -exec cp --parents {} $1 \;
# TFN EDIT ADDITION END

cp tgstation.dmb tgstation.rsc $1/
cp -r _maps/* $1/_maps/
cp -r code/datums/greyscale/json_configs/* $1/code/datums/greyscale/json_configs/
cp -r icons/* $1/icons/
cp -r sound/runtime/* $1/sound/runtime/
cp -r strings/* $1/strings/
cp -r tgui/public/* $1/tgui/public/
cp -r tgui/packages/tgfont/dist/* $1/tgui/packages/tgfont/dist/

#remove .dm files from _maps

#this regrettably doesn't work with windows find
#find $1/_maps -name "*.dm" -type f -delete

#dlls on windows
if [ "$(uname -o)" = "Msys" ]; then
	cp ./*.dll $1/
fi
