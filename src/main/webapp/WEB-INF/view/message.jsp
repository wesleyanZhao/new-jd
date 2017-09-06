<%--
  Created by IntelliJ IDEA.
  User: Lanou3G
  Date: 2017/7/26
  Time: 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>个人信息</title>
    <link rel="stylesheet" href="/resources/css/message.css">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body style="height: 100%">
<div id="body" style="height: 1100px">

    <div class="nav" >
        <div class="body" >
            <a href="/start.do"><span class="location">北京</span></a>

            <ul >
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


<%-- <div id="top">
       <div class="navigation">
            <a href="/start.do"><p class="navName">我的惠买</p></a>
            <ul class="options">
                <li><a href="###">首页</a></li>
                <li><a href="###">账户设置</a></li>
                <li><a href="###">社区</a></li>
                <li><a href="###">消息</a></li>
            </ul>
           <div class="seek">
               <input class="seekBorder" placeholder="电饭煲">
               <input class="seekButton" type="button" value="搜索">
           </div>
           <a id="shoppingCar"><input class="myCar" type="button" value="我的购物车"></a>

       </div>
   </div>--%>
    <div id="bigCentre" style="height: 800px">
        <div id="left">
           <ul class="messageOptions">
               <li><a href="###" style="color: red">个人信息</a></li>
               <li><a href="###">账户安全</a></li>
               <li><a href="###">账号绑定</a></li>
               <li><a href="###">我的级别</a></li>
               <li><a id="messageAddress" href="###">收货地址</a></li>
               <li><a id="messageBank" href="###">银行卡</a></li>
               <li><a href="/order/orderFrom.do?vipNo=${vipInfo.vipNo}">订单查询</a></li>
               <li><a href="###">邮件订阅</a></li>
               <li><a href="###">消费记录</a></li>
               <li><a href="###">应用授权</a></li>
               <li><a href="###">快捷支付</a></li>
               <li><a href="###">用药人信息</a></li>
               <li><a href="###">企业发票</a></li>
               <li><a href="###">采购需求单</a></li>
               <li><a href="###">浏览历史</a></li>
               <li><a href="###">关注的商品</a></li>
               <li><a href="###">关注的店铺</a></li>
               <li><a href="###">关注的专辑</a></li>
               <li><a href="###">关注的内容</a></li>
               <li><a href="###">小金库</a></li>
               <li><a href="###">惠买白条</a></li>
               <li><a href="###">小白理财</a></li>

           </ul>
        </div>

   <div id="centre">
       <p class="baseMessage">基本信息</p>
       <div>
           <form class="layui-form" >
               <div class="layui-form-item">
                   <label class="layui-form-label">电话1</label>
                   <div class="layui-input-inline">
                       <input type="text"     name="firstPhoneNo" value="${result.firstPhoneNo}" lay-verify="title" autocomplete="off" placeholder="请输入电话" class="layui-input">
                   </div>
               </div>
               <div class="layui-form-item">
                   <label class="layui-form-label">电话2</label>
                   <div class="layui-input-inline">
                       <input type="text"     name="secondPhoneNo" value="${result.secondPhoneNo}" lay-verify="title" autocomplete="off" placeholder="请输入电话" class="layui-input">
                   </div>
               </div>
               <div class="layui-form-item">
                   <label class="layui-form-label">邮箱</label>
                   <div class="layui-input-inline">
                       <input type="text"   lay-verify="email" value="${result.email}"   name="email" lay-verify="title" autocomplete="off" placeholder="请输入邮箱" class="layui-input">
                   </div>
               </div>
               <div class="layui-form-item">
                   <label class="layui-form-label">验证身份证</label>
                   <div class="layui-input-inline">
                       <input type="text" id="idCard" value="${result.idCard}" name="idCard" lay-verify="identity" placeholder="" autocomplete="off" class="layui-input">
                   </div>
               </div>
               <div class="layui-form-item">
                   <label class="layui-form-label">生日</label>
                   <div class="layui-input-inline">
                       <input type="text" name="vipBirthday" value="${result.vipBirthday}" id="date" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
                   </div>
               </div>
               <div class="layui-form-item">
                   <label class="layui-form-label">真实姓名</label>
                   <div class="layui-input-inline">
                       <input type="text" name="realName" value="${result.realName}" lay-verify="title" autocomplete="off" placeholder="请输入姓名" class="layui-input">
                   </div>
               </div>
               <input type="hidden" name="id" value="${id}">
               <div class="layui-form-item">
                   <div class="layui-input-block">
                       <button class="layui-btn layui-btn-normal"  lay-submit lay-filter="updateVipInfo">立即提交</button>
                       <button type="reset" class="layui-btn layui-btn-primary" lay-filter="emptyMenu">重置</button>
                   </div>
               </div>
           </form>
       </div>
       <div class="rightBorder">
           <img class="useImg" alt="用户头像" src="//i.jd.com/commons/img/no-img_mid_.jpg">
           <div class="users">
           用户名：<span>${result.vipAccount}</span><br/>
           会员类型: <c:if test="${result.vipType=='100'}">
                       <span>手机</span>
                   </c:if>
                   <c:if test="${result.vipType=='200'}">
                       <span>网站</span>
                   </c:if>
                   <c:if test="${result.vipType=='300'}">
                       <span>线下</span>
                   </c:if>
           </div>
       </div>
   </div>
    </div>


    <div class="lianjie">
        <a href="###">购物流程</a><span>|</span> <a href="###">会员介绍</a><span>|</span>
        <a href="###">上门自提</a><span>|</span> <a href="###">全球速卖通</a><span>|</span>
        <a href="###">货到付款</a><span>|</span> <a href="###">天猫</a><span>|</span>
        <a href="###">聚划算</a><span>|</span> <a href="###">公司转账</a><span>|</span>
        <a href="###">分期付款</a><span>|</span> <a href="###">在线支付</a><span>|</span>
        <a href="###">虾米</a><span>|</span> <a href="###">邮局汇款</a><span>|</span>
        <a href="###">云OS</a><span>|</span> <a href="###">万网</a><span>|</span>
        <a href="###">海外配送</a><span>|</span> <a href="###">来往</a>
    </div>
    <div class="falv">
        <a href="###">关于惠买</a> <a href="###">合作伙伴</a> <a href="###">营销中心</a>
        <a href="###">廉政举报</a> <a href="###">联系客服</a> <a href="###">开放平台</a>
        <a href="###">诚征英才</a> <a href="###">联系我们</a> <a href="###">网站地图</a>
        <a href="###">法律声明</a>
    </div>
    <div class="yingxiao">
        <span>© 2017 Taobao.com 版本所有</span> <span>网络文化经营许可证：</span> <a
            href="###">文网文[2010]040号</a> <span>|</span> <span>增值电信业务经营许可证：浙B2-20080224-1</span>
        <span>|</span> <span>信息网络传播视听节目许可证：11009364号</span>
    </div>
