# Fonction pour demander toutes les infos a l'utilisateur
donnees_utilisateur(){
    echo "-----------------------------"
    echo "-----    MVC Creator    -----"
    echo "-----------------------------"
    # On demande si l'utilisateur est pret a faire l'install
    read -p "Are you ready to install an MVC structure ? (Y/N) " confirm
    if [ "$confirm" = "Y" ]
    then
        echo "Let's GOOOO !!"
    else
        echo "Stop script"
        exit
    fi 

    # The user is asked for DB_HOST
    read -p "Where is the database located ? (localhost by default) " DB_HOST
    if [ "$DB_HOST" = "" ]
    then
        echo "✅ Ok,  DB_HOST = localhost"
        DB_HOST="localhost"
    else
        echo "✅ Ok,  DB_HOST = $DB_HOST"

    fi 

    # The user is asked for la DB_NAME
    read -p "Name BDD ? " DB_NAME
    if [ "$DB_NAME" = "" ]
    then
        echo "❌ The database name is required to perform the installation"
        echo "Stop script"
        exit
    else
        echo "✅ Ok, DB_NAME = $DB_NAME"

    fi 

    # The user is asked for DB_USERNAME
    read -p "UserName for conection to bdd' ? (default explorateur)" DB_USERNAME
    if [ "$DB_USERNAME" = "" ]
    then
        echo "✅ Ok,  DB_USERNAME = explorateur"
        DB_USERNAME="explorateur"
    else
        echo "✅ Ok,  DB_USERNAME = $DB_USERNAME"

    fi 

    # The user is asked for DB_PASSWORD
    read -p "The password for the connection to the database' ? (Default Ereul9Aeng)" DB_PASSWORD
    if [ "$DB_PASSWORD" = "" ]
    then
        echo "✅ Ok,  DB_PASSWORD = Ereul9Aeng"
        DB_PASSWORD="Ereul9Aeng"
    else
        echo "✅ Ok,  DB_USERNAME = $DB_PASSWORD"

    fi 

    # And we've finished asking for the DB info
    echo "\n"
    echo "✨✨ GOOD, we are finish Database config ✨✨"
    echo "\n"

    # NameSpace project
    read -p "Finally, the main namespace for the PSR4 implementation' ? (App default)" NAMESPACE
    if [ "$NAMESPACE" = "" ]
    then
        echo "✅ Ok,  NAMESPACE = App"
        NAMESPACE="App"
    else
        echo "✅ Ok,  NAMESPACE = $NAMESPACE"

    fi 

    # We check if the composer is well installed or not 
    echo "Now we will check that composing is well installed "
    if [ -f "/usr/local/bin/composer" ]; then
        echo "✅ Composer is already installed! It's perfect";
    else
        echo "Composer is not installed, I'll take care of it 💚!";
        installation_composer;
    fi

}

# Function to replace a string by another one in a file
# example use :
# replace_in_file 'text to replace' 'with this text' inThisFile.php
remplacer_dans_fichier() {
    php -r "file_put_contents('$3', str_replace('$1', '$2', file_get_contents('$3')));";
}

# Function for creating the folder structure
creation_structure_dossiers() {
    mkdir app
    mkdir public
    cd public
    mkdir assets
    cd ../app
    mkdir Controllers
    mkdir Models
    mkdir Utils
    mkdir views
    cd views
    mkdir main
    mkdir layout
    mkdir partials
    cd ../..
    echo "✅ Creating files"
}

# Setup function to composer
installation_composer(){
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
}

# Function copies resources from ./bin to the right place
creation_ressources(){
    # We place the files in our bin folder which contains all the resources
    cp ./bin/index.php ./public/index.php
    cp ./bin/.htaccess ./public/.htaccess
    cp ./bin/config.ini ./app/config.ini
    echo "Deny from all" > ./app/.htaccess
    cp ./bin/composer.json ./composer.json
    cp ./bin/CoreController.php ./app/Controllers/CoreController.php
    cp ./bin/MainController.php ./app/Controllers/MainController.php
    cp ./bin/Database.php ./app/Utils/Database.php
    cp ./bin/CoreModel.php ./app/Models/CoreModel.php
    cp ./bin/Model.php ./app/Models/Model.php
    echo "<h1>HEADER</h1>" > ./app/views/layout/header.tpl.php
    echo "<h1>FOOTER</h1>" > ./app/views/layout/footer.tpl.php
    echo "<h2>MAIN</h2>" > ./app/views/main/home.tpl.php
    echo "✅ Creating resources"
}

# Resource edit function
edition_ressources(){
    remplacer_dans_fichier "REPLACEDBHOST" $DB_HOST ./app/config.ini
    remplacer_dans_fichier "REPLACEDBNAME" $DB_NAME ./app/config.ini
    remplacer_dans_fichier "REPLACEDBUSERNAME" $DB_USERNAME ./app/config.ini
    remplacer_dans_fichier "REPLACEDBPASSWORD" $DB_PASSWORD ./app/config.ini

    remplacer_dans_fichier "REPLACENAMESPACE" $NAMESPACE ./composer.json
    remplacer_dans_fichier "REPLACENAMESPACE" $NAMESPACE ./app/Controllers/CoreController.php
    remplacer_dans_fichier "REPLACENAMESPACE" $NAMESPACE ./app/Controllers/MainController.php
    remplacer_dans_fichier "REPLACENAMESPACE" $NAMESPACE ./app/Models/CoreModel.php
    remplacer_dans_fichier "REPLACENAMESPACE" $NAMESPACE ./app/Models/Model.php
    remplacer_dans_fichier "REPLACENAMESPACE" $NAMESPACE ./app/Utils/Database.php
    echo "✅ Resource editing"
}