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
    <title>积分记录查询</title>
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
    <link rel="stylesheet" href="/resources/css/register.css">
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>积分记录查询</legend>
</fieldset>

<div class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="50">
            <col width="200">
            <col width="100">
            <col width="100">
            <col width="100">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>ID</th>
            <th>会员编号</th>
            <th>更变量</th>
            <th>记录日期</th>
            <th>订单号</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="i" begin="0" end="${list.size()-1}">
            <tr>
                <td>${list[i].id}</td>
                <td>${list[i].vipNo}</td>
                <td>
                    <c:choose>
                        <c:when test="${list[i].pointState}=='u'}">
                            -${list[i].pointNum}
                        </c:when>
                        <c:otherwise>
                            +${list[i].pointNum}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${list[i].rcdDate}</td>
                <td>${list[i].orderNo}</td>
            </tr>
         </c:forEach>>
        </tbody>
    </table>
</div>
<div class="layui-form">
    <span id="form_page"></span>&nbsp;共${total}条数据
</div>
<form id="pageSubmit">
    <input type="hidden" id="currentPage" name="currentPage" >
</form>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script type="text/javascript">

    layui.define([ 'element', 'form', 'layer', 'laypage'], function(exports) {
        var element = layui.element();
        var form = layui.form();
        var layer = layui.layer;
        var laypage = layui.laypage;
        var $ = layui.jquery;

        var pindex = "${pageNum}";// 当前页
        var ptotalpages = "${pages}";// 总页数
        var pcount = "${total}";// 数据总数

        // 分页
        laypage({
            cont : 'form_page', // 页面上的id
            pages : ptotalpages,//总页数
            curr : pindex,//当前页。
            skip : true,
            jump : function(obj, first) {
                $("#currentPage").val(obj.curr);//设置当前页
//                $("#size").val(psize);
                //防止无限刷新,
                //只有监听到的页面index 和当前页不一样是才出发分页查询
                if (obj.curr != pindex ) {
                    $("#pageSubmit").submit();
                }
            }
        });
    });

</script>
</body>

</html>
