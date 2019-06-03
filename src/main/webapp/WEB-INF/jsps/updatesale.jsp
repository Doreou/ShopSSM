<%@ page import="cn.doreou.model.Book" %>
<%@ page import="cn.doreou.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.GoodAndUser" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/3
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>校园二手</title>
    <link href="/css/animate.css" rel="stylesheet"/>
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="/css/login.css" rel="stylesheet"/>
    <link href="/css/custom.css" rel="stylesheet">
    <link href="/css/iconfont.css" rel="stylesheet">
    <link href="/css/swiper-3.4.2.min.css" rel="stylesheet">
    <link href="/css/salegoods.css" rel="stylesheet">
    <link href="/css/chosen.css" rel="stylesheet">
    <link href="/css/salestyle.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="/css/cropper.min.css" />
    <link href="/css/common.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/css/ImgCropping.css">
    <link href="/css/layer.css" rel="stylesheet">
    <script src="/js/jquery.js"></script>
    <script src="/layui.js"></script>
    <link href="/css/layui.css" rel="stylesheet">
    <script src="/js/cropper.min.js"></script>
    <script src="/js/layer.js"></script>
    <script src="/js/Total.js"></script>
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
    List<User> userList =(List<User>) session.getAttribute("user");
    List<GoodAndUser> nowinfo=(List<GoodAndUser>)session.getAttribute("nowinfo");
%>
<div class="pace  pace-inactive">
    <div class="pace-progress" data-progress-text="100%" data-progress="99" style="width: 100%;">
        <div class="pace-progress-inner"></div>
    </div>
    <div class="pace-activity"></div>
</div>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#" style="color: #0e9aef">
            <img alt="Brand" src="/images/login_45x45.png">
        </a>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="js-nav-slide">
                <li>
                    <a href="/">首页
                        <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="current">
                    <a href="/Page/sale">二手</a>
                </li>
                <li class="">
                    <a href="/Page/buy">求购</a>
                </li>
                <li class="">
                    <a target="_blank" href="/Page/joinus">加入我们</a>
                </li>
                <li class="back" style="left: 66px; width: 66px;">
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
                    <input name="keyword" type="text" id="serachWord" style="color: black" class="form-control search-field"
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
        <span class="" id="js-numberrock"></span>
    </div>
    <div class="erweima">
        <a class="qq" href="tencent://message/?uin=1250305708&amp;Site=QQ交谈&amp;Menu=yes" target="_blank"></a>
        <a href="http://weibo.com" class="wb"></a>
    </div>
</div>

