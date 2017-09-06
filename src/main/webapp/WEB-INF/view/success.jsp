<%--
  Created by IntelliJ IDEA.
  User: Lanou3G
  Date: 2017/8/10
  Time: 21:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Title</title>
    <link href="/resources/css/admin.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/demo.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sustyle.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/amazeui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/resources/js/jquery-3.2.1.js"></script>
</head>
<body>


<!--顶部导航条 -->
<div class="am-container header">
    <ul class="message-l">
        <div class="topMessage">
            <div class="menu-hd">
                <a href="#" target="_top" class="h">${userName}</a>
                <a href="#" target="_top">免费注册</a>
            </div>
        </div>
    </ul>
    <ul class="message-r">
        <div class="topMessage home"><div class="menu-hd"><a href="/start.do" target="_top" class="h">商城首页</a></div></div>
        <div class="topMessage my-shangcheng"><div class="menu-hd MyShangcheng"><a href="/message/findMessage.do?id=${vipInfo.vipId}" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a></div></div>
        <div class="topMessage mini-cart"><div class="menu-hd"><a id="mc-menu-hd" href="#" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div></div>
        <div class="topMessage favorite"><div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a></div></div>
    </ul>
</div>



<div class="take-delivery">
    <div class="status">
        <h2>您已成功付款</h2>
        <div class="successInfo">
            <ul>
                <li>付款金额￥：<em>${payNum}</em></li>
                <div class="user-info">
                    <p>收货人姓名：${delName}</p>
                    <p>手机号：${secondPhoneNo}</p>
                    <p>收货地址：${addrP} ${addrC} ${addrD}</p>
                </div>
                请认真核对您的收货信息，如有错误请联系客服

            </ul>
            <div class="option">
                <span class="info">您可以</span>
                <a href="../person/order.html" class="J_MakePoint">查看<span>已买到的宝贝</span></a>
                <a href="../person/orderinfo.html" class="J_MakePoint">查看<span>交易详情</span></a>
            </div>
        </div>
    </div>
</div>


<div class="footer" >
    <div class="footer-hd">
        <p>
            <a href="#">恒望科技</a>
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
            <a href="#">关于恒望</a>
            <a href="#">合作伙伴</a>
            <a href="#">联系我们</a>
            <a href="#">网站地图</a>
            <em>© 2015-2025 Hengwang.com 版权所有. 更多模板 <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></em>
        </p>
    </div>
</div>


</body>
</html>
