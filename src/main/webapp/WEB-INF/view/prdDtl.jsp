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
                <th>收货人</th>
                <th>金额</th>
                <th>商品数量</th>
                <th>退货</th>
                <th>同品换货</th>
                <th>异品换货</th>
                <th>商品评论</th>

            </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="item">




                <tr>
                    <td>${item.prdName}/${item.tpName}/${item.prdDtlName}</td>
                    <td>${item.delName}</td>
                    <td>${item.realPrice}</td>
                    <td>${item.prdCount}</td>
                    <input type="hidden" id="ordStsCd" value="${item.ordStsCd}">
                    <input type="hidden" id="ordTpCd" value="${item.ordTpCd}">
                    <c:if test="${item.ordStsCd!='100'&&item.ordTpCd!='200'&&item.ordStsCd!='600'}">
                        <c:if test="${item.opeType=='10'}">
                            <input type="hidden" class="opeType" value="${item.opeType}">
                            <td><a class="sales" disabled="disabled" style="color: red;cursor:default"  onclick="return false" >退货</a></td>
                            <td><a class="barter" disabled="disabled" style="cursor:default" onclick="return false" >同品换货</a></td>
                            <td><a class="otherBarter" disabled="disabled" style="cursor:default" onclick="return false"  >异品换货</a></td>
                        </c:if>
                        <c:if test="${item.opeType=='20'}">
                            <td><a class="sales" disabled="disabled"  onclick="return false" >退货</a></td>
                            <td><a class="barter" disabled="disabled" style="color: red"  onclick="return false">同品换货</a></td>
                            <td><a class="otherBarter" disabled="disabled"  onclick="return false">异品换货</a></td>
                        </c:if>
                        <c:if test="${item.opeType=='30'}">
                            <td><a class="sales" disabled="disabled"  onclick="return false" >退货</a></td>
                            <td><a class="barter" disabled="disabled"  onclick="return false">同品换货</a></td>
                            <td><a class="otherBarter" disabled="disabled" style="color: red"  onclick="return false">异品换货</a></td>
                        </c:if>
                        <c:if test="${item.opeType==null}">
                            <c:if test="${result.result=='part'}">
                                <td><a class="sales" href="###" result="${result.result}" ordNo="${item.ordNo}" ordDtlNo="${item.ordDtlNo}">退货</a></td>
                            </c:if>
                            <c:if test="${result.result=='fail'}">
                                <td><a>禁止退货</a></td>
                            </c:if>
                            <c:if test="${result.result=='all'}">
                                <td><a class="sales" href="###" result="part" ordNo="${item.ordNo}" ordDtlNo="${item.ordDtlNo}">退货</a></td>
                            </c:if>

                            <td><a class="barter" href="###" ordNo="${item.ordNo}" ordDtlNo="${item.ordDtlNo}" prdDtlNo="${item.prdDtlNo}">同品换货</a></td>
                            <td><a class="otherBarter" href="###" ordNo="${item.ordNo}" tpCd="${item.tpCd}" ordDtlNo="${item.ordDtlNo}" prdDtlNo="${item.prdDtlNo}">异品换货</a></td>
                        </c:if>
                    </c:if>
                    <c:if test="${item.ordStsCd=='100'}">
                        <td></td>
                        <td></td>
                        <td></td>
                    </c:if>
                    <c:if test="${item.ordTpCd=='200'}">
                        <td></td>
                        <td></td>
                        <td></td>
                    </c:if>
                    <c:if test="${item.ordStsCd=='600'}">
                        <td></td>
                        <td></td>
                        <td></td>
                    </c:if>


                    <td>
                        <c:if test="${item.ordStsCd=='500'}">
                            <a class="addEvaluate"  ordNo="${item.ordNo}" prdNo="${item.prdNo}" prdDtlNo="${item.prdDtlNo}" href="###">追加评论</a>
                        </c:if>
                    </td>


                </tr>


                </c:forEach>
            </tbody>
        </table>

        <div class="w">
            <div class="layui-form">
                <span id="form_page"></span>&nbsp;
                共${page.total}条数据
            <c:forEach items="${list}" var="item">
                <c:if test="${result.result=='all'&&item.opeType!='10'}">
                   <%-- <a style="float: right" id="reAllSale" href="###" ordNo="${ordNo}">全部退货</a>--%>
                    <input type="hidden" class="opeType" value="success">
                </c:if>
            </c:forEach>

            </div>
            <form id="pageSubmit">
                <input type="hidden" id="currentPage" name="currentPage" >
                <input name="vipNo" type="hidden" value="${vipInfo.vipNo}">
                <input name="ordNo" type="hidden" value="${ordNo}">
            </form>
        </div>
    </div>
