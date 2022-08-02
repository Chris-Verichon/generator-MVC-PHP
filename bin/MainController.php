<?php

namespace REPLACENAMESPACE\Controllers;


class MainController extends CoreController {

    /**
     * Method for home page
     *
     * @return void
     */
    public function home()
    {
        $this->show('main/home');
    }
}