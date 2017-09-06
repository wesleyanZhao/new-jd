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
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend></legend>
    <div class="layui-field-box" >

        <table class="layui-table">
            <colgroup>
                <col width="200">
                <col width="100">
                <col width="100">
                <col width="100">
                <col width="100">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>商品名称</th>
                <th>换货</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="item">
                <tr>
                    <td>${item.prdDtlName}</td>
                    <td><a class="otherBarter"  href="###"  barterPrdNo="${item.prdDtlNo}">换货</a></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>


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


        $(".otherBarter").on("click",function () {
           /* var tpCd=$(".addEvaluate").attr("tpCd");*/
            var backPrdNo="${prdDtlNo}"
            var ordNo="${ordNo}";
            var barterPrdNo=$(this).attr("barterPrdNo");
            var vipId="${vipInfo.vipId}"
            var vipNo="${vipInfo.vipNo}"
            $.ajax({
                type: "POST",
                url: "/order/otherBarterFrom.do?backPrdNo="+backPrdNo+"&&barterPrdNo="+barterPrdNo+"&&ordNo="+ordNo+"&&vipId="+vipId+"&&vipNo="+vipNo,  //后台程序地址
                success:function (data) {
                    if(data.result =='success'){
                        layer.msg('换货成功',{
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        },function(){//
                            //do something
                            //注册成功后，自动关闭当前注册页面
                            //先得到当前iframe层的索引
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            //parent.layer.closeAll("iframe");
                        })
                    }else if(data.result =='overTime'){
                        alert("超过退货时间")
                        /*$(this).removeAttr("href");*/
                    }else{
                        alert("换货失败")
                       /* $(this).removeAttr("href");
                        $(this).attr("disabled","disabled")*/
                    }
                }
            })


        })












    });
</script>
</body>

</html>
