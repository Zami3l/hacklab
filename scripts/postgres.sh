#!/bin/bash

######################################
# postgres.sh
# Description : Création BDD <msf> pour Metasploit
# Auteur: Zami3l
######################################

PATH_DB='/data/postgres'
PATH_LIB='/var/lib/postgres'

echo "Création du dossier pour la configuration..."
mkdir -p $PATH_DB

echo "Attribution des droits sur les dossiers postgres"
chown postgres:postgres $PATH_DB
chown postgres:postgres $PATH_LIB

echo "Initialisation du cluster..."
sudo -iu postgres /usr/bin/initdb --locale en_US.UTF-8 --pgdata=$PATH_DB

echo "Initialisation des fichiers de configuration..."
sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" $PATH_DB/postgresql.conf
echo  "shared_preload_libraries='pg_stat_statements'">> $PATH_DB/postgresql.conf
echo "unix_socket_directories='$PATH_DB'" >> $PATH_DB/postgresql.conf
echo "host    all    all    0.0.0.0/0    md5" >> $PATH_DB/pg_hba.conf

export PGHOST=$PATH_DB

echo "Démarrage du service"
sudo -iu postgres pg_ctl -D $PATH_DB start &
sleep 3s

echo "Création de l'utilisateur msf"
sudo -iu postgres createuser -h $PATH_DB -S -D -R -e msf

echo "Création de la base msf avec l'utilisateur msf"
sudo -iu postgres createdb -h $PATH_DB -O msf msf
