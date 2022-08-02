<?php
// inclusion of dependencies via Composer
// autoload.php allows to load in one go all the dependencies installed with composer
// but also to activate the automatic loading of classes (PSR-4 convention)
require_once '../vendor/autoload.php';
// creation of the router object
$router = new AltoRouter();
// If there is a subdirectory
if (array_key_exists('BASE_URI', $_SERVER)) {
    // Then we define the basePath of AltoRouter
    $router->setBasePath($_SERVER['BASE_URI']);
    // so our routes will match the URL, after the subdirectory sequence
}
else {
    // We give a default value to $_SERVER['BASE_URI'] because it is used in the CoreController
    $_SERVER['BASE_URI'] = '/';
}
// We have to declare all the "routes" to AltoRouter, so that it can give us THE "route" corresponding to the current URL "map"
$router->map(
    'GET',
    '/',
    [
        'method' => 'home',
        'controller' => '\App\Controllers\MainController'
    ],
    'main-home'
);

/* -------------
--- DISPATCH ---
--------------*/

// AltoRouter is asked to find a route that matches the current URL
$match = $router->match();
// Then, to dispatch the code to the right method, from the right Controller
// We delegate to an external library : https://packagist.org/packages/benoclock/alto-dispatcher
// 1er argument : the $match variable returned by AltoRouter
// 2e argument : the "target" (controller & method) to display the 404 page
$dispatcher = new Dispatcher($match, '\App\Controllers\ErrorController::err404');
// Once the dispatcher is configured, we launch the dispatch that will execute the controller method
$dispatcher->dispatch();