</div>

</body>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script>
    layui.use(['form','jquery','layer','laydate'], function() {
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;


        $("#messageAddress").on("click", function () {
            var id="${vipInfo.vipId}"
            layer.open({
                title: '添加地址'
                , area: ['600px', '600px']
                , offset: '100px'
                , type: 2 //content内容为一个连接
                , content: '/vip/startregister.do?id='+id
            });
        })
        $("#messageBank").on("click", function () {
            var id="${vipInfo.vipId}"
            layer.open({
                title: '添加银行卡'
                , area: ['600px', '600px']
                , offset: '100px'
                , type: 2 //content内容为一个连接
                , content: '/message/messageBank.do?id='+id
            });
        })

        $(".register").on("click", function () {
            var id="";
            layer.open({
                title: '注册 - '
                , offset: '100px'
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


        //监听提交
        form.on('submit(updateVipInfo)', function(params){
            //表单数据
            /* var username = $("#username").val();
             var password = $("#password").val();
             var gender = $("input[name='gender']:checked").val();
             var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();

            $.ajax({
                type: "POST",
                url: "/message/updateVipInfo.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){           //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    if (data.result == 'success'){   //如果成功了, 则关闭当前layer
                        layer.msg('修改成功',{
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        },function(){//
                            //do something
                            //注册成功后，自动关闭当前注册页面
                            //先得到当前iframe层的索引
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            //parent.layer.closeAll("iframe");
                        });
                    }else{
                        layer.msg('修改失败')

                    }
                }
            });
            return false;//return false 表示不通过页面刷新方式提交表单
        });

    })


</script>
</html>
