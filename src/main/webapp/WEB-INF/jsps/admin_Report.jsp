<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/30
  Time: 15:19
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
<style>
    .laytable-cell-1-0-5{
        height: 38px;
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
                        <dd class="layui-this"><a href="/Page/admin_Report">被举报列表</a></dd>
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
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="bereported_goods">商品</a>
</script>
<script src="/js/jquery.js"></script>
<script src="/layui.js"></script>
<script src="/js/Report.js"></script>
<div class="layui-row" id="popReportInfo" style="display:none;">
    <div class="layui-col-md10 layui-row">
        <form id="popform" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 783px;">
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">投诉编号</label>
                <div class="layui-input-block">
                    <input type="text" name="report_id" id="report_id" style="width: 200px" required
                           lay-verify="required" readonly="readonly" autocomplete="off" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">举报人</label>
                <div class="layui-input-block">
                    <input type="text" name="report_userid" id="report_userid" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item  layui-input-inline">
                <label class="layui-form-label" style="width: 125px">举报类型</label>
                <div class="layui-input-block">
                    <input type="text" name="report_type" id="report_type" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">举报理由</label>
                <div class="layui-input-block">
                    <input type="text" name="report_content" id="report_content" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">被举报人</label>
                <div class="layui-input-block">
                    <input type="text" name="bereported_userid" id="bereported_userid" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">被举报商品</label>
                <div class="layui-input-block">
                    <input type="text" name="bereported_goodsid" id="bereported_goodsid" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item  layui-input-inline">
                <label class="layui-form-label" style="width: 125px">举报时间</label>
                <div class="layui-input-block">
                    <input type="text" name="report_time" id="report_time" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item  layui-input-inline">
                <label class="layui-form-label" style="width: 125px">证据/截图</label>
                <div class="layui-input-block">
                    <img src="" id="report_pic" name="report_pic" class="pimg">
                </div>
            </div>
            <label style="margin-left: 35px" onclick="layer.msg('点击图片查看大图');return false;" class="layui-btn layui-btn-normal">点击图片查看大图</label>
        </form>
    </div>
</div>
<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:19891017;width:100%;height:100%;display:none;">
    <div id="innerdiv" style="position:absolute;">
        <img id="big" style="border:5px solid #fff;" src="" />
    </div>
</div>
</body>
</html>