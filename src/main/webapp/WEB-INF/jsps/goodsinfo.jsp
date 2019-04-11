<%@ page import="cn.doreou.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.User" %>
<%@ page import="cn.doreou.model.GoodAndUser" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/3/12
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>校园求购</title>
    <link href="/css/animate.css" rel="stylesheet"/>
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/newstyle.css" rel="stylesheet"/>
    <link href="/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="/css/login.css" rel="stylesheet"/>
    <link href="/css/custom.css" rel="stylesheet">
    <link href="/css/iconfont.css" rel="stylesheet">
    <link href="/css/swiper-3.4.2.min.css" rel="stylesheet">
    <link href="/css/buy.css" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet"/>
    <link href="/css/showsale.css" rel="stylesheet">
    <script src="/js/jquery.js"></script>
    <script src="/layui.js"></script>
    <link href="/css/layui.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/zzsc.css">
    <link rel="stylesheet" href="/css/goodsdis.css">
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
    if (userList != null) {
        userList = (List<User>) userList;
    }
    Object goodslist = session.getAttribute("AllBuyGoodsList");
    List<GoodAndUser> goodsinfo = (List<GoodAndUser>) session.getAttribute("goodsinfo");
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

            <form class="navbar-form navbar-right search-box" onsubmit="return false;">
                <div class="form-group pull-left">
                    <input name="keyword" type="text" id="serachWord" class="form-control search-field"
                           placeholder="搜索一下..."></div>
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
<div class="main">
    <div class="detail clearfix">
        <div class="picture">
            <div class="con-FangDa" id="fangdajing">
                <div class="con-fangDaIMg">
                    <!-- 正常显示的图片-->
                    <img alt="" src="<%=goodsinfo.get(0).getCover()%>">
                    <!-- 滑块-->
                    <div class="magnifyingBegin" style="display: none; left: 300px; top: 2.5px;"></div>
                    <!-- 放大镜显示的图片 -->
                    <div class="magnifyingShow" style="display: none;">
                        <img alt="我爱你我爱你-柚子校园" src="<%=goodsinfo.get(0).getCover()%>" style="margin-left: -900px; margin-top: -7.5px;">
                    </div>
                </div>
                <ul class="con-FangDa-ImgList">
                    <!-- 图片显示列表 -->
                    <li class="active"><img src="<%=goodsinfo.get(0).getCover()%>" data-bigimg="<%=goodsinfo.get(0).getCover()%>"></li>                                                                                                          </ul>
            </div>
        </div>
        <div class="info">
            <ul>
                <li class="title">
                    <%=goodsinfo.get(0).getGoods_title()%>
                </li>
                <li class="price">
                    <span class="howmuch"><%=goodsinfo.get(0).getExpt_price()%></span>
                    &nbsp;&nbsp;&nbsp;                 </li>
                <li class="user same">
                    <a target="_blank" href="/salenow/3708">
                            <span class="name">
                                <span class="iconfont icon-yonghu"></span>&nbsp;&nbsp;&nbsp;
                                <span class="">
                                    <%=goodsinfo.get(0).getUsername()%>                                                                        </span><span class="seehim iconfontitems">
                                </span>(去看他)
                            </span>
                    </a>
                </li>
                <li class="contact1 same">
                    <span class="qq"><span class="iconfont icon-QQ"></span>&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="text">
                        <%if (goodsinfo.get(0).getQq() != null) {%>
                                        <%=goodsinfo.get(0).getQq()%>
                                    <%} else {%>
                                        ta还没有留下QQ哦~
                                    <%}%>                                      </span>
                </li>
                <li class="contact2 same">
                    <span class="tel"><span class="iconfont icon-shouji"></span>&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="text">
                            <%if (goodsinfo.get(0).getPhone() != null) {%>
                                        <%=goodsinfo.get(0).getPhone()%>
                                    <%} else {%>
                                        ta还没有留下手机哦~
                                    <%}%>                                 </span>
                </li>
                <li class="school same">
                    <span class=""><span class="iconfont icon-dizhi"></span>&nbsp;&nbsp;&nbsp;</span><span class="text">大连大学</span>
                </li>
                <li class="address same">
                    <span class=""><span class="iconfont icon-youbian"></span>&nbsp;&nbsp;&nbsp;</span><span class="text">120000</span>
                </li>
                <li class="renzheng same">
                    <span class=""><span class="iconfont icon-renzheng"></span>&nbsp;&nbsp;&nbsp;</span><span class="text">
                        <%if (goodsinfo.get(0).getMember_status() == 0) {%>
                                                未认证
                                            <%} else {%>
                                                已认证
                                            <%}%>                        </span>
                </li>
                <li class="time same">
                    <span class=""><span class="iconfont icon-riqi"></span>&nbsp;&nbsp;&nbsp;</span><span class="text"><%
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String time = sdf.format(goodsinfo.get(0).getTime());
                %><%=time%></span>
                </li>
                <li class="weixin same">
                    <span class="weixin"><span class="iconfont icon-iconfontweixin"></span>&nbsp;&nbsp;&nbsp;</span><span class="text">
                            <%if (goodsinfo.get(0).getWechat() != null) {%>
                                        <%=goodsinfo.get(0).getWechat()%>
                                    <%} else {%>
                                        ta还没有留下微信哦~
                                    <%}%>                        </span>
                </li>
                <li>
                    <div style="margin-top: 5px;height:32px;line-height: 32px;" class="jiathis_style_32x32">
                        <span style="display: inline-block;float: left;font-size: 14px;color: #666;">分享到：</span>
                        <a target="_blank" class="jiathis_button_qzone" title="分享到QQ空间"></a>
                        <a target="_blank" class="jiathis_button_tsina" title="分享到新浪微博"></a>
                        <a target="_blank" class="jiathis_button_cqq" title="分享到腾讯QQ"></a>
                        <a target="_blank" class="jiathis_button_weixin" title="分享到微信"></a>
                        <a target="_blank" class="jiathis_button_renren" title="分享到人人网"></a>
                        <a target="_blank" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" href="http://www.jiathis.com/share" id="goods_button_more" style=""></a>
                        <button type="button" class="btn btn-success" data-id="2666" onclick="saleFavor(<%=goodsinfo.get(0).getGoods_id()%>)">${isCollected}</button>
                        <button type="button" class="btn btn-warning" onclick="saleReport(2666)">举报</button>
                    </div>
                    <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                </li>
            </ul>
        </div>
    </div>
    <div class="ershou-desc">
        <span class="yinhao"></span>
        <div class="desc clearfix">
            <a target="_blank">
                <img src="<%=goodsinfo.get(0).getIcon()%>" id="user_ph">
            </a>
            <span id="user_cmt">哈哈哈哈哈哈哈哈哈哈哈哈<br>(联系我的时候，请说明是在...看见的噢！)</span>
        </div>
    </div>
    <div class="commonbox">
        <div class="commontip">评论</div>
        <div class="box">
            <ul class="reply-list" id="reply-list">
            </ul>
            <p id="reply-to-tips">Doreou 回复 lyc ：</p>
            <div class="common">

                <img id="replyer" <%if(session.getAttribute("user")==null){%>src="/images/default3.png"
                    <%}else {
                                List<User> user=(List<User>) session.getAttribute("user");
                                if(user.get(0).getIcon()!=null){%>
                     src="<%=user.get(0).getIcon()%>"
                    <%}else {%>
                     src="/images/pleaselogin.png"
                    <%}
                                    %>

                    <%}%>>
                <textarea id="commoncontent"></textarea>
                <button id="commonbtn" class="commonbtn" my-name="Doreou" goodsid-id="2666" to-name="lyc" onclick="saleReplyPost(this)" to-id="3708" pid="0">评论</button>
            </div>
        </div>
    </div>


    <%--推荐列表--%>

    <%--<div class="item-list">--%>
        <%--<span class="tuijian">推荐</span>--%>
        <%--<ul class="goodsbox clearfix">--%>
            <%--<li class="items">--%>
                <%--<div class="picture">--%>
                    <%--<a target="_blank" href="/sale/54"><img src="/Uploads/salebuy/2016-01-13/thumb_5695e9ab05342.jpg" alt="#"> </a>--%>
                <%--</div>--%>
                <%--<div class="detail">--%>
                    <%--<div class="pricehot clearfix">--%>
                        <%--<span class="price">￥&nbsp;<span>1380</span></span>--%>
                        <%--<span class="hot">点击数&nbsp;<span>1371</span></span>--%>
                    <%--</div>--%>
                    <%--<a target="_blank" href="/sale/54" class="title">--%>
                        <%--低价转油车一辆                            </a>--%>
                    <%--<div class="some clearfix">--%>
                        <%--<span class="school">桂林电子科技大学</span>--%>
                        <%--<span class="renzheng">--%>
                                 <%--未认证                            </span>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li><li class="items">--%>
            <%--<div class="picture">--%>
                <%--<a target="_blank" href="/sale/802"><img src="/Uploads/salebuy/2016-06-12/575cf8f1bb36c.jpg" alt="#"> </a>--%>
            <%--</div>--%>
            <%--<div class="detail">--%>
                <%--<div class="pricehot clearfix">--%>
                    <%--<span class="price">￥&nbsp;<span>20</span></span>--%>
                    <%--<span class="hot">点击数&nbsp;<span>1305</span></span>--%>
                <%--</div>--%>
                <%--<a target="_blank" href="/sale/802" class="title">--%>
                    <%--烧水的壶                            </a>--%>
                <%--<div class="some clearfix">--%>
                    <%--<span class="school">华东交通大学</span>--%>
                    <%--<span class="renzheng">--%>
                                 <%--未认证                            </span>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</li><li class="items">--%>
            <%--<div class="picture">--%>
                <%--<a target="_blank" href="/sale/443"><img src="/Uploads/salebuy/2016-05-09/57305282df5f9.jpg" alt="#"> </a>--%>
            <%--</div>--%>
            <%--<div class="detail">--%>
                <%--<div class="pricehot clearfix">--%>
                    <%--<span class="price">￥&nbsp;<span>2799</span></span>--%>
                    <%--<span class="hot">点击数&nbsp;<span>1277</span></span>--%>
                <%--</div>--%>
                <%--<a target="_blank" href="/sale/443" class="title">--%>
                    <%--r9购机，赠送vr眼镜                            </a>--%>
                <%--<div class="some clearfix">--%>
                    <%--<span class="school">桂林理工大学</span>--%>
                    <%--<span class="renzheng">--%>
                                 <%--未认证                            </span>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</li><li class="items">--%>
            <%--<div class="picture">--%>
                <%--<a target="_blank" href="/sale/760"><img src="/Uploads/salebuy/2016-06-11/575b8427163a6.jpg" alt="#"> </a>--%>
            <%--</div>--%>
            <%--<div class="detail">--%>
                <%--<div class="pricehot clearfix">--%>
                    <%--<span class="price">￥&nbsp;<span>80</span></span>--%>
                    <%--<span class="hot">点击数&nbsp;<span>1140</span></span>--%>
                <%--</div>--%>
                <%--<a target="_blank" href="/sale/760" class="title">--%>
                    <%--哑铃                            </a>--%>
                <%--<div class="some clearfix">--%>
                    <%--<span class="school">华东交通大学</span>--%>
                    <%--<span class="renzheng">--%>
                                 <%--未认证                            </span>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</li><li class="items">--%>
            <%--<div class="picture">--%>
                <%--<a target="_blank" href="/sale/2626"><img src="/Uploads/salebuy/2019-01-06/5c319607312f8.png" alt="#"> </a>--%>
            <%--</div>--%>
            <%--<div class="detail">--%>
                <%--<div class="pricehot clearfix">--%>
                    <%--<span class="price">￥&nbsp;<span>5</span></span>--%>
                    <%--<span class="hot">点击数&nbsp;<span>222</span></span>--%>
                <%--</div>--%>
                <%--<a target="_blank" href="/sale/2626" class="title">--%>
                    <%--faefawfea                            </a>--%>
                <%--<div class="some clearfix">--%>
                    <%--<span class="school">桂林电子科技大学</span>--%>
                    <%--<span class="renzheng">--%>
                                 <%--未认证                            </span>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</li>            </ul>--%>
    <%--</div>--%>
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
    function saleFavor(id){
        var text="${isCollected}";
        if(text=="收藏"){
            var url="${pageContext.request.contextPath}/User/collect?id="+id;
            $.ajax({
                type:'post',
                url:url,
                success:function (msg) {
                    layer.msg(msg);
                }
            })
        }else{
            layer.msg("您已收藏过");
        }
    }

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
            , form = layui.form;

        //常规轮播
        carousel.render({
            elem: '#test1'
            , arrow: 'always'
        });
    });
</script>
</body>
</html>