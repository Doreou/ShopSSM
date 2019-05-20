<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/29
  Time: 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>消息中心</title>
    <link rel="stylesheet" href="/css/layui.css">
    <link rel="stylesheet" href="/css/layer.css">
</head>
<style>
    .layui-form-checkbox[lay-skin=primary]{
        height: 24px!important;
    }
</style>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">后台管理</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="/Page/admin_goodsinfo">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="/Page/admin_Permission">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="${admin.admin_icon}" class="layui-nav-img">
                    ${admin.admin_name}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退出登录</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-shrink="" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">网页设置</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/Page/admin_Subject">图书分类管理</a></dd>
                        <dd><a href="/Page/admin_Carousel">轮播图管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">用户信息列表</a></dd>
                        <dd><a href="/Page/admin_Report">被举报列表</a></dd>
                        <dd class="layui-nav-itemed"><a href="javascript:;">消息中心</a>
                            <dl class="layui-nav-child">
                                <dd><a href="/Page/admin_MessageToUser">&ensp;&ensp;向个人用户发送</a></dd>
                                <dd><a href="/Page/admin_MessageToAll">&ensp;&ensp;向全服发送</a></dd>
                                <dd><a href="/Page/admin_MessageCenter">&ensp;消息管理</a></dd>
                            </dl>
                        </dd>
                        <dd><a href="/Page/admin_Job">兼职申请列表</a></dd>
                        <dd><a href="/Page/admin_Cert">认证申请列表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">数据分析</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">用户数据</a></dd>
                        <dd><a href="javascript:;">图书数据</a></dd>
                        <dd><a href="javascript;">热度数据</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">管理员</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/Page/admin_AdmList">管理员列表</a></dd>
                        <dd class="layui-this"><a href="/Page/admin_Register">注册管理员</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header"><span>管理员</span>&nbsp;/&nbsp;<span style="color: #8c8c8c">注册管理员</span></div>
                        <div class="layui-card-body">

                            <div class="layui-form" wid100="">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">请输入ID</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="admin_id" id="admin_id" value="" placeholder="请输入ID" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">ID即登录ID，注册后ID无法更改</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">请输入密码</label>
                                    <div class="layui-input-inline">
                                        <input type="password" name="admin_pwd" id="admin_pwd" value="" placeholder="请输入密码" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请输入密码</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">请确认密码</label>
                                    <div class="layui-input-inline">
                                        <input type="password" name="admin_pwd_again" onblur="isSame()" id="admin_pwd_again" value="" placeholder="请再次输入密码" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux" id="msg">请再次输入密码</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">默认密码</label>
                                    <div class="layui-input-inline">
                                        <input type="checkbox" name="" title="使用默认密码" lay-skin="primary">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">勾选后密码设置为a+用户ID</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">真实姓名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" maxlength="140" placeholder="请输入真实姓名" name="admin_name" id="admin_name" value="" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请输入真实姓名</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">管理员级别</label>
                                    <div class="layui-input-inline">
                                        <select name="admin_type" id="admin_type">
                                            <option value="">请选择一个级别</option>
                                        </select>
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请输入真实姓名</div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit onclick="GoRegister()">确认注册</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © localhost:8080 - 校园二手书交易平台
    </div>
</div>
<script src="/js/jquery.js"></script>
<script src="/layui.js"></script>
<script src="/js/layer.js"></script>
<script src="/js/adm.js"></script>

</body>
</html>
