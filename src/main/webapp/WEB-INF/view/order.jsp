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
<div id="body" style="height: 1900px">
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

    <div id="bigCentre" style="height: 1600px">
        <div id="left">
           <ul class="messageOptions">
               <li><a href="/message/findMessage.do?id=${vipInfo.vipId}">个人信息</a></li>
               <li><a href="###">账户安全</a></li>
               <li><a href="###">账号绑定</a></li>
               <li><a href="###">我的级别</a></li>
               <li><a id="messageAddress" href="###">收货地址</a></li>
               <li><a id="messageBank" href="###">银行卡</a></li>
               <li><a href="###" style="color: red">订单查询</a></li>
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

   <div id="centre" style="width: 1000px;">
       <form id="orderFrom" class="layui-form">
           <div class="layui-form-item">
               <div class="layui-inline">
                   <label class="layui-form-label">订单编号</label>
                   <div class="layui-input-inline">
                       <input type="text" name="ordNo" value="${params.ordNo}"  placeholder="请输入订单编号" autocomplete="off" class="layui-input">
                   </div>
               </div>
           </div>
               <div class="layui-form-item">
               <label class="layui-form-label">订单状态</label>
               <div class="layui-input-inline">
                   <select id="ordStsCd" name="ordStsCd" >
                       <option value="0" selected>全部</option>
                       <option value="100">未支付</option>
                       <option value="200">已支付</option>
                       <option value="300">已发货</option>
                       <option value="400">已出库</option>
                       <option value="500">已签收</option>
                       <option value="600">取消</option>
                       <option value="700">退货</option>
                   </select>
               </div>
           </div>
           <div class="layui-form-item">
               <label class="layui-form-label">订单时间</label>
               <div class="layui-inline">
                   <input name="orderDateStart" value="${params.orderDateStart}"   class="layui-input" placeholder="订单开始时间" onclick="layui.laydate({elem: this})">
               </div>-
               <div class="layui-inline">
                   <input name="orderDateEnd" value="${params.orderDateEnd}"   class="layui-input" placeholder="订单结束时间" onclick="layui.laydate({elem: this})">
               </div>
           </div>
           <input type="hidden" name="vipNo" value="${vipInfo.vipNo}">
           <div class="layui-form-item">
               <div class="layui-input-block">
                   <button class="layui-btn layui-btn-normal"  lay-submit>立即提交</button>
                   <button type="reset" class="layui-btn layui-btn-primary" lay-filter="emptyMenu">重置</button>
               </div>
           </div>
       </form>
       <table class="layui-table">
           <colgroup>
               <col width="150">
               <col width="150">
               <col width="150">
               <col width="150">
               <col width="100">
               <col>
           </colgroup>
           <thead>
           <tr>
               <th>订单时间</th>
               <th>订单号</th>
               <th>订单类别</th>
               <th>收货人</th>
               <th>状态</th>
               <th>操作</th>
               <th>详情</th>
           </tr>

           </thead>
           <tbody>
           <c:forEach items="${list}" var="item">
                <tr>
                    <td>${item.ordCrtDate}</td>
                    <td>${item.ordNo}</td>
                    <td>
                        <c:if test="${item.ordTpCd=='100'}">
                            一般订单
                        </c:if>
                        <c:if test="${item.ordTpCd=='200'}">
                            退换货单
                        </c:if>

                    </td>
                    <td>${item.delName}</td>
                    <td>
                        <c:if test="${item.ordStsCd=='100'}">
                            未支付
                        </c:if>
                        <c:if test="${item.ordStsCd=='200'}">
                            已支付
                        </c:if>
                        <c:if test="${item.ordStsCd=='300'}">
                            已发货
                        </c:if>
                        <c:if test="${item.ordStsCd=='400'}">
                            已出库
                        </c:if>
                        <c:if test="${item.ordStsCd=='500'}">
                            已签收
                        </c:if>
                        <c:if test="${item.ordStsCd=='600'}">
                            取消
                        </c:if>
                        <c:if test="${item.ordStsCd=='700'}">
                            退货
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${item.ordTpCd=='100'}">
                            <c:if test="${item.ordStsCd=='100'}">
                                <a href="/order/vipPay.do?ordNo=${item.ordNo}&&ordId=${item.id}">支付-</a>
                            </c:if>
                            <c:if test="${item.ordStsCd=='100'||item.ordStsCd=='200'}">
                                <a class="updateOrder" href="###" ordStsCd="${item.ordStsCd}" ordNo="${item.ordNo}" realPrice="${item.realPrice}">取消</a>
                            </c:if>
                            <c:if test="${item.ordStsCd=='200'}">
                                <%--点击签收，更改状态为签收--%>
                                <a href="" class="addSignin" ordStsCd="${item.ordStsCd}" ordNo="${item.ordNo}" Id="${item.id}" vipNo="${vipInfo.vipNo}">签收</a>
                            </c:if>

                            <c:if test="${item.ordStsCd=='500'}">
                                <a href="">已签收</a>
                            </c:if>
                        </c:if>

                    </td>
                    <td>
                        <a class="prdDtl" ordNo="${item.ordNo}"  href="###">详情</a>
                    </td>
                </tr>


            </c:forEach>


           </tbody>
       </table>
       <div class="w">
           <div class="layui-form">
               <span id="form_page"></span>&nbsp;
               共${page.total}条数据
           </div>
           <form id="pageSubmit">
               <input type="hidden" id="currentPage" name="currentPage" >
               <input name="vipNo" type="hidden" value="${vipInfo.vipNo}">
               <input name="ordNo" value="${params.ordNo}" type="hidden">
               <input name="ordStsCd" value="${params.ordStsCd}" type="hidden">
               <input name="orderDateStart" value="${params.orderDateStart}" type="hidden">
               <input name="orderDateEnd" value="${params.orderDateEnd}" type="hidden">
           </form>
       </div>

   </div>
        <div class="like">
            <p class="likeP">猜你喜欢</p>
            <ul>
                <li>
                    <div class="likeImg">
                        <img src="/resources/img/img1.jpg">
                        <p>betu百图喇叭袖圆领雪纺连衣裙女中长款荷叶边裙2017新款1703T50 酒红H2 S</p>
                        <p class="lMoney">￥129.00</p>
                    </div>
                </li>
                <li>
                    <div class="likeImg">
                        <img src="/resources/img/img2.jpg">
                        <p>【惠买超市】自然共和国 Nature Republic 清新绿茶两件套（绿茶水180ml+绿茶乳液180ml）</p>
                        <p class="lMoney">￥34.00</p>
                    </div>
                </li>
                <li>
                    <div class="likeImg">
                        <img src="/resources/img/img3.jpg">
                        <p>【惠买超市】自然共和国 Nature Republic芦荟胶舒缓保湿凝胶300ml（约300g）进口补水保湿舒缓晒后修复面膜</p>
                        <p class="lMoney">￥30.00</p>
                    </div>
                </li>
                <li>
                    <div class="likeImg">
                        <img src="/resources/img/img4.jpg">
                        <p>【标配版】Meitu/美图 M6s（MP1512）4GB+64GB 樱花粉 自拍美颜 全网通 移动联通电信4G手机</p>
                        <p class="lMoney">￥3000.00</p>
                    </div>
                </li>
                <li>
                    <div class="likeImg">
                        <img src="/resources/img/img5.jpg">
                        <p>红胖胖 熟冻盱眙蒜香小龙虾 18-23只 6-8钱/只 1.5kg（净虾量 750g）盒装 海鲜水产</p>
                        <p class="lMoney">￥100.00</p>
                    </div>
                </li>
            </ul>
        </div>

        <div class="buy">
            <p class="likeP" style="margin-top: 30px;margin-left: 30px">买什么</p>
            <div class="buyDiv">
                <p>摄影心愿单</p>
                <p style="font-size: 10px">1000000k纯帅</p>
                <div class="buyBig"><img src="/resources/img/c1.jpg"></div>
                <div class="buySmall"><img src="/resources/img/c2.jpg"></div>
                <div class="buySmall" style="margin-top: 10px"><img src="/resources/img/c3.jpg"></div>
            </div>
            <div class="buyDiv">
                <p>清点我的前半生，罗子君同款的美衣</p>
                <p style="font-size: 10px">JD-guliyuan</p>
                <div class="buyBig"><img src="/resources/img/f1.jpg"></div>
                <div class="buySmall"><img src="/resources/img/f2.jpg"></div>
                <div class="buySmall" style="margin-top: 10px"><img src="/resources/img/f3.jpg"></div>
            </div>
            <div class="buyDiv">
                <p>防晒服饰没你不行</p>
                <p style="font-size: 10px">没事别整幺蛾子</p>
                <div class="buyBig"><img src="/resources/img/d1.jpg"></div>
                <div class="buySmall"><img src="/resources/img/d2.jpg"></div>
                <div class="buySmall" style="margin-top: 10px"><img src="/resources/img/d3.jpg"></div>
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
    layui.use(['form','jquery','layer','laydate','laypage'], function() {
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
            skin: '#35A9FF',
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
        var ordStsCd="${params.ordStsCd}";
        // 菜单级别动态赋值
        if(ordStsCd == '100') {
            $("#ordStsCd").find("option[value = '100']").attr("selected","selected");
        } else if(ordStsCd == '200') {
            $("#ordStsCd").find("option[value = '200']").attr("selected","selected");
        }else if(ordStsCd == '300'){
            $("#ordStsCd").find("option[value = '300']").attr("selected","selected");
        }else if(ordStsCd == '400'){
            $("#ordStsCd").find("option[value = '400']").attr("selected","selected");
        }else if(ordStsCd == '500'){
            $("#ordStsCd").find("option[value = '500']").attr("selected","selected");
        }else if(ordStsCd == '600'){
            $("#ordStsCd").find("option[value = '600']").attr("selected","selected");
        }else if(ordStsCd == '700'){
            $("#ordStsCd").find("option[value = '700']").attr("selected","selected");
        }
        form.render();


        //退出登录弹出窗
        $("#logout").on("click",function() {
            layer.confirm('是否退出?', {icon: 3, title: '提示'}, function (index) {
                //do something

                layer.close(index);
                window.location.href = "/vip/logout.do";


            });


        });

      $(".updateOrder").on('click',function () {
          var ordStsCd=$(this).attr("ordStsCd");
          var ordNo=$(this).attr("ordNo");
          var vipId="${vipInfo.vipId}";
          var vipNo="${vipInfo.vipNo}";

          $.ajax({
              type: "POST",
              url: "/order/updateOrder.do?ordNo="+ordNo+"&&ordStsCd="+ordStsCd+"&&vipId="+vipId+"&&vipNo="+vipNo,  //后台程序地址
              success:function (data) {
                  if(data.result =='success'){
                      alert("取消成功")
                  }else{
                      alert("取消失败")
                  }
              }
          })

      });
      /*点击签收 更改状态为签收， */
        $(".addSignin").on('click',function () {
            var ordNo=$(this).attr("ordNo");
            var id=$(this).attr("Id");
            var vipNo=$(this).attr("vipNo");
            var ordStsCd=$(this).attr("ordStsCd");
            $.ajax({
                type: "POST",
                url: "/order/addSignin.do?ordNo="+ordNo+"&&vipNo="+vipNo+"&&ordStsCd="+ordStsCd,  //后台程序地址
                success:function (data) {
                    if(data.result =='success'){
                        alert("签收成功")
                    }else{
                        alert("已签收")
                    }
                }
            })

        });

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

        $(".prdDtl").on("click",function () {
            var ordNo=$(this).attr("ordNo");
            var vipNo="${vipInfo.vipNo}";
            layer.open({
                title: '订单详情 - '
                , area: ['1000px', '600px']
                , offset: '150px'
                , type: 2 //content内容为一个连接
                , content: '/order/prdDtl.do?ordNo='+ordNo+"&&vipNo="+vipNo
            });
        })




    })


</script>
</html>
