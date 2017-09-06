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
    <title>账户信息</title>
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
    <link rel="stylesheet" href="/resources/css/register.css">
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>账户信息</legend>
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
            <th>账户积分</th>
            <th>账户积分</th>
            <th>代金券金额</th>
            <th>代金券内容</th>
            <th>银行名称</th>
            <th>银行卡类型</th>
            <th>银行卡号</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach var="i" begin="0" end="${list.size()-1}">
            <tr>
                <td>${list[i].id}</td>
                <td>${list[i].vipNo}</td>
                <td>${list[i].accPoint}</td>
                <td>${list[i].accSum}</td>
                <td>${list[i].cpnSum}</td>
                <td>${list[i].cpnContent}</td>
                <td>${list[i].bankName}</td>
                <td>
                <c:choose>
                    <c:when test="${list[i].bankCardType == '100'}">
                    借记卡
                    </c:when>
                    <c:when test="${list[i].bankCardType == '200'}">
                        信用卡
                    </c:when>
                    <c:when test="${list[i].bankCardType == '300'}">
                        储蓄卡
                    </c:when>
                </c:choose>
                </td>
                <td>${list[i].bankCardNo}</td>

            </tr>
         </c:forEach>
        </tbody>
    </table>
</div>
<div class="layui-form">
    <span id="form_page"></span>&nbsp;共${page.total}条数据
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

        var pindex = "${page.pageNum}";// 当前页
        var ptotalpages = "${page.pages}";// 总页数
        var pcount = "${page.total}";// 数据总数

        // 分页
        laypage({
            cont : 'form_page', // 页面上的id
            pages : ptotalpages,//总页数
            curr : pindex,//当前页。
            skip : true,
            jump : function(obj, first) {
                $("#currentPage").val(obj.curr);//设置当前页
                $("#size").val(psize);
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
