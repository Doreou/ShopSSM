<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/2/17
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>欢迎登陆</title>
    <link href="/css/animate.css" rel="stylesheet"/>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/newstyle.css" rel="stylesheet"/>
    <link href="/css/common.css" rel="stylesheet"/>
    <link href="/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="/css/login.css" rel="stylesheet"/>
    <link href="/css/custom.css" rel="stylesheet">
    <link href="/css/layer.css" rel="stylesheet">
    <script src="/js/jquery.js"></script>
    <script src="/js/layer.js"></script>
</head>
<body class="signin pace-done">
<div class="pace  pace-inactive">
    <div class="pace-progress" data-progress-text="100%" data-progress="99" style="width: 100%;">
        <div class="pace-progress-inner"></div>
    </div>
    <div class="pace-activity"></div>
</div>
<div class="signinpanel">
    <div class="row">
        <div class="col-sm-7">
            <div class="signin-info">
                <div class="logopanel m-b">
                    <h1>大连大学</h1>
                    <h2>　　　二手图书交易平台</h2>
                </div>
                <div class="m-b"></div>
                <ul class="m-b">
                    <div class="erweima">
                        <img src="/images/1550323940.jpg">
                        <p class="text">关注公众号,查看更多校园信息</p>
                    </div>
                </ul>
            </div>
        </div>
        <div class="col-sm-5">
            <form method="post" id="js-form" action="${pageContext.request.contextPath}/User/login">
                <h4 class="no-margins">请登录</h4>
                <input type="text" name="userid" id="userid" class="form-control uname" placeholder="学号">
                <input type="password" name="password" id="password" class="form-control pword m-b" placeholder="密码">
                <div class="verifycode-box">
                    <input type="text" name="passcode" id="passcode" class="form-control pword m-b" placeholder="验证码">
                    <img id="verifycode" alt="点击更换" class="passcode" src="${pageContext.request.contextPath}/User/getVerifyCode" onclick="changeImage()">
                </div>
                <div class="checkbox i-checks" style="text-align: center;">
                    <a class="" href="/other/foundstep1">找回密码</a>
                    <a href="/Page/register">注册账号</a>
                </div>
                <a id="js-submit" class="btn btn-success btn-block submit_btn" onclick="btn()">登录</a>
            </form>
        </div>
    </div>
    <div class="signup-footer">
        <div class="pull-left" style="color: white;">
            版权所有 © All Rights Reserved            </div>
    </div>
</div>
<script src="/js/InputCheck.js"></script>
<script>
    $(document).ready(function(){
        var errmsg="";
        errmsg="<%=session.getAttribute("errmsg")%>";
        if(errmsg!=""&&errmsg!="null"){
            layer.msg(errmsg.toString());
            //提示后重置errmsg
            <%session.setAttribute("errmsg","");%>
        }

    })
    function btn() {
        if(check()){
            $('#js-form').action="${pageContext.request.contextPath}/User/login";
            $('#js-form').submit();
        }
    }
    function changeImage(){
        $('#verifycode').attr('src', '${pageContext.request.contextPath}/User/getVerifyCode?t='+(new Date()).valueOf());
    }
</script>
</body>
</html>
