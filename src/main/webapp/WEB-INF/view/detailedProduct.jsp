<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>商品</title>
</head>
<script type="text/javascript" src="/resources/js/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/detailedProduct.css">
<link rel="stylesheet" href="/resources/layui/css/layui.css">

<link href="/resources/product/css/admin.css" rel="stylesheet" type="text/css" />
<link href="/resources/product/css/amazeui.css" rel="stylesheet" type="text/css" />
<link href="/resources/product/css/demo.css" rel="stylesheet" type="text/css" />
<link href="/resources/product/css/optstyle.css" rel="stylesheet"  type="text/css"/>
<link href="/resources/product/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/resources/product/js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/resources/product/js/quick_links.js"></script>

<script type="text/javascript" src="/resources/product/js/amazeui.js"></script>
<script type="text/javascript" src="/resources/product/js/jquery.imagezoom.min.js"></script>
<script type="text/javascript" src="/resources/product/js/jquery.flexslider.js"></script>
<script type="text/javascript" src="/resources/product/js/list.js"></script>
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
				<li><a href="/message/findMessage.do?id=${vipInfo.vipId}" ><font style="color: red">我的惠买</font></a></li>
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
			<div class="logo">
				<img src="/resources/img/logoself.jpg" width="267" height="68">
			</div>
			<div class="search">
				<form action="/search.do">
					<div class="input">
						<input type="text" name="prdName">
						<div class="input_search" align="center">
							<button style="border:none;background: none;display: inline-block;margin-top: 5px;color: white;">搜索</button>
						</div>
					</div>
				</form>
				<div class="more">
					<span>满1000返1500</span>&nbsp;<span>创维</span>&nbsp;<span>海信</span>&nbsp;<span>康佳</span>&nbsp;<span>飞利浦</span>
				</div>
			</div>
			<div class="car">
                <a href="/shopcar.do?vipAccount=${vipInfo.vipAccount}&&vipNo=${vipInfo.vipNo}">我的购物车</a>
			</div>
		</div>
	</div>
</div>

<hr/>

	<div class="center">
		<div class="w">
			<div class="left">
				<img src="${nowDetailed.imgUrl}" class="url" style="width: 94%">
			</div>
			<div class="right">
				<div class="productName">${prdName}</div>
				<div class="price">
					<span class="priceMark">售价</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span>￥</span><span class="sale_price">${nowDetailed.salePrice}</span>
				</div>

				<form id="form" class="layui-form">
					<c:if test="${length>0}">
						<div class="layui-form-item">
							<span class="classMark" style="font-size:14px">可领代金券</span>&nbsp;&nbsp;&nbsp;&nbsp;
							<c:forEach var="item" items="${cpn}">
								<div class="layui-inline">
									<input type="button" class="layui-btn layui-btn-mini layui-btn-danger cpnInfo" name="${item.cpnNo}" value="${item.cpnContent}">
								</div>
							</c:forEach>
						</div>
					</c:if>

					<div class="layui-form-item">
						<span class="classMark">种类</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="layui-inline">
							<c:forEach var="item" items="${detailed}">
								<div class="layui-inline">
									<input type="button" class="class_class class1" id="${item.prdDtlNo}" ita="${item}" name="prdDtlName" value="${item.prdDtlName}">
								</div>
							</c:forEach>
						</div>
					</div>

					<div class="layui-form-item">
						<span class="number">数量</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="layui-inline">
							<input type="button" value="-" id="min" class="am-btn am-btn-default">
							<input type="text" id="num" value="1" readonly= "true" class="num" name="num" style="width:40px;">
							<input type="button" value="+" id="add" class="am-btn am-btn-default">&nbsp;(库存有<span class="wCount">${nowDetailed.wCount}</span>件)
						</div>
					</div>

					<div class="clear"></div>

					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label"></label>
							<div class="layui-input-inline">
								<input type="button" id="bigCar" class="layui-btn" style="width: 130px ;height: 43px;" value="加入购物车">
							</div>
						</div>
					</div>
				</form>
				<form action="/order/addOrder.do" method="post">
					<input type="hidden" value="${nowDetailed.salePrice}" name="salePrice">
					<input type="hidden" value="${nowDetailed.prdDtlNo}" name="prdDtlNo">
					<input type="hidden" value="${nowDetailed.prdDtlName}" name="prdDtlName">
					<input type="hidden" value="1" name="num" id="numValue">
					<div class="layui-input-inline" style="margin-left:300px;margin-top: -65px">
						<input type="submit" class="big_buy" value="立即购买"></input>
					</div>
				</form>

				<!-- 购物车表单提交-->
				<form  action="/goDetailed1.do" id="sub" method="post">
					<input type="hidden" class="phone1" name="phone" value="${nowDetailed.imgUrl}">
					<input type="hidden" class="productName1" name="productName" value="${prdName}">
					<input type="hidden" class="salePrice1" name="salePrice" value="${nowDetailed.salePrice}">
					<c:forEach var="item" items="${cpn}">
						<input type="hidden" class="cpnContent1" name="cpnContent" value="${item.cpnNo}">
					</c:forEach>
					<c:forEach var="item" items="${detailed}">
						<input type="hidden" class="prdDtlNo1" value="${item.prdDtlNo}" name="prdDtlNo">
						<input type="hidden" class="prdDtlName1" value="${item.prdDtlName}" name="prdDtlName">
					</c:forEach>
					<input type="hidden" value="" id="num1" name="num">
				</form>
			</div>
		</div>
	</div>

