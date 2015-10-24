<?php

class ProductIngredients extends ObjectModel
{
    public $ingredient_id;

    public $name;

    public $price;

    public $max_amount;

    public static $definition = array(
        'table' => 'ingredients',
        'primary' => 'ingredient_id',
        'multilang' => true,
        'fields' => array(
            'name' => array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCatalogName', 'required' => true, 'size' => 128),
            'price' => array('type' => self::TYPE_FLOAT, 'validate' => 'isPrice'),
            'max_amount' => array('type' => self::TYPE_INT)
        )
    );

}
?>