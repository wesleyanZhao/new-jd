var flage1 = false;
var flage2 = false;
var flage3 = false;

$('#account input:last').click(function(){
	$(this).val('');
	$('#account span').text('只能输入5-20个以字母开头、可带数字、“_”、“.”的字串 ');
	$('#account span').css({'font-size':'12px','color':'rgb(201,201,201)'});
});

$('#account input:last').blur(function(){
	var account = $(this).val();
	var str = /^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$/;
	if(account.match(str)){
		$.ajax({
			type:"post",
			url:"registerajax.do",
			dataType:"json",
			data:{"account":account},
			success:function(data){
				if(data==true){
					flage1 = true;
					$('#account span').text("√");
					$('#account span').css('color','green');
				}
				if(data==false){
					flage1 = false;
					$('#account span').text("×");
					$('#account span').css('color','red');
				}
			}
		})
	}else{
		flage1 = false;
		$(this).val('');
		$('#account span').text('格式不正确，请重新输入！');
		$('#account span').css({'color':'red','font-size':'12px'});
	}
	
});

$('.password:first input:last').click(function(){
	$('.password:first input:last').val('');
	$('.password:first span').text('密码建议用字母，数字和特殊字符的组合！ ');
	$('.password span').css({'font-size':'12px','color':'rgb(201,201,201)'});
})

/*强密码
 &nbsp;
 &nbsp;^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)(?![a-zA-z\d]+$)(?![a-zA-z!@#$%^&*]+$)(?![\d!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]+$
 &nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;	
 * */

/*中
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]+$

 * */

/*弱
 * ^(?:\d+|[a-zA-Z]+|[!@#$%^&*]+)$
 * */

$('.password:first input:last').blur(function(){
	var str1 = /^(?:\d+|[a-zA-Z]+|[!@#$%^&*]+)$/;
	var str2 = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]+$/;
	var str3 = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)(?![a-zA-z\d]+$)(?![a-zA-z!@#$%^&*]+$)(?![\d!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]+$/;
	var val = $('.password:first input:last').val();
	if(val!=''){
		if(val.match(str1)){
			$('.password:first span').text('弱');
			$('.password:first span').css('color','green');
		}
		if(val.match(str2)){
			$('.password:first span').text('中');
			$('.password:first span').css('color','green');
		}
		if(val.match(str3)){
			$('.password:first span').text('强');
			$('.password:first span').css('color','green');
		}
	}else{
		$('.password:first span').text('密码不能为空！');
		$('.password:first span').css('color','red');
	}
})
$('.password:last input:last').blur(function(){
	var val1 = $('.password:first input:last').val();
	var val2 = $('.password:last input:last').val();
	if(val1!=''&&val2!=''){
		if(val1!=val2){
			flage2=false;
			$('.password:last span').text('两次密码输入不一致，请重新输入！');
			$('.password:last span').css('color','red');
		}else{
			flage2=true;
			$('.password:last span').text('正确')
			$('.password:last span').css('color','green');
		}
	}else{
		flage2=false;
		$('.password:last span').text('密码不能为空！');
		$('.password:last span').css('color','red');
	}
})

$('.phone:first input:last').click(function(){
	$(this).val('');
	$('.phone:first span').text('请输入你要注册的手机号 ');
	$('.phone:first span').css({'font-size':'12px','color':'rgb(201,201,201)'});
})
$('.phone:first input:last').blur(function(){
	var str = /^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\d{8}$/;
	if($(this).val().match(str)){
		var phone = $(this).val();
		//var mark = $('.phone:first input:first').val();
		$.ajax({
			type:"post",
			data:{"phone":phone},
			url:"registerajax.do",
			success:function(data){
				if(data==true){
					flage3 = true;
					$('.phone:first span').text("√");
					$('.phone:first span').css('color','green');
				}
				if(data==false){
					flage3 = false;
					$('.phone:first span').text("×");
					$('.phone:first span').css('color','red');
				}
			}
		})
	}else{
		flage3 = false;
		$(this).val('');
		$('.phone:first span').text('请输入正确的手机号！ ');
		$('.phone:first span').css({'font-size':'12px','color':'red'});
	}
})

$('input[type=submit]').click(function(){
	if(flage1&&flage2&&flage3){
		return true;
	}else{
		return false;
	}
})

