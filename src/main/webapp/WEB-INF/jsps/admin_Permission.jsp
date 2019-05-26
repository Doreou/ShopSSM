<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/5/7
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>图书分类管理</title>
    <link rel="stylesheet" href="/css/layui.css">
</head>
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
                    <dd class="layui-this"><a href="/Page/admin_Permission">授权管理</a></dd>
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
                        <dd><a href="/Page/admin_userinfo">用户信息列表</a></dd>
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
        <!-- 内容主体区域 -->
        <table id="demo" lay-filter="test"></table>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © localhost:8080 - 校园二手书交易平台
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">更新权限</a>
</script>
<script src="/js/jquery.js"></script>
<script src="/layui.js"></script>
<script src="/js/Permission.js"></script>
<div class="layui-row" id="popUpdate" style="display:none;">
    <div class="layui-col-md10">
        <form id="popform" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 445px;">
            <input id="id" name="id" style="display: none;" value="">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">类型</label>
                <div class="layui-input-block">
                    <input type="text" name="type" id="type" style="width: 200px" required
                           lay-verify="required" autocomplete="off" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">用户管理权</label>
                <div class="layui-input-block" >
                    <input type="radio" lay-filter="user" name="user" value="开启" title="开启">
                    <input type="radio" lay-filter="user" name="user" value="关闭" title="关闭">
                    <input id="userstatus" name="userstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">轮播图管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="carousel" name="carousel" value="开启" title="开启">
                    <input type="radio" lay-filter="carousel" name="carousel" value="关闭" title="关闭">
                    <input id="carouselstatus" name="carouselstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">科目管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="subject" name="subject" value="开启" title="开启">
                    <input type="radio" lay-filter="subject" name="subject" value="关闭" title="关闭">
                    <input id="subjectstatus" name="subjectstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">消息管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="message"  name="message" value="开启" title="开启">
                    <input type="radio" lay-filter="message" name="message" value="关闭" title="关闭">
                    <input id="messagestatus" name="messagestatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">发送消息权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="sendmsg" name="sendmsg" value="开启" title="开启">
                    <input type="radio" lay-filter="sendmsg" name="sendmsg" value="关闭" title="关闭">
                    <input id="sendmsgstatus" name="sendmsgstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">认证权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="cert"  name="cert" value="开启" title="开启">
                    <input type="radio" lay-filter="cert" name="cert" value="关闭" title="关闭">
                    <input id="certstatus" name="certstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">兼职管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="job" name="job" value="开启" title="开启">
                    <input type="radio" lay-filter="job" name="job" value="关闭" title="关闭">
                    <input id="jobstatus" name="jobstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">管理员管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="adm" name="adm" value="开启" title="开启">
                    <input type="radio" lay-filter="adm" name="adm" value="关闭" title="关闭">
                    <input id="admstatus" name="admstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">举报管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="report" name="report" value="开启" title="开启">
                    <input type="radio" lay-filter="report" name="report" value="关闭" title="关闭">
                    <input id="reportstatus" name="reportstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">商品管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="goods" name="goods" value="开启" title="开启">
                    <input type="radio" lay-filter="goods" name="goods" value="关闭" title="关闭">
                    <input id="goodsstatus" name="goodsstatus" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">权限管理权</label>
                <div class="layui-input-block">
                    <input type="radio" lay-filter="permission" name="permission" value="开启" title="开启">
                    <input type="radio" lay-filter="permission" name="permission" value="关闭" title="关闭">
                    <input id="permissionstatus" name="permissionstatus" value="" style="display: none">
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>
