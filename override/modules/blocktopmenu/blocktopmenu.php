<?
class BlocktopmenuOverride extends Blocktopmenu{
	protected function makeMenu()
	{
	    $menu_items = $this->getMenuItems();
	    $id_lang = (int)$this->context->language->id;
	    $id_shop = (int)Shop::getContextShopID();
	    $iteration = 1;
	    foreach ($menu_items as $item) {
	        if (!$item) {
	            continue;
	        }

	        preg_match($this->pattern, $item, $value);
	        $id = (int)substr($item, strlen($value[1]), strlen($item));

	        switch (substr($item, 0, strlen($value[1]))) {
	            case 'CAT':
	                $this->_menu .= $this->generateCategoriesMenu(Category::getNestedCategories($id, $id_lang, false, $this->user_groups), 0, $iteration);
	                    $iteration++;
	                break;

	            case 'PRD':
	                $selected = ($this->page_name == 'product' && (Tools::getValue('id_product') == $id)) ? ' class="sfHover"' : '';
	                $product = new Product((int)$id, true, (int)$id_lang);
	                if (!is_null($product->id)) {
	                    $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($product->getLink()).'" title="'.$product->name.'">'.$product->name.'</a></li>'.PHP_EOL;
	                }
	                break;

	            case 'CMS':
	                $selected = ($this->page_name == 'cms' && (Tools::getValue('id_cms') == $id)) ? ' class="sfHover"' : '';
	                $cms = CMS::getLinks((int)$id_lang, array($id));
	                if (count($cms)) {
	                    $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($cms[0]['link']).'" title="'.Tools::safeOutput($cms[0]['meta_title']).'">'.Tools::safeOutput($cms[0]['meta_title']).'</a></li>'.PHP_EOL;
	                }
	                break;

	            case 'CMS_CAT':
	                $category = new CMSCategory((int)$id, (int)$id_lang);
	                if (count($category)) {
	                    $this->_menu .= '<li><a href="'.Tools::HtmlEntitiesUTF8($category->getLink()).'" title="'.$category->name.'">'.$category->name.'</a>';
	                    $this->getCMSMenuItems($category->id);
	                    $this->_menu .= '</li>'.PHP_EOL;
	                }
	                break;

	            // Case to handle the option to show all Manufacturers
	            case 'ALLMAN':
	                $link = new Link;
	                $this->_menu .= '<li><a href="'.$link->getPageLink('manufacturer').'" title="'.$this->l('All manufacturers').'">'.$this->l('All manufacturers').'</a><ul>'.PHP_EOL;
	                $manufacturers = Manufacturer::getManufacturers();
	                foreach ($manufacturers as $key => $manufacturer) {
	                    $this->_menu .= '<li><a href="'.$link->getManufacturerLink((int)$manufacturer['id_manufacturer'], $manufacturer['link_rewrite']).'" title="'.Tools::safeOutput($manufacturer['name']).'">'.Tools::safeOutput($manufacturer['name']).'</a></li>'.PHP_EOL;
	                }
	                $this->_menu .= '</ul>';
	                break;

	            case 'MAN':
	                $selected = ($this->page_name == 'manufacturer' && (Tools::getValue('id_manufacturer') == $id)) ? ' class="sfHover"' : '';
	                $manufacturer = new Manufacturer((int)$id, (int)$id_lang);
	                if (!is_null($manufacturer->id)) {
	                    if (intval(Configuration::get('PS_REWRITING_SETTINGS'))) {
	                        $manufacturer->link_rewrite = Tools::link_rewrite($manufacturer->name);
	                    } else {
	                        $manufacturer->link_rewrite = 0;
	                    }
	                    $link = new Link;
	                    $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($link->getManufacturerLink((int)$id, $manufacturer->link_rewrite)).'" title="'.Tools::safeOutput($manufacturer->name).'">'.Tools::safeOutput($manufacturer->name).'</a></li>'.PHP_EOL;
	                }
	                break;

	            // Case to handle the option to show all Suppliers
	            case 'ALLSUP':
	                $link = new Link;
	                $this->_menu .= '<li><a href="'.$link->getPageLink('supplier').'" title="'.$this->l('All suppliers').'">'.$this->l('All suppliers').'</a><ul>'.PHP_EOL;
	                $suppliers = Supplier::getSuppliers();
	                foreach ($suppliers as $key => $supplier) {
	                    $this->_menu .= '<li><a href="'.$link->getSupplierLink((int)$supplier['id_supplier'], $supplier['link_rewrite']).'" title="'.Tools::safeOutput($supplier['name']).'">'.Tools::safeOutput($supplier['name']).'</a></li>'.PHP_EOL;
	                }
	                $this->_menu .= '</ul>';
	                break;

	            case 'SUP':
	                $selected = ($this->page_name == 'supplier' && (Tools::getValue('id_supplier') == $id)) ? ' class="sfHover"' : '';
	                $supplier = new Supplier((int)$id, (int)$id_lang);
	                if (!is_null($supplier->id)) {
	                    $link = new Link;
	                    $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($link->getSupplierLink((int)$id, $supplier->link_rewrite)).'" title="'.$supplier->name.'">'.$supplier->name.'</a></li>'.PHP_EOL;
	                }
	                break;

	            case 'SHOP':
	                $selected = ($this->page_name == 'index' && ($this->context->shop->id == $id)) ? ' class="sfHover"' : '';
	                $shop = new Shop((int)$id);
	                if (Validate::isLoadedObject($shop)) {
	                    $link = new Link;
	                    $this->_menu .= '<li'.$selected.'><a href="'.Tools::HtmlEntitiesUTF8($shop->getBaseURL()).'" title="'.$shop->name.'">'.$shop->name.'</a></li>'.PHP_EOL;
	                }
	                break;
	            case 'LNK':
	                $link = MenuTopLinks::get((int)$id, (int)$id_lang, (int)$id_shop);
	                if (count($link)) {
	                    if (!isset($link[0]['label']) || ($link[0]['label'] == '')) {
	                        $default_language = Configuration::get('PS_LANG_DEFAULT');
	                        $link = MenuTopLinks::get($link[0]['id_linksmenutop'], $default_language, (int)Shop::getContextShopID());
	                    }
	                    $this->_menu .= '<li><a href="'.Tools::HtmlEntitiesUTF8($link[0]['link']).'"'.(($link[0]['new_window']) ? ' onclick="return !window.open(this.href);"': '').' title="'.Tools::safeOutput($link[0]['label']).'">'.Tools::safeOutput($link[0]['label']).'</a></li>'.PHP_EOL;
	                }
	                break;
	        }
	    }
	}
	protected function generateCategoriesMenu($categories, $is_children = 0, $iteration = 0)
    {
        $html = '';

        foreach ($categories as $key => $category) {
            if ($category['level_depth'] > 1) {
                $cat = new Category($category['id_category']);
                $link = Tools::HtmlEntitiesUTF8($cat->getLink());
            } else {
                $link = $this->context->link->getPageLink('index');
            }

            /* Whenever a category is not active we shouldnt display it to customer */
            if ((bool)$category['active'] === false) {
                continue;
            }

            $coWidth = $iteration ? "col-md-2" : "";

            $html .= '<li class="'.$coWidth.(($this->page_name == 'category'
                && (int)Tools::getValue('id_category') == (int)$category['id_category']) ? ' sfHoverForce' : '').'">';
            $html .= '<a href="'.$link.'" title="'.$category['name'].'">';
            if ($iteration && $category['link_rewrite']) {
            	$html .= '<img src="'.$this->context->link->getCatImageLink($category['link_rewrite'], $category['id_category']).'" alt="'.$category['name'].'" />';
            	$html .= '<span>'.$category['name'].'</span><i></i>';
            } else {
            	$html .= '<span>'.$category['name'].'</span><i></i>';
            }

            $html .= '</a>';

            if (isset($category['children']) && !empty($category['children'])) {
                $html .= '<ul>';
                $html .= $this->generateCategoriesMenu($category['children'], 1);

                if ((int)$category['level_depth'] > 1 && !$is_children) {
                    $files = scandir(_PS_CAT_IMG_DIR_);

                    if (count(preg_grep('/^'.$category['id_category'].'-([0-9])?_thumb.jpg/i', $files)) > 0) {
                        $html .= '<li class="category-thumbnail">';

                        foreach ($files as $file) {
                            if (preg_match('/^'.$category['id_category'].'-([0-9])?_thumb.jpg/i', $file) === 1) {
                                $html .= '<div><img src="'.$this->context->link->getMediaLink(_THEME_CAT_DIR_.$file)
                                .'" alt="'.Tools::SafeOutput($category['name']).'" title="'
                                .Tools::SafeOutput($category['name']).'" class="imgm" /></div>';
                            }
                        }

                        $html .= '</li>';
                    }
                }

                $html .= '</ul>';
            }

            $html .= '</li>';
        }
        
        if ($iteration == 2) {
            $html .= '<li class="center-li col-md-4"></li>';
        }

        return $html;
    }
}