<%@ page import="cn.doreou.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.User" %>
<%@ page import="cn.doreou.model.GoodAndUser" %>
<%@ page import="cn.doreou.model.Goods" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--Created by IntelliJ IDEA.
User: Holmes
Date: 2019/2/17
Time: 10:54
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>校园求购</title>
    <link href="/css/iconfont.css" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet"/>
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/newstyle.css" rel="stylesheet"/>
    <link href="/css/login.css" rel="stylesheet"/>
    <link href="/css/custom.css" rel="stylesheet">
    <link href="/css/swiper-3.4.2.min.css" rel="stylesheet">
    <link href="/css/buy.css" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet"/>
    <link href="/css/showsale.css" rel="stylesheet">
    <script src="/js/jquery.js"></script>
    <script src="/layui.js"></script>
    <script src="/layui.all.js"></script>
    <link href="/css/layui.css" rel="stylesheet">
    <link href="/css/layer.css" rel="stylesheet">
    <style>
        .layui-carousel {
            margin: auto;
        }
    </style>
</head>
<body class="  pace-done">
<%
    //    获取分类信息
    List<Book> bookList = (List<Book>) session.getAttribute("AllSubject");
    Object userList = session.getAttribute("user");
    List<GoodAndUser> usersinfo = (List<GoodAndUser>) session.getAttribute("userinfo");
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
            &#12288;&#12288;&#12288;
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
                    <a target="_blank" href="/Page/contact">联系我们</a>
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

            <form class="navbar-form navbar-right search-box" action="/Order/searchbuy">
                <div class="form-group pull-left">
                    <input name="keyword" type="text" id="serachWord" class="form-control search-field"
                           placeholder="搜索一下..."></div>
                <button type="submit" class="btn btn-default pull-left search-btn">搜索</button>
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

