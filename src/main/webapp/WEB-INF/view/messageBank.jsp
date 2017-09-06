<%--
  Created by IntelliJ IDEA.
  User: Lanou3G
  Date: 2017/7/24
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
    <link rel="stylesheet" href="/resources/css/register.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend></legend>
    <div class="layui-field-box" >

        <table class="layui-table">
            <colgroup>
                <col width="50">
                <col width="100">
                <col width="100">
                <col width="100">
                <col width="100">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>用户名</th>
                <th>银行卡类型</th>
                <th>银行卡卡号</th>
                <th>银行名称</th>

            </tr>
            </thead>
            <tbody>
                <c:forEach items="${result}" var="res">
                <tr>
                    <td>${res.vipAccount}</td>
                    <td>
                        <c:if test="${res.bankCardType=='100'}">
                            借记卡
                        </c:if>
                        <c:if test="${res.bankCardType=='200'}">
                            信用卡
                        </c:if>
                        <c:if test="${res.bankCardType=='300'}">
                            储蓄卡
                        </c:if>
                    </td>
                    <td>${res.bankCardNo}</td>
                    <td>${res.bankName}</td>

                </tr>

                </c:forEach>
            </tbody>
        </table>
        <form class="layui-form" >
            <div class="layui-form-item">
            <label class="layui-form-label">新加银行卡类型</label>
            <div class="layui-input-inline">
                <select name="bankCardType">
                    <option value="100" select>借记卡</option>
                    <option value="200">信用卡</option>
                    <option value="300">储蓄卡</option>
                </select>
            </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">银行卡卡号</label>
                <div class="layui-input-inline">
                    <input type="text" name="bankCardNo" lay-verify="title" autocomplete="off" placeholder="请输入银行卡卡号" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">银行名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="bankName" name="bankName" lay-verify="title" autocomplete="off" placeholder="请输入银行卡名称" class="layui-input">
                </div>
            </div>
            <input type="hidden" value="${vipInfo.vipNo}" name="vipNo">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal"  lay-submit lay-filter="addBank">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary" lay-filter="emptyMenu">重置</button>
                </div>
            </div>
        </form>
    </div>
</fieldset>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<%--<script type="text/javascript" src="/resources/js/register.js"></script>--%>
<script>
    //    //Demo
    //    // 待学生自主完成
    layui.use(['form','jquery','layer','laydate'], function(){
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;


      /*  $("#bankName").on("blur",function () {
            var name=/^[\u4e00-\u9fa5]*$/;
            var bankName=$("#bankName").val();
            if(!bankName.match(name)){
                layer.msg("请输入中文")
                $("#bankName").val("");
            }

        })*/

        //监听提交
        form.on('submit(addBank)', function(params){
            //表单数据
            /* var username = $("#username").val();
             var password = $("#password").val();
             var gender = $("input[name='gender']:checked").val();
             var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();

            $.ajax({
                type: "POST",
                url: "/message/addBank.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){           //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    if (data.result == 'success'){   //如果成功了, 则关闭当前layer
                        layer.msg('添加成功',{
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
                        layer.msg('添加失败')

                    }
                }
            });
            return false;//return false 表示不通过页面刷新方式提交表单
        });


    });
</script>
</body>

</html>
