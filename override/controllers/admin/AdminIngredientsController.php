<?php

/*
* 2007-2013 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License (OSL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/osl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2013 PrestaShop SA
*  @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

class AdminIngredientsControllerCore extends AdminController
{
    public $bootstrap = true;
    protected $position_identifier = 'ingredient_id';

    public function __construct()
    {
        $this->table = 'ingredient';
        $this->className = 'Ingredients';
        $this->lang = true;

        $this->addRowAction('edit');
        $this->addRowAction('delete');

        $this->_defaultOrderBy = 'ingredient_id';

        $this->context = Context::getContext();

        $this->bulk_actions = array(
            'delete' => array('text' => $this->l('Delete selected'), 'confirm' => $this->l('Are you sure that you want to delete the selected items?')),
            'enableSelection' => array('text' => $this->l('Enable selection')),
            'disableSelection' => array('text' => $this->l('Disable selection'))
        );

        $this->fieldImageSettings = array(
            'name' => 'logo',
            'dir' => 's'
        );

        $this->fields_list = array(
            'ingredient_id' => array(
                'title' => $this->l('ID'),
                'align' => 'center',
                'width' => 25
            ),
            'name' => array(
                'title' => $this->l('Name'),
                'width' => 'auto'
            ),
            'price' => array(
                'title' => $this->l('Price'),
                'width' => 'auto'
            ),
            'max_amount' => array(
                'title' => $this->l('Max amount'),
                'width' => 'auto'
            )
        );

        parent::__construct();
    }

    public function renderList()
    {
        $this->addRowAction('details');
        return parent::renderList();
    }

    protected function setTypeFeature()
    {
        $this->table = 'ingredients';
        $this->className = 'Ingredients';
        $this->identifier = 'ingredient_id';
    }


    public function initToolbar()
    {
        switch ($this->display) {
            default :
                parent::initToolbar();
        }
    }

    public function renderForm()
    {
        $this->fields_form = array(
            'legend' => array(
                'title' => $this->l('Ingredients:'),
                'image' => '../img/admin/delivery.gif'
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->l('Name:'),
                    'name' => 'name',
                    'lang' => true,
                    'size' => 40,
                    'required' => true,
                    'hint' => $this->l('Invalid characters:') . ' <>;=#{}'
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('Price:'),
                    'name' => 'price',
                    'lang' => false,
                    'size' => 40,
                    'required' => true,
                    'hint' => $this->l('Invalid characters:') . ' <>;=#{}'
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('Max amount:'),
                    'name' => 'max_amount',
                    'size' => 40,
                    'required' => true
                ),
            ),
            'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'btn btn-default pull-right'
            )
        );

        if (!($obj = $this->loadObject(true)))
            return;

        return parent::renderForm();
    }


    public function initContent()
    {
        $this->initTabModuleList();
        $this->initToolbar();
        if ($this->display == 'edit' || $this->display == 'add') {
            if (!$this->loadObject(true))
                return;
            $this->content .= $this->renderForm();
        } else if ($this->display == 'view') {
            // Some controllers use the view action without an object
            if ($this->className)
                $this->loadObject(true);
            $this->content .= $this->renderView();
        } else if (!$this->ajax)
        {
            // If a feature value was saved, we need to reset the values to display the list
            $this->setTypeFeature();
            $this->content .= $this->renderList();
        }

        $this->context->smarty->assign(array(
            'content' => $this->content,
            'url_post' => self::$currentIndex . '&token=' . $this->token,
        ));
    }
}


