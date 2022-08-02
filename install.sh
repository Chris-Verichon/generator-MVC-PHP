#!/bin/bash

# We include the file that contains all the functions that will be useful for the following
. ./includes/functions.sh

# All data is requested from the user
donnees_utilisateur;

# We make all the files
echo "On va maintenant fabriquer toute la structure de dossier de notre MVC"
creation_structure_dossiers;

# We copy the ./bin resources to the right place
echo "On va maintenant créer toutes les ressources"
creation_ressources;

# Editing resources 
echo "On va maintenant editer les ressources avec les données utilisateur"
edition_ressources;

# Install dependencies
echo "pour terminer on installe altorouteur, altodispatcher, var_dumper et on génère l'autoload"
composer install
echo "✅ Installation des dépendances"
echo "✨✨✨✨✨✨✨✨✨✨✨✨"
echo "✨Installation completed✨"
echo "✨✨✨✨✨✨✨✨✨✨✨✨"