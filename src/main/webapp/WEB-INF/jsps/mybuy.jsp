<%@ page import="cn.doreou.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.User" %>
<%@ page import="cn.doreou.model.Goods" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/3/4
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>我的信息</title>
    <link href="/css/animate.css" rel="stylesheet" />
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/css/login.css" rel="stylesheet" />
    <link href="/css/salestyle.css" rel="stylesheet" />
    <link href="/css/custom.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="/css/common.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/infohead.css" />
    <link rel="stylesheet" type="text/css" href="/css/cropper.min.css" />
    <link rel="stylesheet" href="/css/info.css" />
    <link rel="stylesheet" href="/css/mybuy.css">
    <link rel="stylesheet" href="/css/layui.css">
    <link rel="stylesheet" href="/css/ImgCropping.css">
    <script src="/layui.js"></script>
    <script src="/js/jquery.js"></script>
    <script src="/js/layer.js"></script>
    <script src="/js/cropper.min.js"></script>
</head>
<body class="  pace-done">
<%
    //    获取分类信息
    List<Book> bookList = (List<Book>) session.getAttribute("AllSubject");
    List<User> userList=(List<User>) session.getAttribute("user");
    Object mybuy=session.getAttribute("mybuy");
    if(mybuy!=null){
        mybuy=(List<Goods>) mybuy;
    }
%>
<div class="pace  pace-inactive">
    <div class="pace-progress" data-progress-text="100%" data-progress="99" style="width: 100%;">
        <div class="pace-progress-inner"></div>
    </div>
    <div class="pace-activity"></div>
</div>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img alt="Brand" src="/images/login_45x45.png">
        </a>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="js-nav-slide">
                <li>
                    <a href="/">首页
                        <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="">
                    <a href="/Page/sale">二手</a>
                </li>
                <li class="current">
                    <a href="/Page/buy">求购</a>
                </li>
                <li class="">
                    <a target="_blank" href="/app">APP</a>
                </li>
                <li class="">
                    <a target="_blank" href="/applyschool">开通学校</a>
                </li>
                <li class="">
                    <a target="_blank" href="/joinus">加入我们</a>
                </li>
                <li class="">
                    <a target="_blank" href="/contact">联系我们</a>
                </li>
                <li class="back" style="left: 132px; width: 66px;">
                    <div class="left"></div>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right login-box" id="js_visible">
                <li>
                    <a href="/Page/login">登陆</a>
                </li>
                <li>
                    <a href="/page/register">注册</a>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right login-box" id="login_show">
                <li>
                    <a class="headpic-link" target="_blank" href="/Page/info">
                        <img class="headpic" src="/images/default3.png">
                    </a>
                </li>
                <li>
                    <a href="/User/logout">退出</a>
                </li>
            </ul>
            <form class="navbar-form navbar-right search-box" onsubmit="return false;">
                <div class="form-group pull-left">
                    <input name="keyword" type="text" id="serachWord" class="form-control search-field" placeholder="搜索一下..."> </div>
                <button type="submit" onclick="toSearch()" class="btn btn-default pull-left search-btn">搜索</button>
            </form>
        </div>
    </div>
</nav>
<div class="item-box">
    <ul class="all-item" id="js-sale-item">
        <% for (Book b : bookList) {
        %>
        <a href="/buy/type/<%=b.getSub_id()%>" class="clearfix">
            <li class="item clearfix text-center">
                <div class="icon pull-left">
                    <i class="icon iconfontitems"></i>
                </div>
                <div class="title pull-left">
                    <%=b.getSubject()%>
                </div>
            </li>
        </a>
        <%}%>
        <%--<li class="back" style="top: 112px; width: 134px; height: 55px; overflow: hidden;">--%>
        <%--<div class="left"></div>--%>
        <%--</li>--%>
    </ul>
</div>
<div class="sidebar">
    <div class="btn block">
        <div class="ershou">
            <a href="/Page/salegoods">发布二手</a>
        </div>
        <div class="qiugou">
            <a href="/Page/buygoods">发布求购</a>
        </div>
    </div>
    <div class="helped block">
        <span class="" id="js-numberrock">1603</span>
    </div>
    <div class="erweima">
        <a class="qq" href="tencent://message/?uin=307242951&amp;Site=QQ交谈&amp;Menu=yes" target="_blank"></a>
        <a href="http://weibo.com/u/276233227/" class="wb"></a>
    </div>
</div>

