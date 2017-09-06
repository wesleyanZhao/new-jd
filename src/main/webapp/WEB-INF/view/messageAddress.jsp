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

        <form class="layui-form" >
            <!-- <input type="hidden" id="flage" name="flage" value="true">
             -->
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" id="vipAccount" value="${result.vipAccount}" disabled name="vipAccount" lay-verify="title" autocomplete="off" placeholder="请输入用户名" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">收货地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="idCard" value="${result.addrInfo}" disabled name="idCard"  placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">电子邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" name="email" value="${result.email}" disabled  autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">电话1</label>
                <div class="layui-input-inline">
                    <input type="tel" name="phoneOne" value="${result.phoneNo1}" disabled  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">电话2</label>
                <div class="layui-input-inline">
                    <input type="tel" name="phoneTwo" value="${result.phoneNo2}" disabled  autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">新增收货地址</label>
                <div class="layui-input-inline">
                    <select id="provinceId" name="provinceId" lay-filter="findCity">
                        <option value="">请选择省</option>
                            <c:forEach items="${list}" var="item">
                                <option value="${item.provinceId}">${item.province}</option>
                            </c:forEach>

                    </select>
                </div>
                <div class="layui-input-inline">
                    <select id="cityId" name="cityId">
                        <option value="">请选择市</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
            <label class="layui-form-label">详细地址</label>
            <div class="layui-input-inline">
                <input type="text" id="addrInfo" name="addrInfo" lay-verify="title" autocomplete="off" placeholder="请输入地址" class="layui-input">
            </div>
            </div>



            <input name="isUsed" value="y" type="hidden">
            <input type="hidden" value="${result.vipNo}" name="vipNo">
            <input type="hidden" value="${result.id}" name="instId">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal"  lay-submit lay-filter="messageAddress">立即提交</button>
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

        form.on('select(findCity)',function () {
            var provinceId=$("#provinceId").val();
            $.ajax({
                type: "POST",
                url: "/vip/findCity.do?provinceId="+provinceId,  //后台程序地址
                success:function (data) {
                    // alert(data);
                    $("#cityId").text("");
                    for(var i=0;i<data.length;i++){
                        var ka=" <option  value='"+data[i].cityId+"' >"+data[i].city+"</option>";
                        $("#cityId").append(ka);
                        form.render();
                    }
                }
            })
            form.render();

        });
       /* $("#addrInfo").on("blur",function () {
            var name=/^[\u4e00-\u9fa5]*$/;
            var addrInfo=$("#addrInfo").val();
            if(!addrInfo.match(name)){
                layer.msg("请输入中文")
                $("#addrInfo").val("");
            }

        })*/

        //监听提交
        form.on('submit(messageAddress)', function(params){
            //表单数据
            /* var username = $("#username").val();
             var password = $("#password").val();
             var gender = $("input[name='gender']:checked").val();
             var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();

            $.ajax({
                type: "POST",
                url: "/message/messageAddress.do",  //后台程序地址
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
