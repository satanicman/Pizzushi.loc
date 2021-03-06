<?php

class FrontController extends FrontControllerCore
{
    public function setMedia()
    {
        parent::setMedia();
        $this->addCSS(_THEME_CSS_DIR_.'font.css', 'all');
        $this->addCSS(_THEME_CSS_DIR_.'adaptive.css', 'all');
        $this->addJS(_THEME_JS_DIR_.'backForm.js');
        $this->addCSS(_THEME_CSS_DIR_.'bootstrap-timepicker.min.css', 'all');
        $this->addJS(_THEME_JS_DIR_.'bootstrap-timepicker.min.js');
        $this->addCSS(_THEME_CSS_DIR_.'jquery.mCustomScrollbar.css', 'all');
        $this->addJS(_THEME_JS_DIR_.'jquery.mCustomScrollbar.concat.min.js');
    }
}