<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/24
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>校园二手书交易平台后台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/css/layui.css">
    <link rel="stylesheet" href="/css/layer.css">
    <link rel="stylesheet" href="/css/adminlogin.css">
    <link rel="stylesheet" href="/css/admin.css">
    <style>
        input[type=date]::-webkit-inner-spin-button { visibility: hidden; }
    </style>
</head>
<body>
<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>校园二手书交易平台</h2>
            <p>后台管理系统</p>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username"></label>
                <input type="text" name="loginName" id="loginName" lay-verify="required" placeholder="用户名" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"></label>
                <input type="password" name="passWord" id="passWord" lay-verify="required" placeholder="密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"></label>
                        <input type="text" name="vercode" id="vercode" lay-verify="required" placeholder="图形验证码" class="layui-input">
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <img style="height: 38px;width: 130px;" src="${pageContext.request.contextPath}/User/getVerifyCode">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <button id="btn" class="layui-btn layui-btn-fluid" lay-submit lay-filter="login">登 入</button>
            </div>
            <div class="layui-trans layadmin-user-login-footer">

                <p>© 2019 <a href="http://www.layui.com/" target="_blank">校园二手书交易平台</a></p>
                <p>
                    <span><a href="/Page/index" target="_blank">前往官网</a></span>
                </p>
            </div>
        </div>
    </div>

</div>
<script src="/js/jquery.js"></script>
<script src="/js/layer.js"></script>
<script src="/layui.js"></script>
<script src="/js/admin_login.js"></script>
</body>
</html>
