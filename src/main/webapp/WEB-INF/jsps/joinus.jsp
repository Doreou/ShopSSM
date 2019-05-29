<%@ page import="cn.doreou.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>加入我们</title>
    <link href="/css/animate.css" rel="stylesheet" />
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/css/login.css" rel="stylesheet" />
    <link href="/css/newstyle.css" rel="stylesheet" />
    <link href="/css/custom.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="/css/joinus.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/layui.css" rel="stylesheet">
    <script src="/js/jquery.js"></script>
</head>
<body class="  pace-done">
<%List<Book> bookList = (List<Book>) session.getAttribute("AllSubject");
    Object userList = session.getAttribute("user");
    if (userList != null) {
        userList = (List<User>) userList;
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
                <li class="">
                    <a href="/Page/buy">求购</a>
                </li>
                <li class="current">
                    <a target="_blank" href="/Page/joinus">加入我们</a>
                </li>
                <li class="back" style="left: 204px; width: 92px;">
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
                                List<User> user=(List<User>) session.getAttribute("user");%>
                             src="<%=user.get(0).getIcon()%>"
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
            <a href="/Order/salegoods">发布二手</a>
        </div>
        <div class="qiugou">
            <a href="/Order/buygoods">发布求购</a>
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
    <div class="main">
        <div class="text-center">
            <div class="top"></div>
        </div>
        <div class="middle">
            <div class="box1 box">
                <i class="figure"></i>
                <h3>后端程序猿</h3>
                <p>我们希望您是个懂php，或Web App，或者Android，或者的IOS等等，要求不高。</p>
            </div>
            <div class="box2 box">
                <i class="figure"></i>
                <h3>前端攻城狮</h3>
                <p>喜欢千变万化的CSS3？变幻莫测的JQuery？令人赏心悦目的响应式布局？加入我们吧！</p>
            </div>
            <div class="box3 box">
                <i class="figure"></i>
                <h3>运营和推广</h3>
                <p>不写代码没关系，我们依然需要你，柚子校园的运营和推广，获得酬劳，贡献你的一份力量！</p>
            </div>
            <div class="box4 box">
                <i class="figure"></i>
                <h3>校园大使</h3>
                <p>疲于奔波劳累的社团？没关系，成为柚子校园的大使，你的学校，你做老大！</p>
            </div>
        </div>
        <div class="text-center">
            <div class="text_bg">
                <p class="description">
                    是否还记得最初的梦想？拥有自己的团队，在最美的青春里最自己最喜欢的事情，
                    一起拼搏， 一起向往未来，谁说90后不行？我们证明给他们看。
                    从敲下第一行代码开始，我们就一直在努力，目前柚子校园是一个成熟的团队
                    ，我们正在往外走，你是否也想做一些有意义的事情？加入我们吧！一起努力！
                    一起奋斗！
                </p>
            </div>
        </div>
        <div class="air"></div>
        <div class="bottom">
            <div class="text1 text"></div>
            <a href="/Page/apply">
                <div class="text2 text replay"></div>
            </a>
            <div class="text3 text"></div>
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
</script>
</body>
</html>
