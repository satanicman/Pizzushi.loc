jQuery(document).ready(function($) {
	$('.backForm').fancybox({
		'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
		'speedIn'		:	600, 
		'speedOut'		:	200, 
		'overlayShow'	:	true,
		'padding': 0,
		'margin': 0
	});
	$('.backForm-inp').focus(function() {
		if ($(this).parent().hasClass('normal'))
			$(this).parent().removeClass('normal').addClass('active');
		if ($(this).parent().hasClass('error'))
			$(this).parent().removeClass('error')
	}).blur(function(event) {
		if ($.trim($(this).val()) == '')
			$(this).parent().removeClass('active').addClass('normal');
	});
	$('#backForm').submit(function(event) {
		var errors = 0;
		$(this).find('.backForm-inp').each(function() {
			if ($.trim($(this).val()) === '') {
				errors++;
				$(this).parent().addClass('error');
			}
		});
		if (errors){
			$('.backForm-btn').addClass('error');
			setTimeout(function(){
				$('.backForm-btn, .backForm-input').removeClass('error');
			}, 2000);
		} else {
			$.ajax({
				url: 'ajax/baccall.php',
				type: 'POST',
				dataType: 'json',
				data: {
					name: $('#backForm-name').val(),
					phone: $('#backForm-phone').val(),
					mailFrom: $('#backForm-email').val(),
					mailTo: $('#backForm-emailTo').val()
				},
			})
			.done(function(data) {
				$('.backForm-btn').addClass('success');
				setTimeout(function(){
					$('.backForm-btn').removeClass('success');
				}, 2000);
				console.log("success");
				console.log(data);
			})
			.fail(function() {
				$('.backForm-btn').addClass('error');
				setTimeout(function(){
					$('.backForm-btn').removeClass('error');
				}, 2000);
				console.log("error");
			})
			.always(function() {
				console.log("complete");
			});
		}
		event.preventDefault();
	});
});