<hr/>

<div class="introduce">
	<div class="browse">
		<div class="mc">
			<ul>
				<div class="mt">
					<h2>看了又看</h2>
				</div>
				<li class="first">
					<div class="p-img">
						<a href="#">
							<img class="" src="/resources/product/img/xiaomi5s.png">
						</a>
					</div>
					<div class="p-name">
						<a href="#">
							小米
						</a>
					</div>
					<div class="p-price">
						<strong>￥1799.90</strong>
					</div>
				</li>
				<li>
					<div class="p-img">
						<a href="#">
							<img class="" src="/resources/product/img/huqwei.png">
						</a>
					</div>
					<div class="p-name">
						<a href="#">
							华为
						</a>
					</div>
					<div class="p-price">
						<strong>￥1299.00</strong>
					</div>
				</li>
				<li>
					<div class="p-img">
						<a  href="#">
							<img class="" src="/resources/product/img/meizu.png">
						</a>
					</div>
					<div class="p-name">
						<a href="#">
							魅族
						</a>
					</div>
					<div class="p-price">
						<strong>￥1099.00</strong>
					</div>
				</li>
				<li>
					<div class="p-img">
						<a  href="#">
							<img class="" src="/resources/product/img/sanxingGalaxyS8.png">
						</a>
					</div>
					<div class="p-name">
						<a href="#">
							三星
						</a>
					</div>
					<div class="p-price">
						<strong>￥6988.00</strong>
					</div>
				</li>
				<li>
					<div class="p-img">
						<a  href="#">
							<img class="" src="/resources/product/img/oppor11.png">
						</a>
					</div>
					<div class="p-name">
						<a href="#">
							OPPO
						</a>
					</div>
					<div class="p-price">
						<strong>￥1399.00</strong>
					</div>
				</li>
			</ul>
		</div>
	</div>

	<div class="introduceMain">
		<div class="am-tabs" data-am-tabs>
			<ul class="am-avg-sm-3 am-tabs-nav am-nav am-nav-tabs">
				<li class="am-active">
					<a href="#">
						<span class="index-needs-dt-txt">商品详情</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span class="index-needs-dt-txt">全部评价</span>
					</a>
				</li>
			</ul>

			<div class="am-tabs-bd">
				<div class="am-tab-panel am-fade am-in am-active">
					<div class="J_Brand">
						<div class="attr-list-hd tm-clear">
							<h4>商品参数</h4>
						</div>

						<div class="clear"></div>

						<ul id="J_AttrUL">
							<li title="">品牌:&nbsp;小米</li>
							<li title="">产品类型:&nbsp;手机</li>
							<li title="">原料产地:&nbsp;中国</li>
							<li title="">产地:&nbsp;河北省石家庄</li>
							<li title="">运行内存:&nbsp;4G</li>
							<li title="">机身内存:&nbsp;64G</li>
							<li title="">热点:&nbsp;骁龙芯片、双卡双待</li>
							<li title="">电池容量:&nbsp;4000mAh-5999mAh</li>
							<li title="">商品毛重:&nbsp;430g</li>
							<li title="">机身颜色:&nbsp;金色</li>
							<li title="">前置摄像头像素:&nbsp;500万-799万</li>
							<li title="">后置摄像头像素:&nbsp;1200万-1999万</li>
							<li title="">证书编号:&nbsp;2016011606836121</li>
							<li title="">产品标准号:&nbsp;GB/T 22165</li>
							<li title="">生产许可证编号：&nbsp;QS4201 1801 0226</li>
						</ul>

						<div class="clear"></div>

					</div>

					<div class="details">
						<div class="attr-list-hd after-market-hd">
							<h4>商品细节</h4>
						</div>
						<div class="twlistNews">
							<img src="https://img.alicdn.com/imgextra/i2/268451883/TB21ZhIkFXXXXbpXpXXXXXXXXXX_!!268451883.jpg" />
							<img src="https://img.alicdn.com/imgextra/i3/268451883/TB26PmGXNvzQeBjSZFEXXbYEpXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i3/268451883/TB2xIgSXhwa61BjSspeXXXX9FXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i1/268451883/TB2PXk9XgUc61BjSZFoXXac1FXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i4/268451883/TB2Fj8ph9FjpuFjSspbXXXagVXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i4/268451883/TB2bVyFuhXlpuFjSsphXXbJOXXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i3/268451883/TB20RvIlpXXXXaQXpXXXXXXXXXX_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i4/268451883/TB2d0Ouc.dnpuFjSZPhXXbChpXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i4/268451883/TB2AbAQcb0kpuFjy0FjXXcBbVXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i3/268451883/TB2Psk2cl8kpuFjSspeXXc7IpXa_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i4/268451883/TB2EbtjkFXXXXb4XpXXXXXXXXXX_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i4/268451883/TB2WTHJipXXXXcAXpXXXXXXXXXX_!!268451883.jpg"/>
							<img src="https://img.alicdn.com/imgextra/i1/268451883/TB2n993eVXXXXcAXXXXXXXXXXXX-268451883.jpg"/>
						</div>
					</div>

					<div class="clear"></div>
				</div>

				<!--评论-->
				<div class="am-tab-panel am-fade">
					<div class="actor-new">
						<div class="rate">
							<span>好评度</span>
							<strong>${aveComLevel}<span></span></strong>
							<br/>
						</div>
						<dl>
							<dt>商品评价</dt>
							<dd class="p-bfc">
								<q class="comm-tags"><span>性价比高</span><em>(1771)</em></q>
								<q class="comm-tags"><span>外观漂亮</span><em>(1632)</em></q>
								<q class="comm-tags"><span>系统流畅</span><em>(1625)</em></q>
								<q class="comm-tags"><span>反应快</span><em>(1407)</em></q>
								<q class="comm-tags"><span>功能齐全</span><em>(1300)</em></q>
								<q class="comm-tags"><span>支持国产</span><em>(1218)</em></q>
								<q class="comm-tags"><span>照相不错</span><em>(1122)</em></q>
								<q class="comm-tags"><span>国民手机</span><em>(1082)</em></q>
								<q class="comm-tags"><span>分辨率高</span><em>(968)</em></q>
								<q class="comm-tags"><span>信号稳定</span><em>(882)</em></q>
							</dd>
						</dl>
					</div>

					<div class="clear"></div>

					<div class="tb-r-filter-bar">
						<ul class=" tb-taglist am-avg-sm-4">
							<li class="tb-taglist-li tb-taglist-li-current">
								<div class="comment-info">
									<span>全部评价</span>
									<span class="tb-tbcr-num">(${resultPrdComSize})</span>
								</div>
							</li>

							<li class="tb-taglist-li tb-taglist-li-1">
								<div class="comment-info">
									<span>好评</span>
									<span class="tb-tbcr-num">(${goodCom})</span>
								</div>
							</li>

							<li class="tb-taglist-li tb-taglist-li-0">
								<div class="comment-info">
									<span>中评</span>
									<span class="tb-tbcr-num">(${midCom})</span>
								</div>
							</li>

							<li class="tb-taglist-li tb-taglist-li--1">
								<div class="comment-info">
									<span>差评</span>
									<span class="tb-tbcr-num">(${badCom})</span>
								</div>
							</li>

						</ul>
					</div>

					<div class="clear"></div>

					<div <%--style="height: 1300px;"--%>>
						<ul class="am-comments-list am-comments-list-flip">
							<c:forEach items="${resultPrdCom}" var="item" >
								<li class="am-comment">
									<!-- 评论容器 -->
									<a href="">
										<img class="am-comment-avatar" src="/resources/product/img/hwbn40x40.jpg" /><!-- 评论者头像 -->
									</a>
									<div class="am-comment-main">
										<!-- 评论内容容器 -->
										<header class="am-comment-hd">
											<div class="am-comment-meta">
												<a href="#link-to-user" class="am-comment-author">${item.vipAccount}</a>
												<!-- 评论者 -->
												评论于
												<time datetime="">${item.ordStsDate}</time>
												<span style="float: right;">&nbsp;&nbsp;
														<c:forEach begin="1" end="${item.cmmLevel}" step="1">
															<span style="color: red;">❤</span>
														</c:forEach>
													</span>
											</div>

										</header>

										<div class="am-comment-bd">
											<div class="tb-rev-item " data-id="255776406962">
												<div class="J_TbcRate_ReviewContent tb-tbcr-content ">
													${item.content}<!-- 评论内容 -->
												</div>
												<br/>
												<div class="tb-r-act-bar">
													商品：&nbsp;&nbsp;${item.prdDtlName}
												</div>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>

					</div>

					<div class="clear"></div>

					<%--<div class="tb-reviewsft">
						<div class="tb-rate-alert type-attention">购买前请查看该商品的 <a href="#" target="_blank">购物保障</a>，明确您的售后保障权益。</div>
					</div>--%>
				</div>
			</div>
		</div>

		<div class="clear"></div>

		<div class="footer">
			<div class="footer-hd">
				<p style="text-align: center">
					<a href="#">蓝鸥科技</a>
					<b>|</b>
					<a href="#">惠买集团</a>
					<b>|</b>
					<a href="#">商城首页</a>
					<b>|</b>
					<a href="#">支付宝</a>
					<b>|</b>
					<a href="#">物流</a>
				</p>
			</div>

			<div class="footer-bd">
				<p style="text-align: center">
					<a href="#">关于蓝鸥</a>
					<a href="#">合作伙伴</a>
					<a href="#">联系我们</a>
					<a href="#">网站地图</a>
					<br/>
					<em>© 2015-2025 LanOu.com 版权所有 Copyright © 2017 <a href="http://www.lanou3g.com" target="_blank">lanou</a> Powered by lanou</em>
				</p>
			</div>
		</div>
	</div>
