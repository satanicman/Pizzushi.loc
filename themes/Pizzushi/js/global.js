/*
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
 */
//global variables
var responsiveflag = false;

$(window).load(function () {

});

$(document).ready(function () {

    $('.custom_select .list').css({
        maxHeight: ($('.custom_select .list label').height() * 5 + $('.custom_select .list label').css('margin-bottom') * 4)
    });

    var heightList = $('.custom_select .list label').height() * 5 + parseInt($('.custom_select .list label').css('margin-bottom')) * 4 + parseInt($('.custom_select .list').css('padding-top')) + parseInt($('.custom_select .list').css('padding-bottom')) + parseInt($('.custom_select .list').css('border-bottom-width')) + parseInt($('.custom_select .list').css('border-top-width'));
    $('.custom_select .list').hide().css({
        opacity: 1,
        maxHeight: heightList
    });

    $(document).on('click', '.custom_select .selecter', function (e) {
        var list = $(this).siblings('.list');

        if (list.hasClass('active'))
            list.removeClass('active').slideUp();
        else
            list.addClass('active').slideDown();
    });

    $('.custom_select .list').mCustomScrollbar();


    $(document).click(function () {
        if ($(event.target).closest(".custom_select .selecter, .custom_select .list").length) return;
        $('.custom_select .list').removeClass('active').slideUp();
        event.stopPropagation();
    });

    $(document).on('click', '#quickorder_custom:not(.active)', function (e) {
        e.preventDefault();
        var btn = $(this);
        $('#quickorder_custom_form').load(baseDir + 'modules/quickorder/ajax.php', function (response, status, xhr) {
            if (xhr.responseText.search(/Корзина пуста/) == -1) {
                $('#empty_cart').hide();
                $('.header_user_info, .cart_block, .cart-total').slideUp();
                $('#quickorder_custom_form').slideDown();
                btn.addClass('active');
            } else {
                $('#empty_cart').slideDown();
                setTimeout(function () {
                    $('#empty_cart').slideUp();
                }, 2000);
            }
        });
    });

    //if ($('#time').attr('type') === 'text') {
    //	$('#time').blur(function(event) {
    //		console.clear();
    //		var time = $(this).val().split(':');
    //		if (!time[0] || !time[1]) {
    //			$(this).val('00:00');
    //			return false;
    //		}
    //		if(time[0].search(/^(([0,1][0-9])|(2[0-3]))$/) == -1){
    //			time[0] = '00';
    //		}
    //		if(time[1].search(/^[0-5][0-9]$/) == -1){
    //			time[1] = '00';
    //		}
    //		$(this).val(time.join(':'));
    //	});
    //}

    $(document).on('click', '#quickorder_custom.active', function (e) {
        e.preventDefault();
        var btn = $(this),
            qform_container = $(this).parent().siblings('#quickorder_custom_form'),
            wrap = qform_container.find('#wrap'),
            phone = wrap.find('#phone_mobile').val(),
            firstname = wrap.find('#firstname').val(),
            comment = wrap.find('#comment').val(),
            time;

        if ($('#time_now').prop('checked')) {
            time = 'На сейчас';
        } else {
            time = wrap.find('.qo_time').val();
        }

        $.ajax({
            type: 'POST',
            url: baseDir + 'modules/quickorder/ajax.php',
            async: true,
            cache: false,
            dataType: "json",
            data: 'submitQorder=true' + '&phone=' + phone + '&time=' + time + '&firstname=' + firstname + '&lastname=' + comment + '&token=' + static_token,
            success: function (jsonData) {
                if (jsonData.hasError) {
                    var errors = '<b>' + 'Ошибки: ' + '</b><ol>';
                    for (error in jsonData.errors)
                        if (error != 'indexOf')
                            errors += '<li>' + jsonData.errors[error] + '</li>';
                    errors += '</ol>';
                    wrap.siblings('#errors').html(errors).slideDown('slow');
                }
                else {
                    btn.removeClass('active');
                    $('.ajax_cart_quantity, .ajax_cart_product_txt_s, .ajax_cart_product_txt, .ajax_cart_total').each(function () {
                        $(this).hide();
                    });
                    $('.cart_block dl.products').remove();
                    $('.cart-prices').hide();
                    $('.cart_block_no_products').show('slow');

                    $('#qform #wrap').hide();
                    $('#qform #errors').slideUp('slow', function () {
                        $('#qform #errors').hide();
                        $('#qform .submit').hide();
                        $('#qform #success').show();
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("TECHNICAL ERROR: unable create order \n\nDetails:\nError: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus);
            }
        });
    });

    highdpiInit();
    responsiveResize();
    $(window).resize(responsiveResize);
    if (navigator.userAgent.match(/Android/i)) {
        var viewport = document.querySelector('meta[name="viewport"]');
        viewport.setAttribute('content', 'initial-scale=1.0,maximum-scale=1.0,user-scalable=0,width=device-width,height=device-height');
        window.scrollTo(0, 1);
    }
    if (typeof quickView !== 'undefined' && quickView)
        quick_view();
    dropDown();

    if (typeof page_name != 'undefined' && !in_array(page_name, ['index', 'product'])) {
        bindGrid();

        $(document).on('change', '.selectProductSort', function (e) {
            if (typeof request != 'undefined' && request)
                var requestSortProducts = request;
            var splitData = $(this).val().split(':');
            var url = '';
            if (typeof requestSortProducts != 'undefined' && requestSortProducts) {
                url += requestSortProducts;
                if (typeof splitData[0] !== 'undefined' && splitData[0]) {
                    url += ( requestSortProducts.indexOf('?') < 0 ? '?' : '&') + 'orderby=' + splitData[0] + (splitData[1] ? '&orderway=' + splitData[1] : '');
                    if (typeof splitData[1] !== 'undefined' && splitData[1])
                        url += '&orderway=' + splitData[1];
                }
                document.location.href = url;
            }
        });


        $(document).on('change', '.ing_sort_check', function (e) {

            var requestSortProducts = document.location.href;
            var urlSplit;
            var data = [];
            var url = '';
            var regExec = /(\?|&){1}ingFilter={1}.+\d{1}&?/;
            var result = [];

            if(requestSortProducts[requestSortProducts.search(regExec)] === '?')
                requestSortProducts = requestSortProducts.replace(regExec, "?");
            else
                requestSortProducts = requestSortProducts.replace(regExec, "");

            $('.ing_sort_check:checked').each(function () {
                data.push($(this).val());
            });
            url += requestSortProducts;

            if (typeof requestSortProducts != 'undefined' && requestSortProducts) {
                if (typeof data !== 'undefined' && data.length) {
                    //url += (requestSortProducts.indexOf('?') < 0 ? '?' : '&') + 'ingFilter=' + data;
                    if(requestSortProducts.indexOf('?') < 0){
                        url += '?' + 'ingFilter=' + data;
                    } else {
                        if(requestSortProducts[requestSortProducts.length - 1] === '?'){
                            url += 'ingFilter=' + data;
                        } else {
                            url += '&' + 'ingFilter=' + data;
                        }
                    }
                }

                url = url[url.length - 1] === '?' ? url.replace(/\?/, "") : url;

                document.location.href = url;
            }
        });

        $(document).on('change', 'select[name="n"]', function () {
            $(this.form).submit();
        });

        $(document).on('change', 'select[name="currency_payment"]', function () {
            setCurrency($(this).val());
        });
    }

    $(document).on('change', 'select[name="manufacturer_list"], select[name="supplier_list"]', function () {
        if (this.value != '')
            location.href = this.value;
    });

    $(document).on('click', '.back', function (e) {
        e.preventDefault();
        history.back();
    });

    jQuery.curCSS = jQuery.css;
    if (!!$.prototype.cluetip)
        $('a.cluetip').cluetip({
            local: true,
            cursor: 'pointer',
            dropShadow: false,
            dropShadowSteps: 0,
            showTitle: false,
            tracking: true,
            sticky: false,
            mouseOutClose: true,
            fx: {
                open: 'fadeIn',
                openSpeed: 'fast'
            }
        }).css('opacity', 0.8);

    if (!!$.prototype.fancybox)
        $.extend($.fancybox.defaults.tpl, {
            closeBtn: '<a title="' + FancyboxI18nClose + '" class="fancybox-item fancybox-close" href="javascript:;"></a>',
            next: '<a title="' + FancyboxI18nNext + '" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>',
            prev: '<a title="' + FancyboxI18nPrev + '" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>'
        });

    // Close Alert messages
    $(".alert.alert-danger").on('click', this, function (e) {
        if (e.offsetX >= 16 && e.offsetX <= 39 && e.offsetY >= 16 && e.offsetY <= 34)
            $(this).fadeOut();
    });
    padTop = $('.header-container').height();
    $('#page').css('paddingTop', (padTop - 5));
    $('#right_column').css('paddingTop', (padTop));

    //$('ul.product_list.grid > li .product-container .product-image-container').click(function(event) {
    //	$(this).toggleClass('click');
    //});
    $('.button-container .label_radio:checked').each(function () {
        var btn = $(this).parent().siblings('.button');
        var price = $(this).data('price').split(' ');
        btn.data('id-product-attribute', $(this).data('id-product-attribute'));
        btn.children('.btn_price').children().html(price[0] + " <span class='cur'>" + price[1] + '</span>');
    });
    $('.button-container .label_radio').change(function () {
        var btn = $(this).parent().siblings('.button');
        var price = $(this).data('price').split(' ');
        btn.data('id-product-attribute', $(this).data('id-product-attribute'));
        btn.children('.btn_price').children().html(price[0] + " <span class='cur'>" + price[1] + '</span>');
    });
});

$(window).resize(function () {
    padTop = $('.header-container').height();
    $('#page').css('paddingTop', (padTop - 5));
    $('#right_column').css('paddingTop', (padTop));
});
$(window).load(function () {
    padTop = $('.header-container').height();
    $('#page').css('paddingTop', (padTop - 5));
    $('#right_column').css('paddingTop', (padTop));
});
function highdpiInit() {
    if ($('.replace-2x').css('font-size') == "1px") {
        var els = $("img.replace-2x").get();
        for (var i = 0; i < els.length; i++) {
            src = els[i].src;
            extension = src.substr((src.lastIndexOf('.') + 1));
            src = src.replace("." + extension, "2x." + extension);

            var img = new Image();
            img.src = src;
            img.height != 0 ? els[i].src = src : els[i].src = els[i].src;
        }
    }
}


// Used to compensante Chrome/Safari bug (they don't care about scroll bar for width)
function scrollCompensate() {
    var inner = document.createElement('p');
    inner.style.width = "100%";
    inner.style.height = "200px";

    var outer = document.createElement('div');
    outer.style.position = "absolute";
    outer.style.top = "0px";
    outer.style.left = "0px";
    outer.style.visibility = "hidden";
    outer.style.width = "200px";
    outer.style.height = "150px";
    outer.style.overflow = "hidden";
    outer.appendChild(inner);

    document.body.appendChild(outer);
    var w1 = inner.offsetWidth;
    outer.style.overflow = 'scroll';
    var w2 = inner.offsetWidth;
    if (w1 == w2) w2 = outer.clientWidth;

    document.body.removeChild(outer);

    return (w1 - w2);
}

function responsiveResize() {
    compensante = scrollCompensate();
    if (($(window).width() + scrollCompensate()) <= 767 && responsiveflag == false) {
        accordion('enable');
        accordionFooter('enable');
        responsiveflag = true;
    }
    else if (($(window).width() + scrollCompensate()) >= 768) {
        accordion('disable');
        accordionFooter('disable');
        responsiveflag = false;
        if (typeof bindUniform !== 'undefined')
            bindUniform();
    }
    blockHover();
}

function blockHover(status) {
    var screenLg = $('body').find('.container').width() == 1170;

    if ($('.product_list').is('.grid'))
        if (screenLg)
            $('.product_list .button-container').hide();
        else
            $('.product_list .button-container').show();

    $(document).off('mouseenter').on('mouseenter', '.product_list.grid li.ajax_block_product .product-container', function (e) {
        if (screenLg) {
            var pcHeight = $(this).parent().outerHeight();
            var pcPHeight = $(this).parent().find('.button-container').outerHeight() + $(this).parent().find('.comments_note').outerHeight() + $(this).parent().find('.functional-buttons').outerHeight();
            $(this).parent().addClass('hovered').css({
                'height': pcHeight + pcPHeight,
                'margin-bottom': pcPHeight * (-1)
            });
            $(this).find('.button-container').show();
        }
    });

    $(document).off('mouseleave').on('mouseleave', '.product_list.grid li.ajax_block_product .product-container', function (e) {
        if (screenLg) {
            $(this).parent().removeClass('hovered').css({'height': 'auto', 'margin-bottom': '0'});
            $(this).find('.button-container').hide();
        }
    });
}

function quick_view() {
    $(document).on('click', '.quick-view:visible, .quick-view-mobile:visible', function (e) {
        e.preventDefault();
        var url = this.rel;
        var anchor = '';

        if (url.indexOf('#') != -1) {
            anchor = url.substring(url.indexOf('#'), url.length);
            url = url.substring(0, url.indexOf('#'));
        }

        if (url.indexOf('?') != -1)
            url += '&';
        else
            url += '?';

        if (!!$.prototype.fancybox)
            $.fancybox({
                'padding': 0,
                'autoDimensions': false,
                'autoSize': false,
                'width': 1210,
                'height': 866,
                'type': 'iframe',
                'href': url + 'content_only=1' + anchor,
                'afterLoad': function () {
                    var fancyHtml = $('.fancybox-inner iframe').contents().find('html'),
                        fancyDiv = fancyHtml.find('body > div'),
                        primaryBlock = $('.fancybox-inner iframe').contents().find('.primary_block');
                    fancyHtml.css({
                        'height': '100%'
                    });
                    fancyDiv.css({
                        'height': '100%',
                        'overflowY': 'auto',
                        'backgroundColor': '#fff',
                        'borderRadius': '7px'
                    });
                }
            });
    });
}

function bindGrid() {
    var view = $.totalStorage('display');

    if (!view && (typeof displayList != 'undefined') && displayList)
        view = 'list';

    if (view && view != 'grid')
        display(view);
    else
        $('.display').find('li#grid').addClass('selected');

    $(document).on('click', '#grid', function (e) {
        e.preventDefault();
        display('grid');
    });

    $(document).on('click', '#list', function (e) {
        e.preventDefault();
        display('list');
    });
}

function display(view) {
    if (view == 'list') {
        $('ul.product_list').removeClass('grid').addClass('list row');
        $('.product_list > li').removeClass('col-xs-12 col-sm-6 col-md-4').addClass('col-xs-12');
        $('.product_list > li').each(function (index, element) {
            html = '';
            html = '<div class="product-container"><div class="row">';
            html += '<div class="left-block col-xs-4 col-sm-5 col-md-4">' + $(element).find('.left-block').html() + '</div>';
            html += '<div class="center-block col-xs-4 col-sm-7 col-md-4">';
            html += '<div class="product-flags">' + $(element).find('.product-flags').html() + '</div>';
            html += '<h5 itemprop="name">' + $(element).find('h5').html() + '</h5>';
            var rating = $(element).find('.comments_note').html(); // check : rating
            if (rating != null) {
                html += '<div itemprop="aggregateRating" itemscope itemtype="https://schema.org/AggregateRating" class="comments_note">' + rating + '</div>';
            }
            html += '<p class="product-desc">' + $(element).find('.product-desc').html() + '</p>';
            var colorList = $(element).find('.color-list-container').html();
            if (colorList != null) {
                html += '<div class="color-list-container">' + colorList + '</div>';
            }
            var availability = $(element).find('.availability').html();	// check : catalog mode is enabled
            if (availability != null) {
                html += '<span class="availability">' + availability + '</span>';
            }
            html += '</div>';
            html += '<div class="right-block col-xs-4 col-sm-12 col-md-4"><div class="right-block-content row">';
            var price = $(element).find('.content_price').html();       // check : catalog mode is enabled
            if (price != null) {
                html += '<div class="content_price col-xs-5 col-md-12">' + price + '</div>';
            }
            html += '<div class="button-container col-xs-7 col-md-12">' + $(element).find('.button-container').html() + '</div>';
            html += '<div class="functional-buttons clearfix col-sm-12">' + $(element).find('.functional-buttons').html() + '</div>';
            html += '</div>';
            html += '</div></div>';
            $(element).html(html);
        });
        $('.display').find('li#list').addClass('selected');
        $('.display').find('li#grid').removeAttr('class');
        $.totalStorage('display', 'list');
    }
    else {
        $('ul.product_list').removeClass('list').addClass('grid row');
        $('.product_list > li').removeClass('col-xs-12').addClass('col-xs-12 col-sm-6 col-md-4');
        $('.product_list > li').each(function (index, element) {
            html = '';
            html += '<div class="product-container">';
            html += '<div class="left-block">' + $(element).find('.left-block').html() + '</div>';
            html += '<div class="right-block">';
            html += '<div class="product-flags">' + $(element).find('.product-flags').html() + '</div>';
            html += '<h5 itemprop="name">' + $(element).find('h5').html() + '</h5>';
            var rating = $(element).find('.comments_note').html(); // check : rating
            if (rating != null) {
                html += '<div itemprop="aggregateRating" itemscope itemtype="https://schema.org/AggregateRating" class="comments_note">' + rating + '</div>';
            }
            html += '<p itemprop="description" class="product-desc">' + $(element).find('.product-desc').html() + '</p>';
            var price = $(element).find('.content_price').html(); // check : catalog mode is enabled
            if (price != null) {
                html += '<div class="content_price">' + price + '</div>';
            }
            html += '<div itemprop="offers" itemscope itemtype="https://schema.org/Offer" class="button-container">' + $(element).find('.button-container').html() + '</div>';
            var colorList = $(element).find('.color-list-container').html();
            if (colorList != null) {
                html += '<div class="color-list-container">' + colorList + '</div>';
            }
            var availability = $(element).find('.availability').html(); // check : catalog mode is enabled
            if (availability != null) {
                html += '<span class="availability">' + availability + '</span>';
            }
            html += '</div>';
            html += '<div class="functional-buttons clearfix">' + $(element).find('.functional-buttons').html() + '</div>';
            html += '</div>';
            $(element).html(html);
        });
        $('.display').find('li#grid').addClass('selected');
        $('.display').find('li#list').removeAttr('class');
        $.totalStorage('display', 'grid');
    }
}

function dropDown() {
    elementClick = '#header .current';
    elementSlide = 'ul.toogle_content';
    activeClass = 'active';

    $(elementClick).on('click', function (e) {
        e.stopPropagation();
        var subUl = $(this).next(elementSlide);
        if (subUl.is(':hidden')) {
            subUl.slideDown();
            $(this).addClass(activeClass);
        }
        else {
            subUl.slideUp();
            $(this).removeClass(activeClass);
        }
        $(elementClick).not(this).next(elementSlide).slideUp();
        $(elementClick).not(this).removeClass(activeClass);
        e.preventDefault();
    });

    $(elementSlide).on('click', function (e) {
        e.stopPropagation();
    });

    $(document).on('click', function (e) {
        e.stopPropagation();
        var elementHide = $(elementClick).next(elementSlide);
        $(elementHide).slideUp();
        $(elementClick).removeClass('active');
    });
}

function accordionFooter(status) {
    if (status == 'enable') {
        $('#footer .footer-block h4').on('click', function () {
            $(this).toggleClass('active').parent().find('.toggle-footer').stop().slideToggle('medium');
        })
        $('#footer').addClass('accordion').find('.toggle-footer').slideUp('fast');
    }
    else {
        $('.footer-block h4').removeClass('active').off().parent().find('.toggle-footer').removeAttr('style').slideDown('fast');
        $('#footer').removeClass('accordion');
    }
}

function accordion(status) {
    if (status == 'enable') {
        var accordion_selector = '#right_column .block .title_block, #left_column .block .title_block, #left_column #newsletter_block_left h4,' +
            '#left_column .shopping_cart > a:first-child, #right_column .shopping_cart > a:first-child';

        $(accordion_selector).on('click', function (e) {
            $(this).toggleClass('active').parent().find('.block_content').stop().slideToggle('medium');
        });
        $('#right_column, #left_column').addClass('accordion').find('.block .block_content').slideUp('fast');
        if (typeof(ajaxCart) !== 'undefined')
            ajaxCart.collapse();
    }
    else {
        $('#right_column .block .title_block, #left_column .block .title_block, #left_column #newsletter_block_left h4').removeClass('active').off().parent().find('.block_content').removeAttr('style').slideDown('fast');
        $('#left_column, #right_column').removeClass('accordion');
    }
}

function bindUniform() {
    if (!!$.prototype.uniform)
        $("select.form-control,input[type='checkbox']").not(".not_unifrom").uniform();
}
