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
{if isset($HOOK_HOME) && $HOOK_HOME|trim}
	<div class="clearfix">{$HOOK_HOME}</div>
{/if}
<div class="privileges">
	<div class="privilege col-md-3 col-sm-6 col-xs-12">
			<div class="privileges-img">
				<img src="themes/Pizzushi/img/privilege/1.png" alt="">
			</div>
			<div class="privileges-text">Свежие ингридиенты</div>
	</div>
	<div class="privilege col-md-3 col-sm-6 col-xs-12">
			<div class="privileges-img">
				<img src="themes/Pizzushi/img/privilege/2.png" alt="">
			</div>
			<div class="privileges-text">Бесплатная доставка</div>
	</div>
	<div class="privilege col-md-3 col-sm-6 col-xs-12">
			<div class="privileges-img">
				<img src="themes/Pizzushi/img/privilege/3.png" alt="">
			</div>
			<div class="privileges-text">Семь дней в неделю с 10 до 23:00</div>
	</div>
	<div class="privilege col-md-3 col-sm-6 col-xs-12">
			<div class="privileges-img">
				<img src="themes/Pizzushi/img/privilege/4.png" alt="">
			</div>
			<div class="privileges-text">30-50 минут доставка</div>
	</div>
</div>
<div class="row">
	<div class="blog-wrapper clearfix">
		<div class="blog-wrapper-left-column col-md-6 col-sm-12">
			<div class="blog-wrapper-title-wrap">
				<span class="blog-wrapper-title">о Доставке Пиццы</span>
			</div>
			<p>Иногда хочется отдохнуть дома с друзьями в теплой семейной атмосфере. Но вы не хотите готовить или не знаете что любят ваши гости? Решение есть! На сайте www.pizza-hata.com.ua можно заказать пиццу, приготовленную по лучшим рецептам наших поваров или создать свой вариант пиццы хата с любимыми ингредиентами. Теперь можно угодить каждому гостю и сделать вечер незабываемым вам поможет доставка пиццы на дом. Помимо пиццы у нас вы можете заказать другие блюда итальянской кухни, замечательное мангал-меню с шашлыком, рыбой и овощами гриль, супы, салаты и десерты. Вкусный ужин вам обеспечен!</p>
			<span class="blog-sub-title">ЛУЧШАЯ ДОСТАВКА ПИЦЦЫ В КИЕВЕ</span>
			<p>Повара пиццерии действительно любят свое дело и придерживаются традиционных итальянских рецептов.
				Все наши продукты проходят проверку качества.
				Пицца хата оперативно привезет ваш заказ, поэтому от вашей пиццы будет идти ароматный жар, как будто ее минуту назад достали из пылающей печи.</p>
			<p>Мы заботимся о своих клиентах, поэтому регулярно устраиваем акции со скидками и дарим фирменные подарки.
				В некоторые районы Киева доставка пиццы бесплатная, в остальные районы не превышает 40 грн.
				Вы сможете заказать пиццу своей мечты, только с теми ингредиентами, которые вам действительно нравятся. Для этого нужно выбрать на сайте раздел «Своя пицца» и поставить галочки напротив любимых ингредиентов.
				Зарегистрированные клиенты могут отслеживать готовность заказа на своем аккаунте.</p>
			<p>Заказать пиццу еще быстрее можно благодаря тому, что зарегистрированные клиенты способны сохранять несколько адресов доставки пиццы в Киеве через свой аккаунт.</p>
	
			<div class="blog-label-wrap">
				<p><span class="blog-label">На сайте</span> <a href="http://www.pizza-hata.com.ua">www.pizza-hata.com.ua</a></p> 
				<p><span class="blog-label">Для вас представлено все:</span></p>
			</div>
			<ul>
				<li>пицца для вегетарианцев</li>
				<li>мясная пицца</li>
				<li>пицца с морепродуктами...</li>
				<li>пицца с грибами</li>
			</ul>
		</div>
		<div class="blog-wrapper-right-column col-md-6 col-sm-12">
			{hook::exec('displayHomeBlog')}
		</div>
	</div>
</div>