<%@ page import="cn.doreou.model.Book" %>
<%@ page import="cn.doreou.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.Goods" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/3/4
  Time: 19:59
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
    <link rel="stylesheet" href="/css/favor.css">
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
    Object mycollect=(List<Goods>) session.getAttribute("mycollect");
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
                    <a target="_blank" href="/Page/joinus">加入我们</a>
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
                    <input name="keyword" type="text" id="serachWord" style="color: black" class="form-control search-field" placeholder="搜索一下..."> </div>
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
                    <img style="width: 22px;height: 22px" src="<%=b.getIcon()%>">
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
        <span class="" id="js-numberrock"></span>
    </div>
    <div class="erweima">
        <a class="qq" href="tencent://message/?uin=1250305708&amp;Site=QQ交谈&amp;Menu=yes" target="_blank"></a>
        <a href="http://weibo.com" class="wb"></a>
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
            <input id="user_id" style="display: none;" value="<%=userList.get(0).getUser_id()%>">
            <div class="name">
                <%=userList.get(0).getUsername()%> </div>
            <p class="has_sell">共有<span class="all" id="sell">0</span>件二手商品，共有<span class="all" id="buy">0</span>件求购商品，已卖出<span id="AlreadySold">0</span>件商品</p>
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
            <li class="item-info col-lg-2"><a href="/Page/info">个人资料</a></li>
            <li class="item-goods col-lg-2 "><a href="/Order/getMySale">我发布的商品</a></li>
            <li class="item-buy col-lg-2 "><a href="/Order/getMyBuy">我发布的求购</a></li>
            <li class="item-favor col-lg-2 current"><a href="/Order/getMycollect">我的收藏</a></li>
            <li class="item-message col-lg-2 "><a href="/Page/mynews">消息中心</a></li>
            <li class="item-cert col-lg-2 "><a href="/Page/checkinfo">认证信息</a></li>
            <li class="back" style="left: 595px; width: 198px;">
                <div class="left"></div>
            </li>
        </ul>
    </div>

    <div class="favor-box">
        <div id="my_enshrine">
            <%if(mycollect==null){%>
                <div class="no-data">
                    <p class="text">您暂时还没有收藏的二手物品呃！你可以</p>
                    <a href="/Page/salegoods" target="_blank">
                        <p class="btn">发布商品</p>
                    </a>
                    <a href="/Page/sale" target="_blank">
                        <p class="btn">浏览商城商品</p>
                    </a>
                </div>
            <%}else{
                for(Goods g:(List<Goods>)mycollect){%>
                    <div class="enshr_each <%=g.getGoods_id()%>">
                        <a class="clearfix pull-left" target="_blank" href="/Order/getgoodsinfo?id=<%=g.getGoods_id()%>">
                            <img alt="<%=g.getGoods_title()%>" src="<%=g.getCover()%>" class="enshr_ph">
                        </a>
                        <div class="enshr_info">
                            <h2><a target="_blank" href="/Order/getgoodsinfo?id=<%=g.getGoods_id()%>"><%=g.getGoods_title()%></a></h2>
                            <p></p>
                            <div class="enshr_state">
                                <a href="/Order/undocollect?id=<%=g.getGoods_id()%>"><span class="pull-right btn btn-warning btn-sm">取消收藏</span></a>
                                <span class="onsaling">出售中</span>
                            </div>
                        </div>
                    </div>
                <%}
            }%>
        </div>
        <div id="page" style="text-align: center"></div>
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
<script src="/js/Total.js"></script>
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

        if(<%=userList.get(0).getMember_status()==0%>){
            $('#checkmember').html("未认证");
        }else{
            $('#checkmember').html("已认证");
        }

        if(<%=userList.get(0).getLabel()==null%>){
            $('.user_qianming').html("ta很懒，还没有留下签名哦~");
        }else{
            $('.user_qianming').html("<%=userList.get(0).getLabel()%>");
        }

    })
    function getData(curr){
        $.ajax({
            type:'POST',
            url:'${pageContext.request.contextPath}/Order/getMycollect?page='+curr,
            success:function () {
                window.location.href='${pageContext.request.contextPath}/Order/getMycollect?page='+curr;
            }
        })
    }
    layui.use('laypage', function(){
        var laypage = layui.laypage;
        var total=${mycollectcount};
        var currpage=1;
        laypage.render({
            elem: 'page'
            ,count:total  //数据总数，从服务端得到
            ,curr:${currpage}
            ,limit:5
            ,jump: function(obj, first){
                //首次不执行
                if(!first){
                    //do something
                    currpage=obj.curr;
                    getData(currpage);
                }
            }

        });
    });
    $("#sureCut").on("click", function () {
        if ($("#tailoringImg").attr("src") == null) {
            return false;
        } else {
            var cas = $('#tailoringImg').cropper('getCroppedCanvas');// 获取被裁剪后的canvas
            var base64 = cas.toDataURL('image/png'); // 转换为base64
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

