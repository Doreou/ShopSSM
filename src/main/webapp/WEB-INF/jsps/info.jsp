<%@ page import="cn.doreou.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/3/3
  Time: 15:30
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
    <link href="/css/newstyle.css" rel="stylesheet" />
    <link href="/css/custom.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="/css/common.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/infohead.css" />
    <link rel="stylesheet" type="text/css" href="/css/cropper.min.css" />
    <link rel="stylesheet" href="/css/info.css" />
    <link rel="stylesheet" href="/css/layui.css">
    <link rel="stylesheet" href="/css/ImgCropping.css">
    <link rel="stylesheet" href="/css/layer.css">
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
                    <a target="_blank" href="/Page/joinus">加入我们</a>
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
                        <img class="headpic" <%if(session.getAttribute("user")==null){%>src="/images/default3.png"
                            <%}else {
                                List<User> user=(List<User>) session.getAttribute("user");
                                if(user.get(0).getIcon()!=null){%>
                             src="<%=user.get(0).getIcon()%>"
                            <%}else {%>
                             src="/images/default3.png"
                            <%}
                                    %>
                            <%}%>>
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
        <a href="/Order/searchbuybypage?page=1" class="clearfix">
            <li class="item clearfix text-center">
                <div class="icon pull-left">
                    <span class="iconfont icon-icon"></span>
                </div>
                <div class="title pull-left">
                    所有分类
                </div>
            </li>
        </a>
        <% for (Book b : bookList) {
        %>
        <a href="/Order/querybuybysub?select=<%=b.getSubject()%>" class="clearfix">
            <li class="item clearfix text-center">
                <div class="icon pull-left">
                    <span class="iconfont <%=b.getIcon()%>"></span>
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
            <img id="origin_ph" <%if(session.getAttribute("user")==null){%>src="/images/default3.png"
                <%}else {
                                List<User> user=(List<User>) session.getAttribute("user");
                                if(user.get(0).getIcon()!=null){%>
                 src="<%=user.get(0).getIcon()%>"
                <%}else {%>
                 src="/images/default3.png"
                <%}
                                    %>
                <%}%> alt="头像" style="">
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
                        <input type="file" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg"
                               class="hidden" onchange="selectImg(this)">
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
            <li class="item-info col-lg-2 current"><a href="/Page/info">个人资料</a></li>
            <li class="item-goods col-lg-2 "><a href="/Order/getMySale">我发布的商品</a></li>
            <li class="item-buy col-lg-2 "><a href="/Order/getMyBuy">我发布的求购</a></li>
            <li class="item-favor col-lg-2 "><a href="/Order/getMycollect">我的收藏</a></li>
            <li class="item-message col-lg-2 "><a href="/Page/mynews">消息中心</a></li>
            <li class="item-cert col-lg-2 "><a href="/Page/checkinfo">认证信息</a></li>
            <li class="back" style="left: 0px; width: 198px;">
                <div class="left"></div>
            </li>
        </ul>
    </div>


    <div class="pop-tip hide">
        <div class="pop-tip-area">
            <p class="pop-tip-txt">修改成功</p>
        </div>
    </div>
    <div id="my_info">
        <div id="account_info">
            <h2>账户信息</h2>
            <ul class="infos">
                <li>账号</li>
                <li class="right_info">
                    <span><%=userList.get(0).getUser_id()%></span>
                </li>
            </ul>
        </div>
        <div id="base_info">
            <form id="f" action="${pageContext.request.contextPath}/User/editinfo">
            <h2>基本信息 <span id="edit_info">编辑</span><span id="save_info" onclick="updateinfo()">保存</span></h2>
            <ul class="infos">
                <li>昵称</li>
            <li class="right_info">
                <span id="nickname_span"><%=userList.get(0).getUsername()%></span>
                <input value="<%=userList.get(0).getUsername()%>" id="nickname" name="nickname" type="text">
            </li>
            </ul>
            <ul class="infos">
                <li>年龄</li>
                <li class="right_info">
                    <span id="user_age"><%=userList.get(0).getAge()%></span>
                    <input value="<%=userList.get(0).getAge()%>" id="age" name="age" type="text">
                </li>
            </ul>
            <ul class="infos">
                <li>签名</li>
                <li class="right_info">
                    <span id="qianming_span"></span>
                    <input value="<%=userList.get(0).getLabel()%>" id="qianming" name="qianming" type="text">
                </li>
            </ul>
            <ul class="infos">
                <li>微信</li>
                <li class="right_info">
                    <span id="user_wechat"><%=userList.get(0).getWechat()%></span>
                    <input value="<%=userList.get(0).getWechat()%>" id="wechat" name="wechat" type="text">
                </li>
            </ul>
            <ul class="infos">
                <li>手机</li>
                <li class="right_info">
                    <span id="phone_span"><%=userList.get(0).getPhone()%></span>
                    <input type="text" name="phone" id="phone" value="<%=userList.get(0).getPhone()%>">
                </li>
            </ul>
            <ul class="infos">
                <li>email</li>
                <li class="right_info">
                    <span id="email_span"><%=userList.get(0).getEmail()%></span>
                    <input value="<%=userList.get(0).getEmail()%>" id="email" name="email" type="text">
                </li>
            </ul>
            <ul class="infos">
                <li>QQ</li>
                <li class="right_info">
                    <span id="qq_span"><%=userList.get(0).getQq()%></span>
                    <input value="<%=userList.get(0).getQq()%>" id="qq" name="qq" type="text">
                </li>
            </ul>
            </form>
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
<script src="/js/upload.js"></script>
<script>
    $(document).ready(function(){
        var errmsg="";
        errmsg="<%=session.getAttribute("errmsg")%>";
        if(errmsg!=""&&errmsg!="null"){
            layer.msg(errmsg.toString());
            //提示后重置errmsg
            <%session.setAttribute("errmsg","");%>
        }

        if (<%=userList!=null%>) {
            //隐藏登陆/注册
            $("#js_visible").hide();
        } else {
            //隐藏信息div
            $("#login_show").hide();
        }

        //点击编辑进入信息编辑
        $("#edit_info").click(function(){
            $(this).css({
                display: "none"
            })
            $("#save_info").css({
                display: "block"
            })
            $(".right_info span").css({
                display: "none"
            })
            $(".right_info input").css({
                display: "inline"
            })
        });
        if(<%=userList.get(0).getMember_status()==0%>){
            $('#checkmember').html("未认证");
        }else{
            $('#checkmember').html("已认证");
        }

        //如果用户已登录 隐藏登陆/注册按钮
        //显示用户头像和退出
        if(<%=userList.get(0).getLabel()==null%>){
            $('#qianming').html("ta很懒，还没有留下签名哦~");
            $('.user_qianming').html("ta很懒，还没有留下签名哦~");
            $('#qianming_span').html("ta很懒，还没有留下签名哦~");
        }else{
            $('#qianming').html("<%=userList.get(0).getLabel()%>");
            $('.user_qianming').html("<%=userList.get(0).getLabel()%>");
            $('#qianming_span').html("<%=userList.get(0).getLabel()%>");
        }
    })

    //保存
    function updateinfo(){
        $("#save_info").bind('click',function(){
            $('#f').action="${pageContext.request.contextPath}/User/editinfo";
            $('#f').submit();
        })
    }
    $("#sureCut").on("click", function () {
        if ($("#tailoringImg").attr("src") == null) {
            return false;
        } else {
            var cas = $('#tailoringImg').cropper('getCroppedCanvas');// 获取被裁剪后的canvas
            var base64 = cas.toDataURL('image/jpg'); // 转换为base64
            $('#code').html(base64);
            $('.tailoring-container').attr("style", "display:none");
            $.ajax({
                type:'POST',
                url:'${pageContext.request.contextPath}/User/upload',
                data:$('#upload').serialize(),
                success:function (data) {
                    if(data=='true'){
                        location.reload();
                    }
                }
            })
        }
    });

</script>

</body>
</html>

