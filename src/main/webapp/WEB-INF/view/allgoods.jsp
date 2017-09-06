<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="/resources/js/jquery-3.2.1.js"></script>
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
				<li><a href="/message/findMessage.do?id=${vipInfo.vipId}"><font style="color: red">我的惠买</font></a></li>
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
				<div class="car" name="car">
					 <a href="/shopcar.do?vipAccount=${vipInfo.vipAccount}&&vipNo=${vipInfo.vipNo}">我的购物车</a>
				</div>
			</div>
		</div>
	</div>
	<hr/>
	<div class="type">
		<div class="w">
		<form id="pageSubmit" method="post">
				<input type="hidden" id="currentPage" name="currentPage" >
			<div class="header">
				<span class="one">平板的</span><span class="two">商品筛选</span><span class="three">共n个商品</span>
			</div>

			<div class="size">
				<div class="wi">
					类别：
				</div>
				<div class="more">
					<c:forEach var="tp" items="${page.tp}">
						<%--<a href="/search.do?prdType=${tp.tpNm}">${tp.tpNm}</a>&nbsp;&nbsp;&nbsp;&nbsp;--%>
						<%--<span class="class">${tp.tpNm}</span>&nbsp;&nbsp;&nbsp;&nbsp;--%>
						<button class="layui-btn layui-btn-primary layui-btn-mini class" name="tpCd" value="${tp.tpCd}">${tp.tpNm}</button>
					</c:forEach>
				</div>
			</div>
			<div class="size"></div>
			<div class="ph">
				<div class="wi">
					按价格：
				</div>
				<div class="more">
					<form action="/search.do" method="post">
						<input type="text" id="salePriceBegin" name="salePriceBegin" value="${params.salePriceBegin}">
						-
						<input type="text" id="salePriceEnd" name="salePriceEnd" value="${params.salePriceEnd}">
						<input type="hidden" name="tpCd" value="${params.tpCd}">
						<input type="submit" value="查询">
					</form>
					<%--<span>看不见的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>能看见的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>能看清的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>高清的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>毛孔都能看清的</span>--%>
				</div>

			</div>
			</form>
			<%--<div class="brand">--%>
				<%--<div class="wi">--%>
					<%--品牌类型：--%>
				<%--</div>--%>
				<%--<div class="more">--%>
					<%--<span>从来没见过的的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>听都没听过的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>反正你不知道的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>你应该知道的</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>特别著名的</span>--%>
				<%--</div>--%>
			<%--</div>--%>
		</div>
	</div>
	<div class="allgoods">
		<div class="w">
			<div class="header">
				<span>所有商品</span>
			</div>
		</div>
	</div>
	<div class="pho">
		<div class="w">
			<c:forEach var="list" items="${page.list }" >
				<div class="ever" onclick="detailed(${list.id})">
					<img src="${list.imgUrl}" width="227" height="243">
					<div class="text">
						￥${list.minPrice } ~ ￥${list.maxPrice}
					</div>
					<%--<div class="desc">--%>
						<%--${list.goods_desc }--%>
					<%--</div>--%>
					<div class="desc">
						<span>${list.prdName}</span></span>
						<span style="float:right;">
							<c:if test="${list.wCount>0}">有货</c:if>
							<c:if test="${list.wCount==0}">无货</c:if>
						</span>
					</div>
					<%--<div class="operation" >--%>
						<%--<input type="hidden" name="goods_id" value="${list.prdNo }">--%>
						<%--<input type="button" onclick="tocar(${list.prdNo })" value="加入购物车">--%>
					<%--</div>--%>
				</div>
			</c:forEach>
		</div>
	</div>
	<%--<div class="pagenum">--%>
		<%--<div class="w">--%>
			<%--&lt;%&ndash;有问题待解决处&ndash;%&gt;--%>
			<%--<div class="choose">--%>
				<%--<input type="hidden" value="${page.pageNum}"/>--%>
				<%--<a class="pop" href="search.do?nownum=1">首页</a>--%>
				<%--<span></span>--%>
				<%--<a class="pop" href="search.do?nownum=${page.pages }">末页</a>--%>
				<%--<!-- <span>首页</span>1  2  3<span>末页</span> -->--%>
			<%--</div>--%>
		<%--</div>--%>
	<%--</div>--%>
	<div class="w">
		<div class="layui-form">
			<span id="form_page"></span>&nbsp;
			共${page.total}条数据
		</div>


	</div>
	<%--<div id="demo2"></div>--%>
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
</body>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script type="text/javascript" src="/resources/js/allgoods.js"></script>

<script type="text/javascript">
    layui.use(['laypage','element','layer','jquery'],function (exports) {
        var laypage = layui.laypage;
        var $ = layui.jquery;

        var pindex = "${page.pageNum}";// 当前页
        var ptotalpages = "${page.pages}";// 总页数
        var pcount = "${page.total}";// 数据总数
        // 分页
        laypage({
            cont : 'form_page', // 页面上的id
            pages : ptotalpages,//总页数
            curr : pindex,//当前页。
            skip : true,
            skin: '#EE0000',
            jump : function(obj, first) {
                $("#currentPage").val(obj.curr);//设置当前页
                //$("#size").val(psize);
                //防止无限刷新,
                //只有监听到的页面index 和当前页不一样是才出发分页查询
                if (obj.curr != pindex ) {
                    $("#pageSubmit").submit();
                }
            }
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


    $(".register").on("click", function () {
        var id="";
        layer.open({
            title: '注册 - '
            , area: ['800px', '600px']
            , type: 2 //content内容为一个连接
            , content: '/vip/startregister.do?id='+id
        });

    })

	var tpCd = "${params.tpCd}";
	if(tpCd!=''){
        $('.type .size .more button[value='+tpCd+']').css('color','red').css('border-color','red');
	}


    function detailed(data){
        window.location.href="/goDetailed.do?id="+data;
    }
</script>
</html>