<div class="main center">
    <div class="top clearfix">
        <div id="user_photo" class="pull-left">
            <img id="origin_ph" src="/images/default3.png" alt="头像" style="">
            <img data-toggle="modal" data-target="#myModal" id="change_ph" src="/images/mkhead_hover.png" alt="头像"
                 style="display: none;">
        </div>
        <div id="user_msg">
            <div class="name">
                <%=userList.get(0).getUsername()%> </div>
            <p class="has_sell">共有<span class="all">0</span>件商品，已卖出<span>0</span>件商品</p>
            <ul class="seller_attr">
                <li>学校：&nbsp;&nbsp;<span>大连大学</span></li>
                <li>签名：&nbsp;&nbsp;<span class="user_qianming"></span></li>
                <li>认证：&nbsp;&nbsp;<span id="checkmember">
								</span></li>
            </ul>
        </div>
    </div>

    <div style="display: none" class="tailoring-container">
        <form action="/User/upload" id="upload">
        <div class="tailoring-content" style="top: 100px; left: 365.5px;">
            <div class="tailoring-content-one">
                <label title="上传图片" for="chooseImg" class="l-btn choose-btn">
                    <input type="file" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg" class="hidden" onchange="selectImg(this)">
                    选择图片
                </label>
                <div class="close-tailoring">×</div>
            </div>
            <div class="tailoring-content-two">
                <div class="tailoring-box-parcel">
                    <img id="tailoringImg">
                </div>
                <div class="preview-box-parcel">
                    <p>图片预览：</p>
                    <div class="square previewImg"></div>
                    <div class="circular previewImg"></div>
                </div>
            </div>
            <textarea style="display: none" name="code" id="code"></textarea>
            <div class="tailoring-content-three">
                <button class="l-btn cropper-reset-btn">复位</button>
                <button class="l-btn cropper-rotate-btn">旋转</button>
                <button class="l-btn cropper-scaleX-btn">换向</button>
                <button class="l-btn sureCut" id="sureCut">确定</button>
            </div>
        </div>
        </form>
    </div>


    <div class="container-fluid">
        <ul id="middle_nav" class="clearfix row">
            <li class="item-info col-lg-2"><a href="/Page/info">个人资料</a></li>
            <li class="item-goods col-lg-2"><a href="/Page/mysale">我发布的商品</a></li>
            <li class="item-buy col-lg-2 current "><a href="/Page/mybuy">我发布的求购</a></li>
            <li class="item-favor col-lg-2 "><a href="/Page/mycollect">我的收藏</a></li>
            <li class="item-message col-lg-2 "><a href="/Page/mynews">消息中心</a></li>
            <li class="item-cert col-lg-2 "><a href="/Page/checkinfo">认证信息</a></li>
            <li class="back" style="left: 397px; width: 198px;">
                <div class="left"></div>
            </li>
        </ul>
    </div>

    <div id="my_products">
        <div class="no-data">
            <p class="text">您暂时还没有发布求购信息呃！你可以</p>
            <a href="/release/buy" target="_blank">
                <p class="btn">发布求购信息</p>
            </a>
            <a href="/buy/index" target="_blank">
                <p class="btn">查看求购模块</p>
            </a>
        </div>
        <%if(mybuy!=null){
            for (Goods g:(List<Goods>)mybuy){%>
        <div id="sold_out_pro">
            <div class="enshr_each">
                <img class="enshr_ph pull-left" alt="<%=g.getGoods_title()%>" src="/Public/images/icon/buyicon.png">
                <div class="enshr_info">
                    <h2><%=g.getGoods_title()%></h2>
                    <p><%=g.getIntroduce()%></p>
                    <div class="enshr_state">
                        <div class="btn-group">
                            <a href="/user/reflashbuy/buyid/348">
                                <span value="" class="btn btn-info btn-sm">擦亮</span>
                            </a>
                            <a href="/user/shelvesbuy/buyid/348">
                                <span class="btn btn-warning btn-sm">下架</span>
                            </a>
                            <a href="/user/delbuy/buyid/348">
                                <span class="btn btn-danger btn-sm">删除</span>
                            </a>                                    </div>
                        <span class="autosale_now">求购信息正在展示，90天后自动下架</span>
                    </div>
                </div>
            </div>
        </div>
        <%}
        }%>
        <div class="text-center">
            <nav><ul class="pagination"></ul></nav>
        </div>
    </div>
    <div class="common-footer">
        <div class="footerNav">
            <ul class="fn">
                <li><span class="fnIco"></span><a href="/Page/contact">关于我们</a></li>
                <li><span class="fnIco"></span><a href="/Page/joinus">加入我们</a></li>
                <li><span class="fnIco"></span><a href="/Page/sale">校内二手</a></li>
                <li><span class="fnIco"></span><a href="/Page/buy">校内求购</a></li>
                <li><span class="fnIco"></span><a href="/Page/login">我要登录</a></li>
                <li><span class="fnIco"></span><a href="/Page/register">我要注册</a></li>
            </ul>
        </div>
        <div class="footerMain">
            <a href="/index/index" class="fLogo" style="background: url(../../images/login.jpg) no-repeat;">大连大学二手图书交易平台</a>
            <div class="fContact">
                <h3 class="fct">联系我们 / <span>contact us</span></h3>
                <p>Q群：999999999</p>
                <p>Q Q：111111111</p>
                <p>地址：辽宁省大连市大连大学</p>
            </div>
            <div class="fEwm">
                <img width="106" height="106" alt="微信公众号" src="../../images/1550323940.jpg">
                <p>关注微信公众平台</p>
            </div>
            <div class="fCall">
                <p class="callN">TEL:12345678901</p>
                <span class="kfT">24小时在线客服</span>
                <a class="fxl" href="http://weibo.com/" target="_blank">新浪微博</a>
                <a class="fqq" href="" target="_blank">客服QQ</a>
                <a class="fwx tips">微信二维码</a>
            </div>
        </div>
        <p class="copyright">版权所有 © All Rights Reserved
        </p>
    </div>

