<?php

class ProductOptionCore extends ObjectModel
{
    public $id_product_option;

    public $name;

    public $price;

    public $max_amount;

    public $class;

    public static $definition = array(
        'table' => 'product_option',
        'primary' => 'id_product_option',
        'multilang' => true,
        'fields' => array(
            'name' => array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCatalogName', 'required' => true, 'size' => 128),
            'price' => array('type' => self::TYPE_FLOAT, 'validate' => 'isPrice'),
            'max_amount' => array('type' => self::TYPE_INT),
            'class' => array('type' => self::TYPE_STRING)
        )
    );


    public static function getProductOptions($id_lang){
        $sql = "SELECT po.id_product_option, po.price, po.class, po.max_amount, pol.name FROM "._DB_PREFIX_."product_option po
            LEFT JOIN "._DB_PREFIX_."product_option_lang pol ON (po.id_product_option=pol.id_product_option AND pol.id_lang={$id_lang})";
        return Db::getInstance()->executeS($sql);
    }

    public static function getProductOptionsProduct($id_product, $id_lang)
    {
        $sql = "SELECT po.id_product_option, po.price, po.max_amount, pol.name, pop.amount FROM " . _DB_PREFIX_ . "product_option po
                    LEFT JOIN " . _DB_PREFIX_ . "product_option_lang pol ON (po.id_product_option=pol.id_product_option AND pol.id_lang={$id_lang})
                    LEFT JOIN " . _DB_PREFIX_ . "product_option_product pop ON(po.id_product_option=pop.id_product_option)
                    WHERE id_product={$id_product}";
        $result = Db::getInstance()->executeS($sql);
        return $result;
    }

    public function getProductOption ($id_option, $id_lang){
        $sql = "SELECT po.price AS price, pol.name AS name FROM " . _DB_PREFIX_ . "product_option po
                    LEFT JOIN " . _DB_PREFIX_ . "product_option_lang pol ON (po.id_product_option=pol.id_product_option AND pol.id_lang={$id_lang})
                    WHERE po.id_product_option={$id_option}";
        $result = Db::getInstance()->executeS($sql);
        return $result;
    }
}

?>