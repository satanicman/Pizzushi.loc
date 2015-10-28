<div id="qform" class="quickform">
	<div class="qform_container">
	<div id="errors" class="error" style="display: none;"></div>
	<div id="success" class="success hidden">{l s='Thanks' mod='quickorder'}<br>{l s='Order complete' mod='quickorder'}</div>
	{if $total <= 0}<div class="error">{l s='Your cart is is empty' mod='quickorder'}</div>{/if}

	{if $total > 0}
	<div id="wrap" class="form_container">
        <input type="text" class="qo_input" id="firstname" name="firstname" value="{if $logged}{$cookie->customer_firstname}{/if}" placeholder="{l s='Имя' mod='quickorder'}">
        <input type="text" class="qo_input" name="phone_mobile" id="phone_mobile" value="" placeholder="{l s='Телефон' mod='quickorder'}"/>
        <textarea name="comment" class="qo_textarea" id="comment" cols="26" rows="5" placeholder="{l s='Комментарий' mod='quickorder'}"></textarea>
		<div class="time">
			<input id="timepicker" type="text" class="qo_time" data-template="false">
			<input type="checkbox" class="qo_checkbox not_unifrom comparator" name="time_now" id="time_now">
			<label for="time_now" class="qo_label">На сейчас</label>
		</div>
	</div>
		<script>
			$('#timepicker').timepicker({
				showMeridian: false,
				icons: {
					up: 'fa fa-chevron-up',
					down: 'fa fa-chevron-down'
				},
				minuteStep: 1
			});
		</script>
	{/if}
</div>
</div>