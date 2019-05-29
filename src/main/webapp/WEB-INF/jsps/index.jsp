<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/2/16
  Time: 12:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="../../css/layui.css" type="text/css" rel="stylesheet">
<link href="../../css/buy.css" rel="stylesheet">
<link href="../../css/pintuer.css" rel="stylesheet">
<link href="../../css/footer.css" rel="stylesheet">
<script src="../../layui.js"></script>
<link href="../../font">
<html>
<head>
    <title>大连大学二手交易平台</title>
</head>
<body>
<div id="HomePage">
    <section class="top" style="background: url(../../images/5.jpg);">
        <div class="text-box">
            <h3 class="title">欢迎进入大连大学</h3>
            <p class="desc">— 二手图书交易平台 —</p>
        </div>
        <div class="top-item-btn fadein-bottom ">
            <div class="content">
                <div class="row row-bottom-padded-lg">
                    <div style="background-image: url(../../images/1.jpg);" class="fh5co-block to-animate fadeInRight animated">
                        <div class="overlay-darker"></div>
                        <div class="overlay"></div>
                        <div class="fh5co-text">
                            <i class="fh5co-intro-icon icon-refresh"></i>
                            <h2>校园二手</h2>
                            <p>带不走的东西，丢不掉的记忆
                            </p>
                            <p>
                                让小柚子，帮它找到新的主人
                            </p>
                            <p><a class="btn btn-primary" href="/Page/sale">校园二手</a></p>
                        </div>
                    </div>
                    <div style="background-image: url(../../images/2.jpg);" class="fh5co-block to-animate fadeInRight animated">
                        <div class="overlay-darker"></div>
                        <div class="overlay"></div>
                        <div class="fh5co-text">
                            <i class="fh5co-intro-icon icon-retweet"></i>
                            <h2>校园求购</h2>
                            <p>众里寻它，蓦然回首</p>
                            <p>原来它就在这里</p>
                            <p><a class="btn btn-primary" href="/Page/buy">校园求购</a></p>
                        </div>
                    </div>
                    <div style="background-image: url(../../images/3.jpg);" class="fh5co-block to-animate fadeInRight animated">
                        <div class="overlay-darker"></div>
                        <div class="overlay"></div>
                        <div class="fh5co-text">
                            <i class="fh5co-intro-icon icon-users"></i>
                            <h2>加入我们</h2>
                            <p>年华已去，梦想犹在</p>
                            <p>加入我们，为了不一样的青春</p>
                            <p><a class="btn btn-primary" href="/Page/joinus">加入我们</a></p>
                        </div>
                    </div>
                    <div style="clear:both;"></div>
                </div>
            </div>
        </div>
    </section>
    <section class="desc-box">
        <div class="container w3l">
            <h3>专注校园二手</h3>
            <div class="wthree_w3l_grids line">
                <div data-wow-delay=".5s" class="fadein-left x6 wthree_w3l_grid wow" style="visibility: visible;">
                    <div class="x4 col-xs-4 wthree_w3l_grid-left">
                        <div class="wthree_w3l_grid-left1">
                            <span aria-hidden="true" class=" icon-shield glyphicon glyphicon-cog"></span>
                        </div>
                    </div>
                    <div class="x8 col-xs-8 wthree_w3l_grid-right">
                        <h4>安全</h4>
                        <p>当面沟通，信息对称，确保安全。</p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div data-wow-delay=".5s" class="fadein-right x6 col-md-6 wthree_w3l_grid wow fadeInRight animated animated animated" style="visibility: visible;">
                    <div class="x4 col-xs-4 wthree_w3l_grid-left">
                        <div class="wthree_w3l_grid-left1">
                            <span aria-hidden="true" class="icon-send-o glyphicon glyphicon-scissors"></span>
                        </div>
                    </div>
                    <div class="x8 col-xs-8 wthree_w3l_grid-right">
                        <h4>快捷</h4>
                        <p>同校交易，省时省力，不用等待。</p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="wthree_w3l_grids line">
                <div data-wow-delay=".5s" class="fadein-left x6 col-md-6 wthree_w3l_grid wow fadeInLeft animated animated animated" style="visibility: visible;">
                    <div class="x4 col-xs-4 wthree_w3l_grid-left">
                        <div class="wthree_w3l_grid-left1">
                            <span aria-hidden="true" class="icon-random glyphicon glyphicon-wrench"></span>
                        </div>
                    </div>
                    <div class="x8 col-xs-8 wthree_w3l_grid-right">
                        <h4>简单</h4>
                        <p>简单注册，简洁发布，一键售购。</p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div data-wow-delay=".5s" class="fadein-right x6 col-md-6 wthree_w3l_grid wow fadeInRight animated animated animated" style="visibility: visible;">
                    <div class="x4 col-xs-4 wthree_w3l_grid-left">
                        <div class="wthree_w3l_grid-left1">
                            <span aria-hidden="true" class="icon-recycle glyphicon glyphicon-oil"></span>
                        </div>
                    </div>
                    <div class="x8 col-xs-8 wthree_w3l_grid-right">
                        <h4>方便</h4>
                        <p>一键直达，分类明晰，快速搜索。</p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
    </section>
    <section class="f-link">
        <div class="f-title">
            友情链接
        </div>
        <div class="f-box">
            <ul>
                <li>
                    <a target="_blank" href="http://tieba.baidu.com/f?ie=utf-8&kw=%E5%A4%A7%E8%BF%9E%E5%A4%A7%E5%AD%A6&fr=search">
                        大连大学吧
                    </a>
                </li>
                <li>
                    <a target="_blank" href="http://jwc1.dlu.edu.cn/">
                        大连大学教务处
                    </a>
                </li>
            </ul>
        </div>
    </section>
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
    <p class="copyright">版权所有 © All Rights Reserved   <a style="color: #999999" href="/Page/adminlogin">后台管理</a>
    </p>
</div>
</div>
</body>
</html>