</fieldset>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<%--<script type="text/javascript" src="/resources/js/register.js"></script>--%>
<script>
    //    //Demo
    //    // 待学生自主完成
    layui.use(['form','jquery','layer','laydate','laypage'], function(){
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;
        var laypage = layui.laypage;

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
                //$("#size").val(psize);
                //防止无限刷新,
                //只有监听到的页面index 和当前页不一样是才出发分页查询
                if (obj.curr != pindex ) {
                    $("#pageSubmit").submit();
                }
            }
        });
        var opeType=$(".opeType").val();
        var ordStsCd=$("#ordStsCd").val();
        var ordTpCd=$("#ordTpCd").val();
        if(opeType == 'success'&&ordStsCd!='100'&&ordStsCd!='600'&&ordTpCd!='200') {
            $("#form_page").append('<a style="float: right" id="reAllSale" href="###" ordNo="${ordNo}">全部退货</a>');
        }


        $(".sales").on('click',function () {
            var ordNo=$(this).attr("ordNo");
            var ordDtlNo=$(this).attr("ordDtlNo");
            var vipId="${vipInfo.vipId}";
            var vipNo="${vipInfo.vipNo}";
            var result=$(this).attr("result");
            $.ajax({
                type: "POST",
                url: "/order/sales.do?ordNo="+ordNo+"&&ordDtlNo="+ordDtlNo+"&&vipId="+vipId+"&&vipNo="+vipNo+"&&result="+result,  //后台程序地址
                success:function (data) {
                    if(data.result =='success'){
                        layer.msg('退货成功',{
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


                    }else{
                        alert("退货失败")
                        $(".sales").removeAttribute("href");
                    }
                }
            })

        });

        $("#reAllSale").on('click',function () {
            var ordNo=$(this).attr("ordNo");
            var vipId="${vipInfo.vipId}";
            var vipNo="${vipInfo.vipNo}";
            var result="${result.result}";
            $.ajax({
                type: "POST",
                url: "/order/sales.do?ordNo="+ordNo+"&&vipId="+vipId+"&&vipNo="+vipNo+"&&result="+result,  //后台程序地址
                success:function (data) {
                    if(data.result =='success'){
                        layer.msg('全部退货成功',{
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
                    }else{
                        alert("全部退货失败")
                        $(".sales").removeAttribute("href");
                    }
                }
            })

        });




        $(".barter").on('click',function () {
            var ordNo=$(this).attr("ordNo");
            var ordDtlNo=$(this).attr("ordDtlNo");
            var prdDtlNo=$(this).attr("prdDtlNo");
            $.ajax({
                type: "POST",
                url: "/order/barter.do?ordNo="+ordNo+"&&ordDtlNo="+ordDtlNo+"&&prdDtlNo="+prdDtlNo,  //后台程序地址
                success:function (data) {
                    if(data.result =='004'){
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

                    }else if(data.result =='001'){
                        alert("商品不支持退货")

                    }else if(data.result =='002'){
                        alert("时间过长")

                    }else if(data.result =='003'){
                        alert("仓库数量不够")
                    }
                }
            })

        });
        $(".otherBarter").on("click",function () {
           /* var tpCd=$(".addEvaluate").attr("tpCd");
            var prdNo=$(".addEvaluate").attr("prdNo");*/
            var prdDtlNo=$(this).attr("prdDtlNo");
            var ordNo=$(this).attr("ordNo");
            layer.open({
                title: '异品换货 - '
                , area: ['500px', '400px']
                , offset: '150px'
                , type: 2 //content内容为一个连接
                , content: '/order/otherBarter.do?prdDtlNo='+prdDtlNo+"&&ordNo="+ordNo
            });
        })
        $(".addEvaluate").on("click",function () {
            var ordNo=$(this).attr("ordNo");
            var prdNo=$(this).attr("prdNo");
            var prdDtlNo=$(this).attr("prdDtlNo");
            layer.open({
                title: '评价 - '
                , area: ['400px', '260px']
                , offset: '150px'
                , type: 2 //content内容为一个连接
                , content: '/order/addEvaluate.do?prdNo='+prdNo+"&&ordNo="+ordNo+"&&prdDtlNo="+prdDtlNo
            });
        })




    });
</script>
</body>

</html>
