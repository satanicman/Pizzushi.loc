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
<div class="blockcontact-top">
	{if $email}
		<a href="#backForm" class="blockcontact-top-email backForm"><span>{l s='заказать звонок' mod='blockcontact'}</span></a>
		<div class="hidden">
			<form action="/ajax/baccall.php" method="POST" id="backForm">
				<div class="backForm-title-wrap">
					<div class="backForm-title">Обратная форма</div>
				</div>
				<div class="backForm-input normal">
					<label for="backForm-name" class="backForm-label">Имя</label>
					<input type="text" class="backForm-inp" name="name" id="backForm-name">
					<i class="boder"></i>
				</div>
				<div class="backForm-input normal">
					<label for="backForm-phone" class="backForm-label">Телефон</label>
					<input type="text" class="backForm-inp" name="phone" id="backForm-phone">
					<i class="boder"></i>
				</div>
				<div class="backForm-input normal">
					<label for="backForm-email" class="backForm-label">E-mail</label>
					<input type="email" class="backForm-inp" id="backForm-email">
					<i class="boder"></i>
				</div>
				<button class="backForm-btn">Отправить</button>
				<input type="hidden" value="{$email}" name="backForm-emailTo" id="backForm-emailTo">
			</form>
		</div>
	{/if}
	{if $telnumber}
		<p class="blockcontact-top-phone">{$telnumber}</p>
	{/if}
</div>
