<!-- Block user information module NAV  -->
{if $is_logged}
	<div class="header_user_info">
		<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow"><span>{$cookie->customer_firstname} {$cookie->customer_lastname}</span></a>
	</div>
{/if}
<div class="header_user_info">
	<i class="header_user_info_icon"></i>
	<i class="cart_block_icon"></i>
	{if $is_logged}
		<a class="logout" href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Log me out' mod='blockuserinfo'}">
			{l s='Sign out' mod='blockuserinfo'}
		</a>
	{else}
	<div class="col-md-12 clearfix register-wrap">
		<div class="header_user_info_col clearfix">
				<a class="registration" href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='registration' mod='blockuserinfo'}">
					<span>{l s='Регистрация' mod='blockuserinfo'}</span>
				</a>
		</div>
		<div class="header_user_info_col clearfix">
				<a class="login" href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Log in to your customer account' mod='blockuserinfo'}">
					<span>{l s='Sign in' mod='blockuserinfo'}</span>
				</a>
		</div>
	</div>
		<div class="clearfix"></div>
		<a class="forgot-password" href="/password-recovery" rel="nofollow" title="{l s='Forgot your password' mod='blockuserinfo'}">
			{l s='Забыли пароль?' mod='blockuserinfo'}
		</a>
	{/if}
</div>
<!-- /Block usmodule NAV -->
