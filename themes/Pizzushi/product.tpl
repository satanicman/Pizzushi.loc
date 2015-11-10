{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{include file="$tpl_dir./errors.tpl"}
{if $errors|@count == 0}
	{if !isset($priceDisplayPrecision)}
		{assign var='priceDisplayPrecision' value=2}
	{/if}
	{if !$priceDisplay || $priceDisplay == 2}
		{assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, 6)}
		{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
	{elseif $priceDisplay == 1}
		{assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, 6)}
		{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
	{/if}
<div itemscope itemtype="https://schema.org/Product">
	<meta itemprop="url" content="{$link->getProductLink($product)}">
	<div class="primary_block row">
		<!-- left infos-->
		<div class="pb-left-column col-xs-12 col-sm-4 col-md-6">
			<!-- product img-->
			<div id="image-block" class="clearfix">
				<h1 itemprop="name" class="product_name">{$product->name|escape:'html':'UTF-8'}</h1>
				{if $have_image}
					<span id="product_container_{$product->id}">
						<img id="product_img_{$product->id}" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" width="{$largeSize.width}" height="{$largeSize.height}"/>
					</span>
				{else}
					<span id="product_container_{$product->id}">
						<img itemprop="image" src="{$img_prod_dir}{$lang_iso}-default-large_default.jpg" id="bigpic" alt="" title="{$product->name|escape:'html':'UTF-8'}" width="{$largeSize.width}" height="{$largeSize.height}"/>
					</span>
				{/if}
			</div> <!-- end image-block -->
		</div>
		<!-- end pb-left-column -->
		<!-- pb-right-column-->
		<div class="pb-right-column col-xs-12 col-sm-8 col-md-6{if !$content_only} product_content_only{/if}">
			{if ($product->show_price && !isset($restricted_country_mode)) || isset($groups) || $product->reference || (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}
				<div class="row">
					<!-- add to cart form-->
					<form id="buy_block"{if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if}
						  action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
						<!-- hidden datas -->
						<p class="hidden">
							<input type="hidden" name="token" value="{$static_token}"/>
							<input type="hidden" name="id_product" value="{$product->id|intval}"
								   id="product_page_product_id"/>
							<input type="hidden" name="add" value="1"/>
							<input type="hidden" name="id_product_attribute" id="idCombination" value=""/>
						</p>
						{if !$PS_CATALOG_MODE}
							<input type="hidden" min="1" name="qty" id="quantity_wanted" class="text"
								   value="{if isset($quantityBackup)}{$quantityBackup|intval}{else}{if $product->minimal_quantity > 1}{$product->minimal_quantity}{else}1{/if}{/if}"/>
						{/if}
						{if isset($groups)}
							<!-- attributes -->
							<div id="attributes">
								{foreach from=$groups key=id_attribute_group item=group}
									{if $group.attributes|@count}
										{assign var="groupName" value="group_$id_attribute_group"}
										{foreach from=$group.attributes key=id_attribute item=group_attribute}
											<div class="attribute">
												<div class="attribute_short_info_wrap">
													<div class="square"></div>
													<div class="attribute_short_info">
														<p>{$group.name|escape:'html':'UTF-8'}
															: {$group_attribute.name|escape:'html':'UTF-8'}</p>

														<p>Вес: {$product->weight + $group_attribute.weight}</p>
													</div>
												</div>
												<div class="attribute_price"
													 data-base_price="{$productPrice + $group_attribute.price}">
													<span>{convertPrice price=($productPrice + $group_attribute.price)|floatval}</span>
												</div>
												<p id="add_to_cart">
													<button type="submit" name="Submit" class="exclusive product_btn"
															data-id-combination="{$group_attribute.id_product_attribute}">
														<span>{if $content_only && (isset($product->customization_required) && $product->customization_required)}{l s='Customize'}{else}{l s='Add to cart'}{/if}</span>
													</button>
												</p>
											</div>
										{/foreach}
									{/if}
								{/foreach}
							</div>
							<!-- end attributes -->
						{/if}
						<div class="ingredients-title"><span class="ingredients-title-name">Ингридиенты</span></div>
						<ul class="added_list clearfix">
							{foreach from=$product_options item=product_option name=product_option}
								{if $product_option.selected}
									<li class="option_item col-md-4 col-sm-4 col-xs-6 {if $product_option.class}{$product_option.class}{/if}"
										id="option_item_{$product_option.id_product_option}">
											<span class="product_option_index">
												<span class="product_option_index_img">
												</span>
												<span class="product_option_index_name">{$product_option.name}</span>
											</span>
									</li>
								{/if}
							{/foreach}
							<li class="option_item add_ingredient col-md-4 col-sm-4 col-xs-6">
									<span class="product_option_index">
										<span class="product_option_index_img">
											<span class="product_option_index_img_square"><i class="plus"></i></span>
										</span>
										<span class="product_option_index_name">Добавить</span>
									</span>
							</li>
						</ul>
						<ul class="add_list clearfix">
							{foreach from=$product_options item=product_option name=product_option}
								<li class="option_item col-md-4 col-sm-4 col-xs-6 {if $product_option.class}{$product_option.class}{/if}"
									id="option_item_{$product_option.id_product_option}">
									<input type="checkbox" class="hidden option_id not_unifrom comparator"
										   name="options[][id]"
										   value="{$product_option.id_product_option}"
										   id="product_option_checkbox">
									<input type="hidden" class="amount" name="options[][amount]" value="1"
										   id="product_option_amount">
			                            <span class="product_option_index"
											  data-price="{$product_option.price}"
											  data-max_amount="{$product_option.max_amount}">
			                                <span class="product_option_index_img">
			                                    <span class="product_option_delete"></span>
			                                </span>
			                                <span class="product_option_index_name">{$product_option.name}</span>
			                            </span>
								</li>
							{/foreach}
						</ul>
					</form>
				</div>
			{/if}
		</div> <!-- end pb-right-column-->
		<div class="clearfix"></div>
		<div class="col-sm-12 col-md-12 col-xs-12">
			{if isset($product) && $product->description}
				<h3 class="page-product-heading"><span>{l s='More info'}</span></h3>
				<div  class="rte">{$product->description}</div>
			{/if}
		</div>
	</div> <!-- end primary_block -->
</div> <!-- itemscope product wrapper -->
{strip}
{if isset($smarty.get.ad) && $smarty.get.ad}
	{addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{if isset($smarty.get.adtoken) && $smarty.get.adtoken}
	{addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{addJsDef allowBuyWhenOutOfStock=$allow_oosp|boolval}
{addJsDef availableNowValue=$product->available_now|escape:'quotes':'UTF-8'}
{addJsDef availableLaterValue=$product->available_later|escape:'quotes':'UTF-8'}
{addJsDef attribute_anchor_separator=$attribute_anchor_separator|escape:'quotes':'UTF-8'}
{addJsDef attributesCombinations=$attributesCombinations}
{addJsDef currentDate=$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
{if isset($combinations) && $combinations}
	{addJsDef combinations=$combinations}
	{addJsDef combinationsFromController=$combinations}
	{addJsDef displayDiscountPrice=$display_discount_price}
	{addJsDefL name='upToTxt'}{l s='Up to' js=1}{/addJsDefL}
{/if}
{if isset($combinationImages) && $combinationImages}
	{addJsDef combinationImages=$combinationImages}
{/if}
{addJsDef customizationId=$id_customization}
{addJsDef customizationFields=$customizationFields}
{addJsDef default_eco_tax=$product->ecotax|floatval}
{addJsDef displayPrice=$priceDisplay|intval}
{addJsDef ecotaxTax_rate=$ecotaxTax_rate|floatval}
{if isset($cover.id_image_only)}
	{addJsDef idDefaultImage=$cover.id_image_only|intval}
{else}
	{addJsDef idDefaultImage=0}
{/if}
{addJsDef img_ps_dir=$img_ps_dir}
{addJsDef img_prod_dir=$img_prod_dir}
{addJsDef id_product=$product->id|intval}
{addJsDef jqZoomEnabled=$jqZoomEnabled|boolval}
{addJsDef maxQuantityToAllowDisplayOfLastQuantityMessage=$last_qties|intval}
{addJsDef minimalQuantity=$product->minimal_quantity|intval}
{addJsDef noTaxForThisProduct=$no_tax|boolval}
{if isset($customer_group_without_tax)}
	{addJsDef customerGroupWithoutTax=$customer_group_without_tax|boolval}
{else}
	{addJsDef customerGroupWithoutTax=false}
{/if}
{if isset($group_reduction)}
	{addJsDef groupReduction=$group_reduction|floatval}
{else}
	{addJsDef groupReduction=false}
{/if}
{addJsDef oosHookJsCodeFunctions=Array()}
{addJsDef productHasAttributes=isset($groups)|boolval}
{addJsDef productPriceTaxExcluded=($product->getPriceWithoutReduct(true)|default:'null' - $product->ecotax)|floatval}
{addJsDef productPriceTaxIncluded=($product->getPriceWithoutReduct(false)|default:'null' - $product->ecotax * (1 + $ecotaxTax_rate / 100))|floatval}
{addJsDef productBasePriceTaxExcluded=($product->getPrice(false, null, 6, null, false, false) - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcl=($product->getPrice(false, null, 6, null, false, false)|floatval)}
{addJsDef productBasePriceTaxIncl=($product->getPrice(true, null, 6, null, false, false)|floatval)}
{addJsDef productReference=$product->reference|escape:'html':'UTF-8'}
{addJsDef productAvailableForOrder=$product->available_for_order|boolval}
{addJsDef productPriceWithoutReduction=$productPriceWithoutReduction|floatval}
{addJsDef productPrice=$productPrice|floatval}
{addJsDef productUnitPriceRatio=$product->unit_price_ratio|floatval}
{addJsDef productShowPrice=(!$PS_CATALOG_MODE && $product->show_price)|boolval}
{addJsDef PS_CATALOG_MODE=$PS_CATALOG_MODE}
{if $product->specificPrice && $product->specificPrice|@count}
	{addJsDef product_specific_price=$product->specificPrice}
{else}
	{addJsDef product_specific_price=array()}
{/if}
{if $display_qties == 1 && $product->quantity}
	{addJsDef quantityAvailable=$product->quantity}
{else}
	{addJsDef quantityAvailable=0}
{/if}
{addJsDef quantitiesDisplayAllowed=$display_qties|boolval}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'percentage'}
	{addJsDef reduction_percent=$product->specificPrice.reduction*100|floatval}
{else}
	{addJsDef reduction_percent=0}
{/if}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'amount'}
	{addJsDef reduction_price=$product->specificPrice.reduction|floatval}
{else}
	{addJsDef reduction_price=0}
{/if}
{if $product->specificPrice && $product->specificPrice.price}
	{addJsDef specific_price=$product->specificPrice.price|floatval}
{else}
	{addJsDef specific_price=0}
{/if}
{addJsDef specific_currency=($product->specificPrice && $product->specificPrice.id_currency)|boolval} {* TODO: remove if always false *}
{addJsDef stock_management=$PS_STOCK_MANAGEMENT|intval}
{addJsDef taxRate=$tax_rate|floatval}
{addJsDefL name=doesntExist}{l s='This combination does not exist for this product. Please select another combination.' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMore}{l s='This product is no longer in stock' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMoreBut}{l s='with those attributes but is available with others.' js=1}{/addJsDefL}
{addJsDefL name=fieldRequired}{l s='Please fill in all the required fields before saving your customization.' js=1}{/addJsDefL}
{addJsDefL name=uploading_in_progress}{l s='Uploading in progress, please be patient.' js=1}{/addJsDefL}
{addJsDefL name='product_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='product_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
{/strip}
{/if}
