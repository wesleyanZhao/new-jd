//$('.num_number input:first').click(function(){
//	var num = $('.num_number input:eq(1)').val();
//	if(num>0){
//		num--;
//	}
//	$('.num_number input:eq(1)').val(num);
//});
//
//$('.num_number input:last').click(function(){
//	var num = $('.num_number input:eq(1)').val();
//	$('.num_number input:eq(1)').val(++num);
//})
//
//	var num = parseInt($('.num_number input:eq(1)').val());
//	var price = parseInt($('.price span:last').text());
//	var topr = "￥"+num * price;
//	$('.subtotal span:last').text(topr);
//
//$('.num_number input:first').click(function(){
//	var num = parseInt($('.num_number input:eq(1)').val());
//	var price = parseInt($('.price span:last').text());
//	var topr = "￥"+num * price;
//	$('.subtotal span:last').text(topr);
//});
//
//$('.num_number input:last').click(function(){
//	var num = parseInt($('.num_number input:eq(1)').val());
//	var price = parseInt($('.price span:last').text());
//	var topr = "￥"+num * price;
//	$('.subtotal span:last').text(topr);
//});

var length = $('.goods input:eq(0)').val();
for(var i =0 ; i < length ; i++){
	var price = $('.goods .goods_all .price:eq('+i+') span').text();
	var num = $('.goods .goods_all .num:eq('+i+') .num_number .number').val();
	$('.goods .goods_all .subtotal:eq('+i+') span').text("￥"+num*price);
}

$('.num .num_number .min').click(function(){
	var index = $(this).index('.min');
	var value = $('.num .num_number .number:eq('+index+')').val();
	if(value>1){
		value--;
		$('.num .num_number .number:eq('+index+')').val(value);
	}
	var price = $('.goods .goods_all .price:eq('+index+') span').text();
	var num = $('.goods .goods_all .num:eq('+index+') .num_number .number').val();
	$('.goods .goods_all .subtotal:eq('+index+') span').text("￥"+num*price);
})

$('.num .num_number .add').click(function(){
	var index = $(this).index('.add');
	var value = $('.num .num_number .number:eq('+index+')').val();
	value++;
	$('.num .num_number .number:eq('+index+')').val(value);
	var price = $('.goods .goods_all .price:eq('+index+') span').text();
	var num = $('.goods .goods_all .num:eq('+index+') .num_number .number').val();
	$('.goods .goods_all .subtotal:eq('+index+') span').text("￥"+num*price);
})

$('.num .num_number .number').keyup(function(){
	var index = $(this).index('.number');
	var price = $('.goods .goods_all .price:eq('+index+') span').text();
	var num = $('.goods .goods_all .num:eq('+index+') .num_number .number').val();
	$('.goods .goods_all .subtotal:eq('+index+') span').text("￥"+num*price);
})

