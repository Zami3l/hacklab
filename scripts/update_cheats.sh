#!/bin/bash

######################################
# update_cheats.sh
# Description : Mise à jour des cheats navi
# Auteur: Zami3l
######################################

PATH_CHEATS='.local/share/navi/cheats/'

echo -e "\n=> Démarrage de la mise à jour des cheatsheets...\n"
cd $PATH_CHEATS && git pull &> /dev/null 
echo -e "=> Mise à jour terminée. \n"