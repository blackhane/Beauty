/**
 * 
 */
$(function(){
	$('.continue').click(function(){
		location.href="/Beauty/index";
	});
	$('.detail').click(function(){
		location.href="/Beauty/myshop/orderDetail";
	});
	
	$('.order').children('article.orderItem').slice(0,1).show();
	$('#more').click(function(){
		$(this).hide();
		$('#less').show();
		$('.order').children('article.orderItem').slideDown(200);
	});
	$('#less').click(function(){
		$(this).hide();
		$('#more').show();
		$('.order').children('article.orderItem').slice(1).slideUp(200);
	});
});