<div class="main">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>发布二手信息</h5>
        </div>
        <div class="ibox-content">
            <form action="" class="form-horizontal m-t" id="saleForm" method="post"
                  novalidate="novalidate">
                <div class="form-group">
                    <label class="col-sm-3 control-label">标题：</label>
                    <div class="col-sm-8">
                        <input id="title" name="title" class="required form-control" type="text" placeholder="请输入标题"
                               aria-required="true" value="<%=nowinfo.get(0).getGoods_title()%>">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">详情：</label>
                    <div class="col-sm-8">
                        <input id="detail" name="detail" placeholder="请输入详情" class="form-control" type="text"
                               aria-required="true" aria-invalid="false" value="<%=nowinfo.get(0).getIntroduce()%>"></input>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">封面：
                        <!-- <span class="badge badge-warning " id="tip1">？</span> --></label>
                    <div class="col-sm-8">
                        <div data-toggle="modal" id="modal1" data-target="#myModal1"
                             class="modal-btn btn btn-default btn-block">点击修改
                        </div>
                    </div>

                    <div class="str" <%if(nowinfo.get(0).getCover()!=null||session.getAttribute("newcode")!=null){%>
                         style="text-align: center"<%}
                    else {%>
                         style="display: none;"
                            <%}%>>
                        <img id="finalImg" <%if(session.getAttribute("newcode")!=null){%>
                             src="<%=session.getAttribute("newcode")%>"
                        <%}else{%>
                                src="<%=nowinfo.get(0).getCover()%>"
                        <%}%>  width="20%">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">数量：</label>
                    <div class="col-sm-8">
                        <input id="count" name="count" placeholder="请输入您拥有的商品数量" class="form-control" type="text"
                               aria-required="true" aria-invalid="false" value="<%=nowinfo.get(0).getNumber()%>">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">商品原价：</label>
                    <div class="pre-price input-group m-b col-sm-8"><span class="input-group-addon">¥</span>
                        <input id="pricost" name="pricost" type="text" class="form-control" value="<%=nowinfo.get(0).getPri_cost()%>">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">分类：</label>
                    <div class="col-sm-8">
                        <select id="status" name="status" data-placeholder="选择磨损程度..." class="chosen-select form-control"
                                style="width: 100%;" tabindex="-1">
                            <option value="全新">全新</option>
                            <option value="九五新以上">九五新以上</option>
                            <option value="八五新-九五新">八五新-九五新</option>
                            <option value="五成新-八五新">五成新-八五新</option>
                            <option value="五成新以下">五成新以下</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">预期价格：</label>
                    <div class="pre-price input-group m-b col-sm-8"><span class="input-group-addon">¥</span>
                        <input id="price" name="price" type="text" class="form-control" value="<%=nowinfo.get(0).getExpt_price()%>">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">交易地点：</label>
                    <div class="col-sm-8">
                        <input id="address" name="address" class="form-control" placeholder="宿舍、教学楼、食堂等" type="text"
                               aria-required="true" aria-invalid="true" value="宿舍">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">分类：</label>
                    <div class="col-sm-8">
                        <select id="type" name="type" data-placeholder="选择分类..." class="chosen-select form-control"
                                style="width: 100%;" tabindex="-1">
                            <% for(Book b:bookList){ %>
                            <option value="<%=b.getSubject()%>"><%=b.getSubject()%></option>
                            <%}%>
                        </select>
                    </div>
                </div>
                <div class="form-group" style="text-align: center">
                    <label class="control-label">Tips:当您发布商品后系统将向所有人展示您的预留信息，请注意隐私安全哦~</label>
                </div>
                <%--<div class="form-group">--%>
                <%--<label class="col-sm-3 control-label">手机：</label>--%>
                <%--<div class="col-sm-8">--%>
                <%--<input id="" name="tel" class="form-control" placeholder="宿舍、教学楼、食堂等" type="text" aria-required="true" aria-invalid="true">--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                <%--<label class="col-sm-3 control-label">QQ：</label>--%>
                <%--<div class="col-sm-8">--%>
                <%--<input id="username" name="qq" class="form-control" placeholder="宿舍、教学楼、食堂等" type="text" aria-required="true" aria-invalid="true">--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                <%--<label class="col-sm-3 control-label">微信：</label>--%>
                <%--<div class="col-sm-8">--%>
                <%--<input id="username" name="weixin" class="form-control" placeholder="宿舍、教学楼、食堂等" type="text" aria-required="true" aria-invalid="true">--%>
                <%--</div>--%>
                <%--</div>--%>
                <div class="form-group">
                    <div class="col-sm-8 col-sm-offset-3">
                        <button class="btn btn-primary btn-block" onclick="return adddata()">提交</button>
                    </div>
                </div>
        </div>
    </div>
    <div style="display: none" class="tailoring-container">
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
            <a href="/index/index" class="fLogo"
               style="background: url(../../images/login.jpg) no-repeat;">大连大学二手图书交易平台</a>
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
    $(document).ready(function () {
        var errmsg="";
        errmsg="<%=session.getAttribute("errmsg")%>";
        if(errmsg!=""&&errmsg!="null"){
            layer.msg(errmsg.toString());
            //提示后重置errmsg
            <%session.setAttribute("errmsg","");%>
        }

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
    function adddata() {
        if(<%=nowinfo.get(0).getCover()!=null%>||<%=session.getAttribute("newcode")!=null%>){
            $('#saleForm').attr('action','${pageContext.request.contextPath}/Order/refresh?goods_id=<%=nowinfo.get(0).getGoods_id()%>');
            $('#saleForm').submit();
        }else{
            layer.msg("你至少需要上传一张照片哦");
            return false;
        }
    }

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
                url:'${pageContext.request.contextPath}/Order/update_upload',
                data:$('#saleForm').serialize(),
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