</div>

<!--菜单 -->
<div class=tip>
	<div id="sidebar">
		<div id="wrap">
			<div id="prof" class="item">
				<a href="#">
					<span class="setting"></span>
				</a>
				<div class="ibar_login_box status_login">
					<div class="avatar_box">
						<p class="avatar_imgbox">
							<img src="/resources/product/img/no-img_mid_.jpg"/>
						</p>
						<ul class="user_info">
							<li>用户名：${vipInfo.vipAccount}</li>

						</ul>
					</div>
					<div class="login_btnbox">
						<a href="/order/orderFrom.do?vipNo=${vipInfo.vipNo}" class="login_order">我的订单</a>
						<a href="#" class="login_favorite">我的收藏</a>
					</div>
					<i class="icon_arrow_white"></i>
				</div>
			</div>

			<a href="/shopcar.do?vipAccount=${vipInfo.vipAccount}&&vipNo=${vipInfo.vipNo}">
				<div id="shopCart" class="item">
					<span class="message"></span>
					<p style="color: #ffffff;margin-top: 40px">购物车</p>
				</div>
			</a>


			<div id="asset" class="item">
				<a href="#">
					<span class="view"></span>
				</a>
				<div class="mp_tooltip">
					我的资产
					<i class="icon_arrow_right_black"></i>
				</div>
			</div>

			<div id="foot" class="item">
				<a href="#">
					<span class="zuji"></span>
				</a>
				<div class="mp_tooltip">
					我的足迹
					<i class="icon_arrow_right_black"></i>
				</div>
			</div>

			<div id="brand" class="item">
				<a href="#">
						<span class="wdsc">
							<img src="/resources/product/img/wdsc.png"/>
						</span>
				</a>
				<div class="mp_tooltip">
					我的收藏
					<i class="icon_arrow_right_black"></i>
				</div>
			</div>

			<div id="broadcast" class="item">
				<a href="#">
						<span class="chongzhi">
							<img src="/resources/product/img/chongzhi.png"/>
						</span>
				</a>
				<div class="mp_tooltip">
					我要充值
					<i class="icon_arrow_right_black"></i>
				</div>
			</div>

			<div class="quick_toggle">
				<li class="qtitem">
					<a href="#">
						<span class="kfzx"></span>
					</a>
					<div class="mp_tooltip">
						客服中心
						<i class="icon_arrow_right_black"></i>
					</div>
				</li>
				<!--二维码 -->
				<li class="qtitem">
					<a href="#none">
						<span class="mpbtn_qrcode"></span>
					</a>
					<div class="mp_qrcode" style="display:none;">
						<img src="/resources/product/img/weixin_code_145.png" />
						<i class="icon_arrow_white"></i>
					</div>
				</li>
				<li class="qtitem">
					<a href="#top" class="return_top">
						<span class="top"></span>
					</a>
				</li>
			</div>
			<!--回到顶部 -->
			<div id="quick_links_pop" class="quick_links_pop hide"></div>
		</div>
	</div>
