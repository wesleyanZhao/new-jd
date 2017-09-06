<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的购物车</title>
</head>
<link rel="stylesheet" type="text/css" href="/resources/css/shopcar.css">
<script type="text/javascript" src="/resources/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/allgoods.css">
<link rel="stylesheet" href="/resources/layui/css/layui.css">
<body style="height: 100%">
<div class="nav">
	<div class="body">
		<a href="/start.do"><span class="location">北京</span></a>

		<ul>
			<li>
				<c:if test="${vipInfo == null}">
					<a href="/login/loginPage.do"><font>你好，请登录</font></a>
				</c:if>
				<c:if test="${vipInfo != null}">
					<a href="###"><font>你好，${vipInfo.vipAccount}</font></a>
					<a href="javascript:;" id="logout"><font>退出登录</font></a>
				</c:if>
				&nbsp;&nbsp;<a class="register" href="javascript:;"><span>免费注册</span></a>
			</li>
			<li><b></b></li>
			<c:if test="${vipInfo == null}">
				<li><a href="/login/loginPage.do"><font>我的订单</font></a></li>
			</c:if>
			<c:if test="${vipInfo != null}">
				<li><a href="/order/orderFrom.do?vipNo=${vipInfo.vipNo}"><font>我的订单</font></a></li>
			</c:if>
			<li><b></b></li>
			<c:if test="${vipInfo == null}">
				<li><a href="/login/loginPage.do"><font>我的惠买</font></a></li>
				<li><b></b></li>
			</c:if>
			<c:if test="${vipInfo != null}">
				<li><a href="/message/findMessage.do?id=${vipInfo.vipId}" ><font >我的惠买</font></a></li>
				<li><b></b></li>
			</c:if>
			<li><a href="###"><font>惠买会员</font></a></li>
			<li><b></b></li>
			<li><a href="###"><font>企业采购</font></a></li>
			<li><b></b></li>
			<li><a href="###"><font>客服服务</font></a></li>
			<li><b></b></li>
			<li><a href="###"><font>网站导航</font></a></li>
			<li><b></b></li>
			<li><a href="###"><font>手机惠买</font></a></li>
		</ul>
	</div>
</div>

<div class="top">
		<div class="w">
			<div class="top_top">
				<div class="logo"><img src="/resources/img/logoself.jpg" width="267" height="68"></div>
				<form action="/search.do">
				<div class="search">
					<div class="input">
						<input name="prdName" type="text">
						<div class="input_search" align="center">
							<button style="border:none;background: none;display: inline-block;margin-top: 5px;color: white;cursor: pointer">搜索</button>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
	<div class="w">
		<div class="h">
			<div class="choose">
				<input name="all" id="all" onclick="quanxuan()" style="display: none" type="checkbox" value="" /><label style="margin-left: 10px">商品</label><br>
			</div>
			<div class="commodity">
				名称
			</div>
			<div class="price">
				<span>单价</span>
			</div>
			<div class="num" style="margin-left: 35px">
				<span>数量</span>
			</div>
			<div class="subtotal" style="margin-left: -35px">
				<span>小计</span>
			</div>
			<div class="subtotal" style="margin-left:80px">
				<span>存储</span>
			</div>
			<div class="operation">
				<span>操作</span>
			</div>
		</div>
	</div>
	<div class="goods">
		<div class="goods_h">
			<div class="w">
				<input type="hidden" class="length" value="">
				<form id="deleteCarInfo" action="/outcar.do" method="post">
					<c:forEach var="item" items="${list}">
						<div class="shopcarList">
							<div class="goods_all">
								<input type="hidden" calss="id" name="id" value="${item.id }">
								<input type="hidden" style="display: none" class="sss" checked name="sss" value="${item.prdDtlNo}">
								<input type="hidden" value="${item.dpst_id}">
								<div class="choose">
									<div class="miss"></div>
									<img src="${item.phone}" width="80" height="80">
								</div>
								<div class="commodity">
									<div class="miss"></div>
										${item.name}
								</div>
								<div class="price" style="width:40px; margin-left: 50px;">
									<div class="miss"></div>
										${item.price}
									<input type="hidden" class="price1" value="${item.price}">
								</div>
								<div class="num" style="width:180px;">
									<div class="miss"></div>
									<div class="num_number" style="margin-top: 11px;margin-left: 50px">
										<input class="min" type="button" value="-"/>
										<input class="number" readonly= "true" type="text" value="${item.num}"/>
										<input class="add" type="button" value="+"/>
									</div>
								</div>
								<div class="subtotal">
									<div class="miss" ></div>
									<div class="countSum"></div>
								</div>
								<div class="storage1" >
									<div class="miss" style="margin-top: 10px"></div>
									<input class="storage" readonly= "true" style="border:0;width: 200px;color: red;text-align: center" value="${item.storage}">
								</div>
								<div class="operation">
									<a class="deleteCar" vas="${item.id }" style="cursor: pointer;margin-top: 0px">删除</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</form>
			</div>
		</div>
	</div>
	<div class="total_ope">
		<div class="w">
			<div class="total_h">
				<span></span>
				<span></span>
				<span></span>
				<div class="total_price">
					<div class="one">
						<%--已选择0件商品--%>
					</div>
					<div class="two">
						总价：￥<span class="addSum" id="addSum"></span>
					</div>
					<form action="/order/addOrder.do" class="form" method="post">
						<input type="hidden" class="prdDtlNo1" name="prdDtlNo1" value=""/>
						<input type="hidden" class="price2" name="price2" value=""/>
						<input type="hidden" class="num1" name="num1" value=""/>
						<div class="take">
							<input type="submit" class="goSettlement" style="color: #ffffff" value="去结算"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="more_fast_good">
		<div class="w">
			<div class="other_one">
				<img src="/resources/img/service_items_1.png">
			</div>
			<div class="other_two">
				<img src="/resources/img/service_items_2.png">
			</div>
			<div class="other_two">
				<img src="/resources/img/service_items_3.png">
			</div>
			<div class="other_two">
				<img src="/resources/img/service_items_4.png">
			</div>
		</div>
	</div>

	<div class="about-us">
		 <a class="about" rel="nofollow" target="_blank" href="#">关于我们</a>
		|<a rel="nofollow" target="_blank" href="#">联系我们</a>
		|<a rel="nofollow" target="_blank" href="#">联系客服</a>
		|<a rel="nofollow" target="_blank" href="#">合作招商</a>
		|<a rel="nofollow" target="_blank" href="#">商家帮助</a>
		|<a rel="nofollow" target="_blank" href="#">营销中心</a>
		|<a rel="nofollow" target="_blank" href="#">手机惠买</a>
		|<a target="_blank" href="#">友情链接</a>
		|<a target="_blank" href="#">销售联盟</a>
		|<a href="#" target="_blank">惠买社区</a>
		|<a href="#" target="_blank">风险监测</a>
		|<a href="#" target="_blank" clstag="h|keycount|2016|43">隐私政策</a>
		|<a href="#" target="_blank">惠买公益</a>
		|<a href="#" target="_blank">English Site</a>
		|<a href="#" target="_blank">Media &amp; IR</a>
	</div>
