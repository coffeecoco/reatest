#!/bin/bash

VAGRANT_CORE_FOLDER=$(cat '/.coffeecoco-stuff/vagrant-core-folder.txt')

if [[ -f '/.coffeecoco-stuff/displayed-important-notices' ]]; then
    exit 0
fi

cat "${VAGRANT_CORE_FOLDER}/shell/ascii-art/important-notices.txt"

touch '/.coffeecoco-stuff/displayed-important-notices'
