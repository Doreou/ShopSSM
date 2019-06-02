<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="cn.doreou.model.*" %><%--
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
    <link rel="stylesheet" href="/css/zzsc.css">
    <link rel="stylesheet" href="/css/goodsdis.css">
    <script src="/js/Total.js"></script>
    <style>
        body{
            color: black!important;
        }
    </style>
    <link href="/css/layui.css" rel="stylesheet">
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
    Object AllComment=session.getAttribute("AllComment");
    Object AllReply=session.getAttribute("AllReply");
    Object IdNameList=session.getAttribute("IdNameList");
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
                        <img alt="" src="<%=goodsinfo.get(0).getCover()%>" style="margin-left: -900px; margin-top: -7.5px;">
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
                    <a target="_blank" href="/User/getUserInfo?user_id=<%=goodsinfo.get(0).getUser_id()%>">
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
                <li class="number same">
                    <span class=""><span class="iconfont icon-youbian"></span>&nbsp;&nbsp;&nbsp;</span><span class="text">数量：
                    <%=goodsinfo.get(0).getNumber()%>
                </span>
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
                        <button type="button" class="btn btn-toolbar" onclick="GoBuy(<%=goodsinfo.get(0).getGoods_id()%>,<%=goodsinfo.get(0).getNumber()%>,<%=goodsinfo.get(0).getUser_id()%>)">购买</button>
                        <button type="button" class="btn btn-success" data-id="2666" onclick="saleFavor(<%=goodsinfo.get(0).getGoods_id()%>)">${isCollected}</button>
                        <button type="button" class="btn btn-warning" onclick="SaleReport(<%=goodsinfo.get(0).getGoods_id()%>)">举报</button>
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
                <textarea id="commoncontent" name="content"></textarea>
                <button id="commonbtn" class="commonbtn" onclick="saleReplyPost(<%=goodsinfo.get(0).getGoods_id()%>)">评论</button>
            </div>
            <%if(AllComment!=null){
                for(UserComment c:(List<UserComment>)AllComment){%>
            <ul class="reply-list" id="reply-list">
                <li class="list-item clearfix">
                    <div class="head">
                        <img src="<%=c.getIcon()%>">
                    </div>
                    <div class="text">
                        <div class="user clearfix">
                            <div class="username" style="color: #8c8c8c">
                                <%=c.getUsername()%><span class="reply">回复</span><%=goodsinfo.get(0).getUsername()%> :                               </div>
                            <div class="info">
                                <span class="reply-time" style="color: #8c8c8c">
                                    <%SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
                                String sdftime=simpleDateFormat.format(c.getTime());%><%=sdftime%></span>
                                <span id="span_reply" onclick="SaleReply(<%=c.getUser_id()%>,<%=c.getComment_id()%>)" class="reply">回复</span>
                            </div>
                        </div>
                        <p class="detail" style="padding-left: 50px;color: #8c8c8c; font-size: 25px">
                            <%=c.getContent()%>                           </p>
                    </div>
                </li>
                <% if(AllReply!=null){
                    for(Reply r:(List<Reply>) AllReply){
                        //查找对应回复
                        if(c.getComment_id()==r.getReplyto_id()){
                %>

                <div class="text" style="padding-left: 125px">
                    <div class="user clearfix">
                        <div class="username" style="color: #8c8c8c">
                            <%for(User user:(List<User>)IdNameList){
                                if(user.getUser_id().equals(r.getMy_uid())){%>
                            <label><%=user.getUsername()%></label>
                                <%break;}
                            }%><span class="reply">回复</span>
                            <%for(User user:(List<User>)IdNameList){
                                System.out.println(user);
                                System.out.println(r.getTo_uid());
                                if(user.getUser_id().equals(r.getTo_uid())){%>
                            <label><%=user.getUsername()%></label>
                                <%break;}
                            }%> :
                        </div>
                        <div class="info">
                                <span class="reply-time" style="color: #8c8c8c">
                                    <%--<%SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");--%>
                                        <%--String sdftime=simpleDateFormat.format(c.getTime());%><%=sdftime%></span>--%>
                            <%--<span id="span_reply" onclick="SaleReply(<%=c.getUser_id()%>,<%=c.getComment_id()%>)" class="reply">回复</span>--%>
                        </div>
                    </div>
                    <p class="detail" style="padding-left: 50px;color: #8c8c8c; font-size: 25px">
                        <%=r.getContent()%>                           </p>
                </div>

                <%}
                }
                }  %>
            </ul>
                <%}
            }%>
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
<script src="/js/GoodsInfo.js"></script>
<script>
    function SaleReply(userid,comment_id){
        //userid 被回复人的id comment_id 被回复的评论的ID
    $(document).on('click','.reply',function () {
        layer.open({
            type:0,
            content:'<input id="replyContent" name="replyContent" style="color:#8c8c8c;">' ,
            btn:['确定','关闭'],
            yes:function () {
                $.ajax({
                    type:'post',
                    url:'${pageContext.request.contextPath}/Reply/insertNewReply',
                    data:{"to_uid":userid,"replyContent":$('#replyContent').val(),"replyto_id":comment_id},
                    success:function (msg) {
                        if(msg=="回复成功") {
                            layer.msg(msg);
                            setTimeout(function () {
                                location.reload();
                            },3000);

                        }else{
                            layer.msg("您尚未登陆，请登陆后再试");
                        }
                    }

                })

            }
        })
    })
    }

    function saleReplyPost(goodsid) {
        var url="${pageContext.request.contextPath}/Comment/newComment";
        $.ajax({
            type:'post',
            url:url,
            data:{"id":goodsid,"content":$('#commoncontent').val()},
            success:function (msg) {
                if(msg=="回复成功") {
                    layer.msg(msg);
                    setTimeout(function () {
                        location.reload();
                    },3000);

                }else{
                    layer.msg("您尚未登陆，请登陆后再试");
                }
            }
        })
    }
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
    function GoBuy(goods_id,num,user_id) {
        $.ajax({
            type:'POST',
            url:'/Report/isLogin',
            success:function (msg) {
                if(msg!="请先登录"){
                    if(msg==user_id){
                        layer.msg("您不可以购买自己的物品");
                    }else {
                        layer.open({
                            type: 1,
                            title: '交易信息填写',
                            content: $('#popBuy'),
                            area: ['470px', '470px'],
                            btn: ['确定购买', '再想想'],
                            yes: function () {
                                if ($('#number').val() > num) {
                                    layer.msg("你买的太多啦！");
                                } else {
                                    $.ajax({
                                        type: 'POST',
                                        url: '/Order/Buy',
                                        data: $('#popform3').serialize() + "&goods_id=" + goods_id,
                                        success: function (msg) {
                                            layer.closeAll();
                                            layer.msg(msg);
                                        }
                                    })
                                }
                            }
                        })
                    }
                }else {
                    layer.msg(msg);
                }
            }
        })
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
        layui.use('laydate', function () {
            var laydate = layui.laydate;
            laydate.render({
                elem: '#time', //指定元素
                trigger: 'click',
                min: 0,//可选中的最早日期限制为今日
            });
        });

    })