<div class="wrap clearfix">
    <div class="main clearfix">
        <div class="adv">
            <div class="layui-carousel" id="test1" lay-filter="test1">
                <div carousel-item="">
                    <div><img src="/images/timg.jpg"></div>
                    <div><img src="/images/lunbo2_600x280.jpg"></div>
                </div>
            </div>
        </div>
        <div class="school-box">
            <div class="outer-school">
                <div class="inner-box">
                    <div class="order">
                        <div class="order-line">
                            <input id="way" style="display: none" value="asc">
                            <input id="hiddentype" style="display: none" value="购入">
                            <%--<a><span class="iconfont icon-px-" id="random" style="font-size: 14px;color: #F10;">推荐</span></a>--%>
                            <a onclick="orderByTime($('#way').val())"><span class="iconfont icon-px-" id="time" style="font-size: 14px;color: #F10">发布时间</span></a>
                            <a onclick="orderByPrice($('#way').val())"><span class="iconfont icon-px-" id="price" style="font-size: 14px;color: black">价格</span></a>
                            <a onclick="orderByHot($('#way').val())"><span class="iconfont icon-px-" id="hot" style="font-size: 14px;color: black">热度</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="list clearfix" id="dataform">
            <input id="page-way" style="display: none" <%if(session.getAttribute("way")!=null){%>
                   value="<%=session.getAttribute("way")%>"
                <%}else{%>
                   value="asc"
                <%}%>>
            <%Object goodslist = session.getAttribute("AllBuyGoodsList");%>
            <% for (Goods g : (List<Goods>) goodslist) {%>
            <div class="itemlist clearfix">
                <div class="itembox clearfix">
                    <div class="item_main">
                        <div class="left">
                            <div class="userhead">
                                <%
                                    for (GoodAndUser u : usersinfo) {
                                        if (u.getGoods_id() == g.getGoods_id()) {
                                %>
                                <img src="<%=u.getIcon()%>">
                                <%
                                        }
                                    }
                                %>
                            </div>
                            <div class="username">
                                <%
                                    for (GoodAndUser u : usersinfo) {
                                        if (u.getGoods_id() == g.getGoods_id()) {
                                %>
                                <a target="_blank" href="/other/salenow?userid=3713"><%=u.getUsername()%>
                                </a>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>
                        <div class="right">
                            <div class="title">
                                <%=g.getGoods_title()%>
                            </div>
                            <div class="desc">
                                <%=g.getIntroduce()%>
                            </div>
                            <div class="attr">
                                期望价格：<span class="price"><%=g.getExpt_price()%></span> 交易地点：<span
                                    class="position">宿舍</span>
                                发布时间：<span class="datetime"><%
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                String time = sdf.format(g.getTime());
                            %><%=time%></span>
                                学校：<span class="school">大连大学</span>
                            </div>
                            <div class="contact">
                                <%
                                    for (GoodAndUser u : usersinfo) {
                                        if (u.getGoods_id() == g.getGoods_id()) {
                                %>
                                <span class="phone">手机：<span class="telnum">
                                    <%if (u.getPhone() != null) {%>
                                        <%=u.getPhone()%>
                                    <%} else {%>
                                        ta还没有留下电话哦~
                                    <%}%>
                                                                                                                                    </span> </span>
                                <span class="qq">QQ：<span class="qqnum">
                                            <%if (u.getQq() != null) {%>
                                        <%=u.getQq()%>
                                    <%} else {%>
                                        ta还没有留下QQ哦~
                                    <%}%>                                                                                           </span>
                                        </span>
                                <span class="phone">微信：<span class="telnum">
                                                                                            <%if (u.getWechat() != null) {%>
                                        <%=u.getWechat()%>
                                    <%} else {%>
                                        ta还没有留下微信哦~
                                    <%}%>                                        </span> </span>
                                <span class="qq">用户认证状态：<span class="qqnum">
                                            <%if (u.getMember_status() == 0) {%>
                                                未认证
                                            <%} else {%>
                                                已认证
                                            <%}%>                                            </span>
                                        </span>                                                                         </span> </span>
                                <%
                                        }
                                    }
                                %>
                            </div>
                            <!--<a class="comment" href="javascript:showcomment(1016)">评论</a>-->
                        </div>
                    </div>
                    <div id="item1016" class="item_comments" style="display: none;">
                        <div class="comment_wr">
                        </div>
                    </div>
                </div>
            </div>

            <%}%>
        </div>
        <div id="page" style="text-align: center">

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
</div>
<script src="/js/sort.js"></script>
<script>
    $(document).ready(function () {

        //如果用户已登录 隐藏登陆/注册按钮
        //显示用户头像和退出
        if (<%=userList!=null%>) {
            //隐藏登陆/注册
            $("#js_visible").hide();
        } else {
            //隐藏信息div
            $("#login_show").hide();
        }

    })

    layui.use(['carousel', 'form'], function () {
        var carousel = layui.carousel

        //常规轮播
        carousel.render({
            elem: '#test1'
            ,anim:'fade'

        });
    });


    function getData(curr){
        var way=$('#page-way').val();
        var type=$('#hiddentype').val();
        var url='${pageContext.request.contextPath}/Order/searchbuybypage?page='+curr;
        if(window.getComputedStyle(document.getElementById("time"),null).color=="rgb(255, 17, 0)"){
            url='${pageContext.request.contextPath}/Order/orderbytime?page='+curr+'&way='+way+'&type='+type;
        }else if(window.getComputedStyle(document.getElementById("hot"),null).color=="rgb(255, 17, 0)"){
            url='${pageContext.request.contextPath}/Order/orderbyhot?page='+curr+'&way='+way+'&type='+type;
        }else if(window.getComputedStyle(document.getElementById("price"),null).color=="rgb(255, 17, 0)"){
            url='${pageContext.request.contextPath}/Order/orderbyprice?page='+curr+'&way='+way+'&type='+type;
        }
        $.ajax({
            type:'POST',
            url:url,
            success:function (msg) {
                $('#dataform').html(msg);
            }
        })
    }

    layui.use('laypage', function(){
        var laypage = layui.laypage;
        var total=${buycount};
        var currpage=1;
        laypage.render({
            elem: 'page'
            ,count:total  //数据总数，从服务端得到
            ,curr:${currpage}
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

</script>
</body>
</html>
