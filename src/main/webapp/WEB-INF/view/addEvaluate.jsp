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
    <style>
        .container{
            float:left;
        }
        .score{
            float: left;
            position: relative;
            width: 100px;
            margin-top: 5px;
            margin-left: 10px;
        }
        span{
            display: none;
            position: absolute;
            left: 0;
            top: 0;
        }
        .scoreDisplay{
            display: block;
        }
    </style>
</head>
<body>
<div class="nav">

</div>
<fieldset class="layui-elem-field" >
    <legend></legend>
    <div class="layui-field-box" >

        <form class="layui-form" >

            <input type="hidden" name="prdNo" value="${params.prdNo}">
            <input type="hidden" name="ordNo" value="${params.ordNo}">
            <input type="hidden" name="prdDtlNo" value="${params.prdDtlNo}">
            <input type="hidden" name="vipNo" value="${vipInfo.vipNo}">
            <!--   一个容器里面放5张图片,先所有的都空星图片-->
            <!--   该案例的要点就是在于鼠标移动上去时改变图片的src-->
            <div class="container">
                <img src="/resources/img/s.png" alt="">
                <img src="/resources/img/s.png" alt="">
                <img src="/resources/img/s.png" alt="">
                <img src="/resources/img/s.png" alt="">
                <img src="/resources/img/s.png" alt="">
            </div>
            <div class="score">
                <span>很差</span>
                <span>较差</span>
                <span>一般</span>
                <span>较好</span>
                <span>很好</span>
            </div>
            <div class="layui-form-item layui-form-text">
                <div class="layui-input-block">
                    <textarea placeholder="请输入内容" style="margin-left: -50px" name="content" class="layui-textarea"></textarea>
                </div>
            </div>
            <input type="hidden" id="cmmLevel" name="cmmLevel" value="">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal"  lay-submit lay-filter="addEvaluate">立即提交</button>
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


        var img = $(".container img");//获取5张图片的集合
        var span = $(".score span");
        var i,j,k;//定义变量i,j,k
        k = -1;//k给予一个初始值-1,,不然后面第1个星星始终是被点亮的
        img.mouseenter(function(){  //设置鼠标进入时的效果,首先将所有的星星熄灭,然后再根据用户鼠标进入的星星下标值点亮星星
            span.removeClass("scoreDisplay");//鼠标进入时，将右边的评论清除掉
            img.attr("src","/resources/img/s.png");
            i = img.index(this);
            for(j=0;j<=i;j++)
            {
                img.eq(j).attr("src","/resources/img/d.png");
            }
            span.eq(i).addClass("scoreDisplay");//根据用户进入的i值来显示评论
        }).mouseleave(function(){   //仍然是将所有的星星熄灭,然后根据k值来点亮星星
            span.removeClass("scoreDisplay");//鼠标离开时，首先清除掉评论
            img.attr("src","/resources/img/s.png");//接下来将所有星星变为空星
            for(j=0;j<=k;j++)//根据最终值k值来确定点亮几颗星星
            {
                img.eq(j).attr("src","/resources/img/d.png");

            }
            if(k==-1)//如果k值=-1,则不显示任何一个评论内容
            {
                span.removeClass("scoreDisplay");
            }
            else{
                span.eq(k).addClass("scoreDisplay");//根据最终值k值显示评论
            }
        });
        $("img").click(function(){ //k记录用户点击鼠标时的星星下标值
            k = img.index(this);
            $("#cmmLevel").val(k+1)
        })

        //监听提交
        form.on('submit(addEvaluate)', function(params){
            //表单数据
            /* var username = $("#username").val();
             var password = $("#password").val();
             var gender = $("input[name='gender']:checked").val();
             var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();

            $.ajax({
                type: "POST",
                url: "/order/addEvaluateForm.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){           //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    if (data.result == 'success'){   //如果成功了, 则关闭当前layer
                        layer.msg('评论成功',{
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
                        layer.msg('评论失败')

                    }
                }
            });
            return false;//return false 表示不通过页面刷新方式提交表单
        });


    });
</script>
</body>

</html>
