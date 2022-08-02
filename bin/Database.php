<?php

namespace REPLACENAMESPACE\Utils;

use PDO;

// Design Pattern : Singleton
class Database {
    /**
     * Objet PDO representing the connection to the database
     * 
     * @var PDO
     */
    private $dbh;
    /**
     * Static property (linked to the class) storing the unique object instance
     * 
     * @var Database
     */
    private static $_instance;

    /**
     * Construct
     * 
     * in private visibility
     * => only the class code has the right to create an instance of this class
     */
    private function __construct() {
        // Retrieving data from the config file
        // the parse_ini_file function parse the file and return an associative array
        $configData = parse_ini_file(__DIR__.'/../config.ini');
        
        try {
            $this->dbh = new PDO(
                "mysql:host={$configData['DB_HOST']};dbname={$configData['DB_NAME']};charset=utf8",
                $configData['DB_USERNAME'],
                $configData['DB_PASSWORD'],
                array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING) // Displays SQL errors on the screen
            );
        }
        // ... but if an error (Exception) occurs, then we catch the exception and execute the code we want (here, we display an error message)
        catch(\Exception $exception) {
            echo 'Erreur de connexion...<br>';
            echo $exception->getMessage().'<br>';
            echo '<pre>';
            echo $exception->getTraceAsString();
            echo '</pre>';
            exit;
        }
    }

    /**
     * Method to return, in all cases,
     * the dbh property (PDO object) of the single instance of Database
     *
     * @return PDO
     */
    public static function getPDO() {
        // If we have not yet created the only instance of the
        if (empty(self::$_instance)) {
            // So we create this instance and store it in the static property $_instance
            self::$_instance = new Database();
        }

        // Finally, we return the dbh property of the single instance of Database
        return self::$_instance->dbh;
    }
}