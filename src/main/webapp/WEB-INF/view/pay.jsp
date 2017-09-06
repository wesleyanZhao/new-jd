<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0 ,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<title>结算页面</title>
		<link href="/resources/css/amazeui.css" rel="stylesheet" type="text/css" />
		<link href="/resources/css/demo.css" rel="stylesheet" type="text/css" />
		<link href="/resources/css/cartstyle.css" rel="stylesheet" type="text/css" />
		<link href="/resources/css/jsstyle.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/resources/js/jquery-3.2.1.js"></script>

		<script src="/resources/js/address.js"></script>

		<script type="text/javascript" >
			var ordPrice;
            $(document).ready(function () {

                var count = $("#prdDtlList").find(".productS").length;
                var num=0;
                var definite=0;
                var voucher=0;
                var totalPrice=0;
                var sub=0;
                var array=new Array();

                $("#prdDtlList").find(".productS").each(function (index,element) {
                    var price= $(element).find(".td-sum div .sum").text();
                    num=Number(num*1+price*1).toFixed(2);
                    if(count-1==index){
                        $(".payNum").text(num);
                        $("#payNum").val(num);
                        $("#ordPrice").val(num)
                    }
                });
				$("#accPoint").change(function () {
                    var accPoint=$(this).val();
                    var integral=$(".pay-sum").text();
                    integral=integral*1;
                    if(''!=accPoint){
                        if(integral>=accPoint){
                            if(sub==0){
                                var discount=Number(accPoint/100).toFixed(2);
                                var dif=Number(num/2).toFixed(2);
                                discount = discount - 0;
                                dif = dif - 0;
                                if(dif>=discount){
                                    definite=0;
                                    definite=discount;
                                    $('#discount').text("可抵￥"+discount);
                                    sum();
                                }else{
                                    $('#discount').text("使用积分过量");
                                }
                            }else{
                                var discount=Number(accPoint/100).toFixed(2);
                                var dif=Number(sub/2).toFixed(2);
                                discount = discount - 0;
                                dif = dif - 0;
                                if(dif>=discount){
                                    definite=0;
                                    definite=discount;
                                    $('#discount').text("可抵￥"+discount);
                                    sum();
                                }else{
                                    $('#discount').text("使用积分过量");
                                }
                            }
                        }else{
                            $("#discount").text("积分不足!!!");
                        }
					}else{
                        $("#discount").text("");
                        definite=0;
                        sum();
					}


                });

				// 企划编号_商品明细编号对应array
				var list = new Array();

                $(".shopAction").change(function () {
                    var spNo=$(this).val();
                    var i=$(this).index(".shopAction");
                    var prdDtlNo = $(this).parent().parent().find(".item-info").find("div input").val();
                    var prdCount=$(this).parent().parent().parent().parent().find(".item-amount").find("div input:eq(2)").val();
                    var price=$(this).parent().parent().parent().parent().find(".singlePrice").val();
                    var payNum=$("#payNum").val();
                    var b=1;
                    if(1==b){
                        totalPrice=price;
                        b=b+1;
					}
                    if(''!=spNo){
                        $.ajax({
                            type:"post",
                            url:"/order/messagesPage.do",
                            data:{"spNo":spNo,"prdDtlNo":prdDtlNo,"prdCount":prdCount,"price":price},
                            success:function(data){
                                if(0!=payNum){
                                    if(10==data.conType){
                                        array[i]=Number(price-data.price).toFixed(2);
                                        $(".sum:eq("+i+")").text(data.price);
                                        sum();
                                    }else if(40==data.conType){
                                        array[i]=Number(price-data.price).toFixed(2);
                                        $(".sum:eq("+i+")").text(data.price);
                                        sum();
                                    }else if(50==data.conType){
                                        array[i]=Number(price-data.price).toFixed(2);
                                        $(".sum:eq("+i+")").text(data.price);
                                        sum();
                                    }else{
                                        array[i]=0;
                                        $(".sum:eq("+i+")").text(totalPrice);
                                        sum();
                                    }
								}

                            }
                        });
                        console.log(array);
					}else{
                        $(".sum:eq("+i+")").text(totalPrice);
                        array[i]=0;
                        sum();
					}
					var spNo = $(this).val();
                    $("#spNo").val(spNo);
                    if(spNo != "") {
                        list.push(spNo + "_" + prdDtlNo);
                    }
                    $.unique(list);
                });

                $("#cpnContent").change(function () {
					var cpnSum=$(this).val().split(",")[1];

					if(null!=cpnSum){
                        voucher=cpnSum;
						sum();
					}else{
                        voucher=0;
                        sum();
					}

                });
                function sum () {
                    var consale=0;
                    for(var i=0;array.length>i;i++){
                        if(undefined!=array[i]){
                            consale=consale*1+array[i]*1;
                        }
                    }
                    console.log(consale);
                    sub=Number(num*1-consale*1-definite*1-voucher*1).toFixed(2);
                    console.log(sub);
					 if(0==sub){
                         $(".payNum").text(0);
                         $("#payNum").val(0);
					 }else{
                         $(".payNum").text(sub);
                         $("#payNum").val(sub);
					 }
                }

                $(".urlClick").click(function () {
                    $("input[type='radio']:checked").attr("checked", false);
                    $(this).find("input[type='radio']").attr("checked", 'checked');
					//console.log($("input[type='radio']:checked"));
                });

                var arr1 = new Array;
                var arr2 = new Array;
                var arr3 = new Array;
                var arr4 = new Array;
                var arr5 = new Array;
                var arr6 = new Array;
                $(".list").each(function () {
                    var prdDtlNo = $(this).find('.prdDtlNo').val();
                    var salePrice = $(this).find('.realSum').val();
                    var prdCount = $(this).find('.prdCount').val();
                    var sumMoney = $(this).find('.singlePrice').val();
                    var ordDtlId = $(this).find('.ordDtlId').val();
					var tpCd = $(this).find('.tpCd').val();

                    arr1.push(prdDtlNo);
                    arr2.push(salePrice);
                    arr3.push(prdCount);
                    arr4.push(sumMoney);
                    arr5.push(ordDtlId);
                    arr6.push(tpCd);
                });

                $("#prdDtlNo1").val(arr1);
                $("#salePrice1").val(arr2);
                $("#prdCount1").val(arr3);
                $("#sumMoney1").val(arr4);
                $("#ordDtlId1").val(arr5);
                $("#tpCd1").val(arr6);

                $("#J_Go").click(function () {
                    if(list.length != 0) {
                        for(var i=0;i<list.length;i++) {
                            $("form").append($('<input type="checkbox" name="spNos" checked style="display: none" value="'+list[i] +'"/>'));
                        }
                    } else {
                        $("form").append($('<input type="checkbox" name="spNos" checked style="display: none" value="0"/>'));
					}
					$("form").submit();
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

                //退出登录弹出窗
                $("#logout").on("click",function() {
                    layer.confirm('是否退出?', {icon: 3, title: '提示'}, function (index) {
                        //do something
                        layer.close(index);
                        window.location.href = "/vip/logout.do";
                    });
                });

                $("#cancleBtn").click(function () {
                    $("#user-name").attr("disabled","disabled");
                });
                $("#show").click(function () {
                    $("#user-name").removeAttr("disabled");
                });

            });

		</script>
	</head>
	<body style="height: 100%">
	<form action="/order/addPayInfo.do" method="post">
		<input name="ordId" value="${map.get("ordId")}" type="hidden"/>
		<input name="ordNo" value="${map.get("ordNo")}" type="hidden"/>
		<!--顶部导航条 -->
		<div class="am-container header">
			<ul class="message-l">
				<div class="topMessage">
					<div class="menu-hd">
						<c:if test="${vipInfo == null}">
							<a href="/login/loginPage.do"><font>你好，${map.userName }</font></a>
						</c:if>
						<c:if test="${vipInfo != null}">
							<a href="###"><font>你好，${vipInfo.vipAccount}</font></a>
							<a href="javascript:;" id="logout"><font>退出登录</font></a>
						</c:if>
						<a class="register" href="javascript:;"><span>免费注册</span></a>
					</div>
				</div>
			</ul>
			<ul class="message-r">
				<div class="topMessage home">
					<div class="menu-hd"><a href="/start.do" target="_top" class="h">商城首页</a></div>
				</div>
				<div class="topMessage my-shangcheng">
					<div class="menu-hd MyShangcheng"><a href="/message/findMessage.do?id=${vipInfo.vipId}" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a></div>
				</div>
				<div class="topMessage mini-cart">
					<div class="menu-hd"><a id="mc-menu-hd" href="#" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
				</div>
				<div class="topMessage favorite">
					<div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a></div>
				</div>
			</ul>
			</div>
			<div class="clear"></div>
			<div class="concent">
				<!--地址 -->
				<div class="paycont">
					<div class="address">
						<h3>确认收货地址 </h3>
						<div class="control">
							<div class="tc-btn createAddr theme-login am-btn am-btn-danger">是否需要发票</div>
						</div>
						<div class="clear"></div>
						<ul>

							<div class="per-border"></div>

							<c:forEach items="${map.siteList}" var="list" >
								<c:if test="${list.addState==0}">
									<li class="user-addresslist defaultAddr urlClick">
										<input type="radio" value="${list.siteId}" name="vipAddressId" style="display: none;" checked/>
										<div class="address-left">
											<i>默认地址:</i>
											<div class="user DefaultAddr">
												<span class="buy-address-detail">
													<input type="hidden" value="${map.get("realName")}" name="realName"/>
													<input type="hidden" value="${map.get("secondPhoneNo")}" name="secondPhoneNo"/>
													<span class="buy-user">${map.get("realName")} </span>
													<span class="buy-phone">${map.get("secondPhoneNo")}</span>
												</span>
											</div>
											<div class="default-address DefaultAddr">
												<span class="buy-line-title buy-line-title-type">收货地址：</span>
												<span class="buy--address-detail">
													<span class="province">${list.get("province")}</span>
													<span class="city">${list.get("city")}</span>
													<span class="addrInfo">${list.get("addrInfo")}</span>
												</span>
											</div>
										</div>
										<div class="clear"></div>
									</li>
									<div class="per-border"></div>
								</c:if>
								<c:if test="${list.addState==1}">
									<li class="user-addresslist urlClick">
										<input type="radio" value="${list.siteId}" name="vipAddressId" style="display: none;"/>
										<div class="address-left">
											<div class="user DefaultAddr">
												<span class="buy-address-detail">
													<span class="buy-user">${map.get("realName")} </span>
													<span class="buy-phone">${map.get("secondPhoneNo")}</span>
												</span>
											</div>
											<div class="default-address">
												<span class="buy-line-title buy-line-title-type">收货地址：</span>
												<span class="buy--address-detail">
													<span class="province">${list.get("province")}</span>
													<span class="city">${list.get("city")}</span>
													<span class="addrInfo">${list.get("addrInfo")}</span>
												</span>
											</div>
										</div>
										<div class="clear"></div>
									</li>
									<div class="per-border"></div>
								</c:if>
							</c:forEach>
						</ul>
						<div class="clear"></div>
					</div>
				</div>
					<!--物流 -->
					<div class="logistics">
						<h3>选择物流方式</h3>
						<ul class="op_express_delivery_hot">
							<li data-value="yuantong" class="OP_LOG_BTN  "><i class="c-gap-right" style="background-position:0px -468px"></i>圆通<span></span></li>
							<li data-value="shentong" class="OP_LOG_BTN  "><i class="c-gap-right" style="background-position:0px -1008px"></i>申通<span></span></li>
							<li data-value="yunda" class="OP_LOG_BTN  "><i class="c-gap-right" style="background-position:0px -576px"></i>韵达<span></span></li>
							<li data-value="zhongtong" class="OP_LOG_BTN op_express_delivery_hot_last "><i class="c-gap-right" style="background-position:0px -324px"></i>中通<span></span></li>
							<li data-value="shunfeng" class="OP_LOG_BTN  op_express_delivery_hot_bottom"><i class="c-gap-right" style="background-position:0px -180px"></i>顺丰<span></span></li>
						</ul>
					</div>
					<div class="clear"></div>

					<!--支付方式-->
					<div class="logistics">
						<h3>选择支付方式</h3>
						<ul class="pay-list">
							<li class="pay card"><img src="/resources/images/wangyin.jpg" />银联<span></span></li>
							<li class="pay qq"><img src="/resources/images/weizhifu.jpg" />微信<span></span></li>
							<li class="pay taobao"><img src="/resources/images/zhifubao.jpg" />支付宝<span></span></li>
						</ul>
					</div>
					<div class="clear"></div>

					<!--订单 -->
					<div class="concent">
						<div id="payTable">
							<h3>确认订单信息</h3>
							<div class="cart-table-th">
								<div class="wp">
									<div class="th th-item">
										<div class="td-inner">商品名称</div>
									</div>
									<div class="th th-price">
										<div class="td-inner">单价</div>
									</div>
									<div class="th th-amount">
										<div class="td-inner">数量</div>
									</div>
									<div class="th th-sum">
										<div class="td-inner">金额</div>
									</div>
									<div class="th th-oplist">
										<div class="td-inner">配送方式</div>
									</div>
								</div>
							</div>
							<div class="clear"></div>
							<div id="prdDtlList">
								<c:forEach items="${map.prdDtlList}" var="prdList">
									<div class="list">
									<div class="bundle-main productS">
										<ul class="item-content clearfix">
											<div class="pay-phone">
												<li class="td td-item">
													<div class="item-pic">
														<a href="#" class="J_MakePoint">
															<input name="ordDtlId" value="${prdList.get("ordDtlId")}" type="hidden" class="ordDtlId"/>
															<img src="${prdList.get("imgUrl")}" class="itempic J_ItemImg" style="width: 80px;height: 80px;">
														</a>
													</div>
													<div class="item-info">
														<div class="item-basic-info" style="margin-right: 100px">
															<input name="prdDtlNo" value="${prdList.get("prdDtlNo")}" type="hidden" class="prdDtlNo"/>
															<i  class="item-title J_MakePoint" data-point="tbcart.8.11" ><center>${prdList.get("prdDtlName")}</center></i>
														</div>
													</div>
													<div style="margin-left: 180px;margin-top: 10px">
														<span class="bonus-title" >商品活动</span>
														<input name="spNo" value="" type="hidden" class="spNo"/>
														<!-- 选择企划 -->
														<select data-am-selected class="shopAction">
															<option value="" selected>请选择</option>
															<c:forEach items="${prdList.plan}" var="proList">
																<option value="${proList.spNo}">${proList.spName}</option>
															</c:forEach>
														</select>
													</div>
												</li>
												<li class="td td-price">
													<div class="item-price price-promo-promo">
														<div class="price-content">
															<input name="realSum" value="${prdList.get("salePrice")}" type="hidden" class="realSum"/>
															<input class="text_box realSum" name="realSum"  type="text" value="${prdList.get("salePrice")}" style="width:40px;border: none;" />
														</div>
													</div>
												</li>
											</div>
											<li class="td td-amount">
												<div class="amount-wrapper">
													<div class="item-amount">
														<div class="sl">
															<input name="prdCount" value="${prdList.get("num")}" type="hidden" class="prdCount"/>
															<input name="tpCd" value="${prdList.get("tpCd")}" type="hidden" class="tpCd"/>
															<input class="text_box prdCount" name="num" class="prdCount" type="text" value="${prdList.get("num")}" style="width:30px;border: none;" />
														</div>
													</div>
												</div>
											</li>
											<li class="td td-sum">
												<div class="td-inner">
													<input type="hidden" value="${prdList.get("price")}" name="price" class="singlePrice"/>
													<em tabindex="0" class="J_ItemSum number sum">${prdList.get("price")}</em>
												</div>
											</li>
											<li class="td td-oplist">
												<div class="td-inner">
													<span class="phone-title">配送方式</span>
													<div class="pay-logis">
														包邮
													</div>
												</div>
											</li>
										</ul>
										<div class="clear"></div>
									</div>
									</div>
								</c:forEach>
							</div>


							<div class="clear"></div>
							<div class="pay-total"></div>
							<div class="order-extra">
								<div class="order-user-info">
									<div id="holyshit257" class="memo">
										<label>可用积分：</label>
											<em class="pay-sum">${map.accPoint}</em>
										&nbsp;&nbsp;&nbsp;
										<i style="font-size: 5px">最高抵销支付金额的一半</i>
										&nbsp;&nbsp;&nbsp;
										<label>使用积分：</label>
										<input  id="accPoint" type="text" name="sumPoint" placeholder="请输入使用积分" style="outline: none;"/>
										<i id="discount" style="color: #ea1328;"></i>
									</div>
								</div>

							</div>
							<!--优惠券 -->
							<div class="buy-agio">
								<li class="td td-coupon">
									<span class="coupon-title">可用优惠券</span>
									<%--<input type="checkbox" name="wNo" value="${item.w_no! ''}" style="display: none;">
									<input type="text" name="wCount${item.w_no! ''}">--%>
									<input type="hidden" name="spNo" id="spNo" value="">
									<select data-am-selected  id="cpnContent" name="cpnContent">
										<option value="" selected>请选择</option>
										<c:forEach items="${map.tkAmtList}" var="cpn">
											<option value="${cpn.cpnNo},${cpn.cpnSum}">${cpn.cpnContent}</option>
										</c:forEach>
									</select>
								</li>
							</div>
							<div class="clear"></div>
							<div class="order-go clearfix">
								<div class="pay-confirm clearfix">
									<div class="box">
										<div tabindex="0" id="holyshit267" class="realPay"><em class="t">实付款：</em>
											<span class="price g_price ">
                                    		<span>¥</span> <em class="style-large-bold-red  payNum" id="J_ActualFee"></em>
											<input type="hidden" name="payNum" id="payNum"/>
											</span>
										</div>
									</div>

									<div id="holyshit269" class="submitOrder">
										<div class="go-btn-wrap">
											<input type="hidden" name="tpCd1" id="tpCd1" value=""/>
											<input type="hidden" name="ordPrice" id="ordPrice" value=""/>
											<input type="hidden" name="realPrice" id="realPrice" value=""/>
											<input type="hidden" name="spNo1" id="spNo1" value=""/>
											<input type="hidden" name="ordDtlId1" id="ordDtlId1" value=""/>
											<input type="hidden" name="prdDtlNo1" id="prdDtlNo1" value=""/>
											<input type="hidden" name="salePrice1" id="salePrice1" value=""/>
											<input type="hidden" name="prdCount1" id="prdCount1" value=""/>
											<input type="hidden" name="sumMoney1" id="sumMoney1" value=""/>
											<input type="button" id="J_Go" value="支付订单" class="btn-go" tabindex="0" title="点击此按钮，提交支付" style="margin-left: 880px;
												border: none;"/>
											<%--<a id="J_Go" href="success.html" class="btn-go" tabindex="0" title="点击此按钮，提交支付">支付订单</a>--%>
										</div>
									</div>
									<div class="clear"></div>
								</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				<div class="footer">
					<div class="footer-hd">
						<p>
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
						<p>
							<a href="#">关于惠买</a>
							<a href="#">合作伙伴</a>
							<a href="#">联系我们</a>
							<a href="#">网站地图</a>
						</p>
					</div>
				</div>
			</div>
			<div class="theme-popover-mask"></div>
		<div class="theme-popover">
			<div class="am-cf am-padding">
				<div class="am-fl am-cf"><div class="am-text-danger am-text-lg">发票信息</div></div>
			</div>
			<hr/>
			<div class="am-u-md-12">
				<div class="am-form am-form-horizontal">
					<div class="am-form-group">
						<label for="user-name" class="am-form-label">发票抬头</label>
						<div class="am-form-content">
							<input type="text" id="user-name"  name="billHeader" placeholder="发票抬头">
						</div>
					</div>
					<div class="am-form-group">
						<label for="user-phone" class="am-form-label">税号</label>
						<div class="am-form-content">
							<input id="user-phone" name="billNumber" placeholder="税号必填" type="text">
						</div>
					</div>
					<div class="am-form-group">
						<label for="user-phone" class="am-form-label">发票金额</label>
						<div class="am-form-content">
							<span>¥</span> <em class="style-large-bold-red  payNum" id="" >244.00</em>
						</div>
					</div>
					<div class="am-form-group">
						<label  class="am-form-label">发票类别</label>
						<div class="am-form-content">
							<select name="ctrlRate" >
								<option value="" selected>请选择发票类别</option>
								<option value="a">增值税专用发票</option>
								<option value="b">增值税普通发票</option>
							</select>
						</div>
					</div>
					<div class="am-form-group theme-poptit">
						<input type="button" class="am-btn am-btn-danger close" style="margin-left: 250px;margin-top: 88px;" value="提交"/>
						<input id="cancleBtn" type="button" class="am-btn am-btn-danger close" style="margin-left: 10px;margin-top: 88px;"  value="取消">
					</div>
				</div>
			</div>

		</div>




		<div class="clear"></div>
	</form>
	</body>
</html>