</body>
<script type="text/javascript" src="/resources/js/shopcar.js"></script>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script type="text/javascript">

    layui.define(['jquery','form','layer'], function(params) {
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;

        var a = 0;
        var arr1 = new Array;
        var arr2 = new Array;
        var arr3 = new Array;
        var arr4 = new Array;

        $(".shopcarList").each(function () {
            var price = $(this).find('.price1').val();
            var count = $(this).find('.number').val();
            var storage = $(this).find('.storage').val();
            var sss = $(this).find('.sss').val();
            arr1.push(sss);
            arr2.push(count);
            arr3.push(price);
            $(this).find(".countSum").html(price * count);
            a=a+price* count;
            if("" != storage && null !=storage){
                $('.goSettlement').attr("disabled",true);
            }
        });


        //退出登录弹出窗
        $("#logout").on("click",function() {
            layer.confirm('是否退出?', {icon: 3, title: '提示'}, function (index) {
                //do something
                layer.close(index);
                window.location.href = "/vip/logout.do";
            });
        });


        $(".register").on("click", function () {
            var id="";
            layer.open({
                title: '注册 - '
                , area: ['800px', '600px']
                , type: 2 //content内容为一个连接
                , content: '/vip/startregister.do?id='+id
            });

        })

        $(".price2").val(arr3);
        $(".num1").val(arr2);
        $(".prdDtlNo1").val(arr1);
        $("#addSum").text(a);

        $(".min").click(function() {
            var currentCount = $(this).parent().find(".number").val();
            var newPrice = $(this).parent().parent().parent().find(".price").find(".price1").val();
            var countSum = $(this).parent().parent().parent().find(".subtotal").find(".countSum").html() - newPrice;
            $(this).parent().parent().parent().find(".countSum").html(currentCount * newPrice);
            arr2[$(this).index('.min')] = currentCount;
            $(".num1").val(arr2);
            if (countSum >= newPrice) {
                a = a - newPrice;
                $("#addSum").text(a);
            }
        });

		$(".add").click(function(){
			/*alert($(this).index('.add'));*/
			var currentCount = $(this).parent().find(".number").val();
			var newPrice = $(this).parent().parent().parent().find(".price").find(".price1").val();
			$(this).parent().parent().parent().find(".countSum").html(currentCount * newPrice);
			arr2[$(this).index('.add')]=currentCount;
			$(".num1").val(arr2);
			a=a*1+newPrice*1;
			$("#addSum").text(a);
			/*console.log(newPrice);*/
			/*console.log(currentCount);*/
		});

		$(".deleteCar").click(function () {
			var id = $(this).attr("vas");
            $.ajax({
                type:"post",
                url:"/deleteShopCarProducts.do?id="+id,
                success:function(data){
                    location.reload();
                    if (data.result == 'success') {
                        layer.msg('删除成功', {
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        });
                    } else {
                        layer.msg('删除失败', {
                            icon: 0,
                            time: 1000
                        });

                    }
                }
            });
		});

		if($('.prdDtlNo1').val()!=null && $('.prdDtlNo1').val()!=""){
            $('.goSettlement').css('background-color','red');
		}else{
            $('.goSettlement').attr("disabled",true);
		}
	});

    function quanxuan(){
        if(document.getElementById('all').checked==true){
            var inputs = document.getElementsByTagName('input');
            for(var i=0;i<inputs.length;i++){
                if(inputs[i].getAttribute('type')=='checkbox'){
                    if (!inputs[i].checked == true){
                        inputs[i].checked = true;
                    }
                }
            }
        }else{
            var inputs = document.getElementsByTagName('input');
            for(var i=0;i<inputs.length;i++)
            {
                if(inputs[i].getAttribute('type')=='checkbox'){
                    if (inputs[i].checked == true){
                        inputs[i].checked = false;
                    }
                }
            }
        }
    }
</script>
</html>