</script>
<div class="layui-row" id="popReport" style="display:none;">
    <div class="layui-col-md10">
        <form id="popform2" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 445px;">
            <input style="display: none" value="" id="fileLocation" name="fileLocation">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px;">举报类型</label>
                <div class="layui-input-inline">
                    <select name="report_type" id="report_type">
                        <option value="">请选择类型</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px;color: black">举报详情</label>
                <div class="layui-input-block">
                    <textarea type="text" name="report_content" id="report_content" style="width: 200px" required lay-verify="required"
                              autocomplete="off"  placeholder="" class="layui-input"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px ;color: black">截图举证</label>
                <div class="layui-input-block">
                    <button type="button" class="layui-btn" id="uploadIcon">
                        <i class="layui-icon">&#xe67c;</i>上传图片
                    </button>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">预览</label>
                <div class="layui-input-block">
                    <img style="display: none" src="" id="priviewIcon">
                </div>
            </div>
        </form>
    </div>
</div>

<div class="layui-row" id="popBuy" style="display:none;">
    <div class="layui-col-md10">
        <form id="popform3" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 445px;">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px;">购买数量</label>
                <div class="layui-input-block">
                    <input type="text" name="number" id="number" style="width: 200px" required lay-verify="required"
                              autocomplete="off"  placeholder="" class="layui-input"></input>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px;">出价</label>
                <div class="layui-input-block">
                    <input type="text" name="price" id="price" style="width: 200px" required lay-verify="required"
                           autocomplete="off"  placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px;">交易地点</label>
                <div class="layui-input-block">
                    <input type="text" name="place" id="place" style="width: 200px" required lay-verify="required"
                           autocomplete="off"  placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px;">交易时间</label>
                <div class="layui-input-block">
                    <input type="text" name="time" id="time" style="width: 200px" required lay-verify="required"
                           autocomplete="off"  placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px;color: black">留言</label>
                <div class="layui-input-block">
                    <textarea type="text" name="content" id="content" style="width: 300px;height: 100px" required lay-verify="required"
                              autocomplete="off"  placeholder="" class="layui-input"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px ;color: black">支付方式</label>
                <div class="layui-input-inline">
                    <select id="pay_way" name="pay_way">
                        <option value="线下支付">线下支付</option>
                    </select>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>