</div>

</body>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script>



    var num = 1;

    layui.use(['jquery','layedit','form','layer','element','laypage'],function () {
        var layedit = layui.layedit;
        var form = layui.form;
        var layer = layui.layer;
        var element = layui.element();
        var laypage = layui.laypage;

        var prdDtlNo="${nowDetailed.prdDtlNo}";
        $('#'+prdDtlNo+'').css('background-color','red');
        if($('.wCount').html()<1){
            $('#bigCar').attr("disabled",true);
        }

        $('.class_class').click(function () {
            $('#prdDtlNo').css('display', null);
            var ita=$(this).attr('ita');
            var arr = ita.split(',');
            var ara = arr[5].split('=');
            var ard = arr[4].split('=');
            var are = arr[3].split('=');
            var arn = arr[1].split('=');
            var arb = ara[1].split('}');
            var aru = arr[0].split('=');
            $('.sale_price').html(are[1]);
            $('.wCount').html(arb[0]);
            $('.url').attr('src',aru[1]);
            $('.class1').css('background-color','');
            var prdDtlNo = ard[1];
            $('#'+prdDtlNo+'').css('background-color','red');
            $('.prdDtlNo1').val(prdDtlNo);
            $('.phone1').val(aru[1]);
            $('.salePrice1').val(are[1]);
            $('.prdDtlName1').val(arn[1]);
            $('.num').val(1);
        });


        $('.cpnInfo').click(function () {
            var name = $(this).attr('name');
            $.ajax({
                url:"/addCpn.do",
                data:{"cpnNo":name},
                type:"post",
                success:function (data) {
                    console.log(data.result);
                    if(data.result == "success"){
                        layer.msg('领取成功',{
                            icon:1,
                            timeout:1000
                        });
                    }else if(data.result == "failure"){
                        layer.msg('领取失败',{
                            icon:0,
                            timeout:1000
                        });
                    }else{
                        layer.msg('已领取过',{
                            icon:0,
                            timeout:1000
                        });
                    }
                }
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

        $('#min').click(function () {
            var num = $('#num').val();
            if(num>1){
                num = num -1;
                $('#num').val(num);
                $("#numValue").val(num)
            }
        });

        $('#add').click(function(){
            var wCount = "${nowDetailed.wCount}"
            var num = parseInt($('#num').val());
            if(num<wCount){
                num = num + 1;
                $('#num').val(num);
                $("#numValue").val(num)
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




        $('#bigCar').click(function () {
           	var num1 = $("#num").val();
            $('#num1').val(num1);
           	var data = $("#sub").serializeArray();
           	console.log(data)
			var vipId="${vipInfo.vipId}";
			if("" == vipId){
                window.location.href = "/login/loginPage.do";
			}
            /*$("#sub").submit();*/
            $.ajax({
                type:"post",
                url:"/goDetailed1.do",
				data:data,
                success:function(data) {
                    if (data.result == 'success') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        });
                    } else {
                        layer.msg('添加失败', {
                            icon: 0,
                            time: 1000
                        });
						/*location.reload();*/
                    }
                }
            });
        });
    });

</script>
</html>