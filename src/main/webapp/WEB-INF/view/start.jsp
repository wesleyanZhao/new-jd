<%--
  Created by IntelliJ IDEA.
  User: Lanou3G
  Date: 2017/8/1
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<input name="a" id="d" value="" hidden>
</body>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script>
    layui.use(['form','jquery','layer','laydate'], function() {
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
            $("#d").val(k+1)
        })



    })


</script>
</html>
