<?php

namespace REPLACENAMESPACE\Controllers;

class CoreController {
    /**
     * Method to display HTML code based on views
     *
     * @param string $viewName file Name
     * @param array $viewVars Array to views
     * @return void
     */
    protected function show(string $viewName, $viewVars = []) {

        global $router;

        // a value that is needed on ALL views
        $viewVars['currentPage'] = $viewName; 

        // define the absolute url for our assets
        $viewVars['assetsBaseUri'] = $_SERVER['BASE_URI'] . 'assets/';
        // define the absolute url for the root of the aplication
        $viewVars['baseUri'] = $_SERVER['BASE_URI'];

        // The extract function creates a variable for each element of the array passed in argument
        extract($viewVars);
        // => the variable $currentPage now exists, and its value is $viewName
        // => the variable $assetsBaseUri now exists, and its value is $_SERVER['BASE_URI'] . /assets/'
        // => the variable $baseUri now exists, and its value is $_SERVER['BASE_URI']

        // $viewVars is available in each view file
        require_once __DIR__.'/../views/layout/header.tpl.php';
        require_once __DIR__.'/../views/'.$viewName.'.tpl.php';
        require_once __DIR__.'/../views/layout/footer.tpl.php';
    }
}