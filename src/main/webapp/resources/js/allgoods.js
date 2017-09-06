/**
 * 
 */

//待解决问题
// $.ajax({
// 	type:"post",
// 	url:"splitPage.do",
// 	success:function(d){
// 		var nownum = $('.pagenum .choose input:first').val();
// 		var now = parseInt(nownum);
// 		var a = "";
// 		for(var i = 1 ; i <= d.allNum ; i ++){
// 			if(i == now){
//                 a = a + "<a class=\"now\" href=\"search.do?nownum="+i+"\">"+i+"</a>  ";
//                 continue;
// 			}
//             a = a + "<a href=\"search.do?nownum="+i+"\">"+i+"</a>  ";
// 		}
// 		$('.pagenum .choose span').html(a);
// 	}
// })




function tocar(data){
	
	$.ajax({
		url:"toCar.do",
		data:{"goods_id":data},
		dataType:"json",
		success:function(da){
			console.log(da);
			if(da.flage=="true"){
				alert("添加购物车成功");
			}else if(da.flage=="haven"){
				alert("购物车已存在该商品");
			}else if(da.flage=="noacc"){
				alert("请先登录再操作");
			}
			else{
				alert("添加购物车失败");
			}
		}
	})
}

