<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/5/7
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>用户信息管理</title>
    <link rel="stylesheet" href="/css/layui.css">
</head>

<style>
    .laytable-cell-1-0-6{
        height: 38px;
    }
    .laytable-cell-1-0-0{
        height: 38px;
    }
</style>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">后台管理</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/Page/admin_goodsinfo">商品管理</a></li>
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
                    <dd><a href="/Page/admin_info">基本资料</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="/Page/adminlogin">退出登录</a></li>
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
                        <dd class="layui-this"><a href="javascript:;">用户信息列表</a></dd>
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
                        <dd><a href="/Page/userData">用户数据</a></dd>
                        <dd><a href="/Page/bookData">图书数据</a></dd>
                        <dd><a href="/Page/hotData">热度数据</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">管理员</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/Page/admin_AdmList">管理员列表</a></dd>
                        <dd><a href="/Page/admin_Register">注册管理员</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>



    <div class="layui-body">
        <div class="layui-form" style="padding: 0px; margin-top: 30px;">
            <div class="layui-form-item" style="margin-bottom: 10px!important;">
                <label class="layui-form-label">ID</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline" style="margin-left: 5px;">
                        <input type="text" name="SearchID" id="SearchID" required style="width: 200px;" placeholder="请输入ID" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <label class="layui-form-label">性别</label>
                <div class="layui-input-inline">
                    <select name="SearchSex" id="SearchSex">
                        <option value="">-请选择-</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <label class="layui-form-label">认证状态</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline" style="margin-left: 5px;">
                        <select name="SearchCert" id="SearchCert">
                            <option value="">-请选择-</option>
                            <option value="1">已认证</option>
                            <option value="0">未认证</option>
                        </select>
                    </div>
                </div>
                <button class="layui-btn" style="margin-left: 20px" data-type="reload" id="searchBtn" >搜索</button>
            </div>
        </div>
        <!-- 内容主体区域 -->
        <table id="demo" lay-filter="test"></table>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © localhost:8080 - 校园二手书交易平台
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">发送消息</a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="detail">取消认证</a>
</script>
<script src="/js/jquery.js"></script>
<script src="/layui.js"></script>
<script src="/js/userinfo.js"></script>
<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:19891017;width:100%;height:100%;display:none;">
    <div id="innerdiv" style="position:absolute;">
        <img id="big" style="border:5px solid #fff;" src="" />
    </div>
</div>
</body>
</html>