</div>
<script>
    $(document).ready(function(){
        if(<%=mybuy==null%>){
            $("#sold_out_pro").hide();
        }else{
            $(".no-data").hide();
        }
        if (<%=userList!=null%>) {
            //隐藏登陆/注册
            $("#js_visible").hide();
        } else {
            //隐藏信息div
            $("#login_show").hide();
        }

        if(<%=userList.get(0).getMember_status()==0%>){
            $('#checkmember').html("未认证");
        }else{
            $('#checkmember').html("已认证");
        }

        //上传控制图层js控制器
        $("#change_ph").bind("click",function(){
            $('.tailoring-container').attr("style","display:block");
        });

        $(".close-tailoring").bind("click",function(){
            $('.tailoring-container').attr("style","display:none");
        });
        //结束


        $("#origin_ph").bind("mouseenter",function(){
            $('#change_ph').attr("style","display:block");
        });
        $("#change_ph").bind("mouseleave",function(){
            $('#change_ph').attr("style","display:none");
        });

        if(<%=userList.get(0).getLabel()==null%>){
            $('.user_qianming').html("ta很懒，还没有留下签名哦~");
        }else{
            $('.user_qianming').html("<%=userList.get(0).getLabel()%>");
        }

    })

    function selectImg(file) {
        var reader = new FileReader();
        reader.onload = function(evt) {
            var replaceSrc = evt.target.result;
            // 更换cropper的图片
            $('#tailoringImg').cropper('replace', replaceSrc);// 默认false，适应高度，不失真
        }
        reader.readAsDataURL(file.files[0]);
    }
    // cropper图片裁剪
    $('#tailoringImg').cropper({
        aspectRatio : 1 / 1,// 默认比例
        preview : '.previewImg',// 预览视图
        guides : false, // 裁剪框的虚线(九宫格)
        autoCropArea : 0.5, // 0-1之间的数值，定义自动剪裁区域的大小，默认0.8
        movable : false, // 是否允许移动图片
        dragCrop : true, // 是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
        movable : true, // 是否允许移动剪裁框
        resizable : true, // 是否允许改变裁剪框的大小
        zoomable : false, // 是否允许缩放图片大小
        mouseWheelZoom : false, // 是否允许通过鼠标滚轮来缩放图片
        touchDragZoom : true, // 是否允许通过触摸移动来缩放图片
        rotatable : true, // 是否允许旋转图片
        crop : function(e) {
            // 输出结果数据裁剪图像。
        }
    });
    // 旋转
    $(".cropper-rotate-btn").on("click", function() {
        $('#tailoringImg').cropper("rotate", 45);
    });
    // 复位
    $(".cropper-reset-btn").on("click", function() {
        $('#tailoringImg').cropper("reset");
    });
    // 换向
    var flagX = true;
    $(".cropper-scaleX-btn").on("click", function() {
        if (flagX) {
            $('#tailoringImg').cropper("scaleX", -1);
            flagX = false;
        } else {
            $('#tailoringImg').cropper("scaleX", 1);
            flagX = true;
        }
        flagX != flagX;
    });

    $("#sureCut").on("click", function() {
        if ($("#tailoringImg").attr("src") == null) {
            return false;
        } else {
            var cas = $('#tailoringImg').cropper('getCroppedCanvas');// 获取被裁剪后的canvas
            var base64 = cas.toDataURL('image/png'); // 转换为base64
            alert(base64);
            $('#code').html(base64);
            $('.tailoring-container').attr("style","display:none");
            $('#upload').submit();

        }
    });


    // layui.use('upload', function(){
    //     var upload = layui.upload;
    //     //执行实例
    //     var uploadInst = upload.render({
    //         elem: '#change_ph' //绑定元素
    //         ,url: '/upload/' //上传接口
    //         ,done: function(res){
    //             //上传完毕回调
    //         }
    //         ,error: function(){
    //             //请求异常回调
    //         }
    //     });
    // });

</script>

</body>
</html>

