<%--
  Created by IntelliJ IDEA.
  User: landfash
  Date: 2017/7/8
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link rel="stylesheet" type="text/css" href="/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
<script type="text/javascript" src="/resources/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.2.1.min.js"></script>
<body>
<div class="top">
    <div class="width">
        <div class="logo"><a href="/start.do"><img class="one" src="/resources/img/logoself.jpg" width=170 height=60></a> <img class="two" src="/resources/img/welcome.png"></div>
        <a class="research" href="###">
            <b></b>登录页面，调查问卷</a>
    </div>
</div>

<div class="content">
    <div class="width">
        <div class="background">
            <div class="box">
                <div class="choose">
                    <a href="###"><div class="text1">扫码登录</div></a>
                    <a href="###"><div class="text2">账户登录</div></a>
                </div>
                <div class="user">
                    <div class="w">
                        <form action="/login/loginFrom.do" method="post">
                            <!-- <input type="hidden" name="flage" value="login"> -->
                            <div class="account">
                                <div class="account_pho"></div>
                                <input type="text" name="vipAccount" placeholder="邮箱/用户名/已验证手机">
                            </div>
                            <div class="pwd">
                                <div class="pwd_pho"></div>
                                <input type="password" name="vipPassword" placeholder="密码">
                            </div>
                            <div>
                                <a href="###"><span class="f">忘记密码</span></a>
                            </div>
                            <div class="btn">
                                <input type="submit" class="input" value="登录">
                            </div>
                        </form>
                    </div>
                </div>
                <div class="other_way">
                    <div class="w">
                        <div class="qq"><a href="###"><div class="qq_pho"></div><span>QQ</span></a></div>
                        <div class="chat"><a href="###"><div class="chat_pho"></div><span>微信</span></a></div>
                        <div class="now"><div class="now_pho"></div><a href="javascript:;" class="register"><span class="n">立即注册</span></a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="foot">
    <div class="width">
        <ul>
            <li><a href="###">关于我们</a></li>
            <li><a href="###">联系我们</a></li>
            <li><a href="###">人才招聘</a></li>
            <li><a href="###">商家入驻</a></li>
            <li><a href="###">广告服务</a></li>
            <li><a href="###">手机惠买</a></li>
            <li><a href="###">友情链接</a></li>
            <li><a href="###">销售联盟</a></li>
            <li><a href="###">惠买社区</a></li>
            <li><a href="###">惠买公益</a></li>
            <li><a href="###">English Site</a></li>
        </ul>
    </div>
    <div class="width">
        <p>Copyright © 2004-2017  惠买JD.com 版权所有 </p>
    </div>
</div>
</body>
<script src="/resources/js/login.js"></script>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script>
    layui.use(['form','jquery','layer','laydate'], function() {
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;

        $(".register").on("click", function () {
            var id = "";
            layer.open({
                title: '注册 - '
                , area: ['800px', '600px']
                , type: 2 //content内容为一个连接
                , content: '/vip/startregister.do?id=' + id
            });

        })
    })
</script>
</html>
