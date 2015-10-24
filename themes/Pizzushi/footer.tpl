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
{if !isset($content_only) || !$content_only}
					
					<div class="soc-foows">
						<div class="soc-foow">
							<div class="soc-foow-title">мы вконтакте</div>
							<img src="{$img_dir}folow/vk.jpg" alt="">
						</div>
						<div class="soc-foow">
							<div class="soc-foow-title">Facebook</div>
							<img src="{$img_dir}folow/fb.jpg" alt="">
						</div>
						<div class="soc-foow">
							<div class="soc-foow-title">Одноклассники</div>
							<img src="{$img_dir}folow/od.jpg" alt="">
						</div>
						<div class="soc-foow">
							<div class="soc-foow-title">INSTAGRAM</div>
							<img src="{$img_dir}folow/in.jpg" alt="">
						</div>
					</div>
					</div><!-- #center_column -->
					{if isset($right_column_size) && !empty($right_column_size)}
						<div id="right_column" class="col-xs-12 col-sm-{$right_column_size|intval} column"><div class="row">{$HOOK_RIGHT_COLUMN}</div></div>
					{/if}
					<div class="clearfix"></div>
				</div><!-- #columns -->
			</div><!-- .columns-container -->
			{if isset($HOOK_FOOTER)}
				<!-- Footer -->
				<div class="footer-container">
					<footer id="footer" class="clearfix">
						<div class="footer-contant col-sm-{12 - $right_column_size|intval}">
							<div class="footer_logo">
								<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
									<img class="logo" src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}"/>
								</a>
							</div>
							<div class="footer-menu">
								{$HOOK_FOOTER}
								<p class="copyright">© Пицца-суши 2015. Доставка пиццы и суши. Все права защищены. Разработано веб-студией  Pinguin-Studio.com.ua</p>
							</div>
							<div class="footer-contacts">
								<div class="footer-contact-emails">
									<span class="footer-contact-email">sushi_1@mail.ru</span>
									<span class="footer-contact-email">pizza_2t@mail.ru</span>
								</div>
								<div class="footer-contact-phones">
									<span class="footer-contact-phone">+ 7727 277 52 02</span>
									<span class="footer-contact-phone">+ 7778 974 11 74</span>
								</div>
							</div>
						</div>
						<div class="col-sm-{$right_column_size|intval}"></div>
					</footer>
				</div><!-- #footer -->
			{/if}
		</div><!-- #page -->
{/if}
{include file="$tpl_dir./global.tpl"}
	</body>
</html>