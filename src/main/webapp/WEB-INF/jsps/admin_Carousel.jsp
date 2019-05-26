<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/20
  Time: 9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>轮播图管理</title>
    <link rel="stylesheet" href="/css/layui.css">
</head>
<style>
    .laytable-cell-1-0-1{
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
                        <dd class="layui-this"><a href="/Page/admin_Carousel">轮播图管理</a></dd>
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
        <div class="layui-form" style="padding: 0px; margin-top: 30px;">
            <div class="layui-form-item" style="margin-bottom: 10px!important;">
                <label class="layui-form-label">轮播图名称</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline" style="margin-left: 5px;">
                        <input type="text" name="SearchCarousel" id="SearchCarousel" required style="width: 200px;" placeholder="请输入轮播图名称" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <label class="layui-form-label">开始时间</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline" style="margin-left: 5px;">
                        <input type="text" name="SearchCarouselBegin" id="SearchCarouselBegin" required style="width: 200px;" placeholder="请选择开始时间" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <label class="layui-form-label">结束时间</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline" style="margin-left: 5px;">
                        <input type="text" name="SearchCarouselEnd" id="SearchCarouselEnd" required style="width: 200px;" placeholder="请选择结束时间" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <button class="layui-btn" style="margin-left: 20px" data-type="reload" id="searchBtn" >搜索</button>
            </div>
        </div>
        <!-- 内容主体区域 -->
        <table id="demo" lay-filter="test"></table>
        <button style="display: block;margin-left: 70%" onclick="addNewCarousel()" class="layui-btn layui-btn-normal">添加新的轮播图</button>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © localhost:8080 - 校园二手书交易平台
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="/js/jquery.js"></script>
<script src="/layui.js"></script>
<script src="/js/Carousel.js"></script>
<div class="layui-row" id="popInsert" style="display:none;">
    <div class="layui-col-md10">
        <form id="popform" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 445px;">
            <input style="display: none;" name="fileLocation" id="fileLocation" value="">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">轮播图描述</label>
                <div class="layui-input-block">
                    <input type="text" name="carousel_info" id="carousel_info" style="width: 200px" required lay-verify="required"
                           autocomplete="off" placeholder="请输入轮播图描述" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">开始日期</label>
                <div class="layui-input-block">
                    <input type="text" name="start" id="start" style="width: 200px" required lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">结束日期</label>
                <div class="layui-input-block">
                    <input type="text" name="end" id="end" style="width: 200px" required lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">可见性</label>
                <div class="layui-input-block">
                    <input type="radio"  name="classify" value="可见" title="可见">
                    <input type="radio"  name="classify" value="不可见" title="不可见">
                    <input id="visible" name="visible" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">轮播图</label>
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
<div class="layui-row" id="popUpdate" style="display:none;">
    <div class="layui-col-md10">
        <form id="popform1" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 445px;">
            <input style="display: none;" name="fileLocation1" id="fileLocation1" value="">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">轮播图编号</label>
                <div class="layui-input-block">
                    <input type="text" name="carousel_id" id="carousel_id" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="请输入轮播图描述" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">轮播图描述</label>
                <div class="layui-input-block">
                    <input type="text" name="carousel_info1" id="carousel_info1" style="width: 200px" required lay-verify="required"
                           autocomplete="off" placeholder="请输入轮播图描述" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">开始日期</label>
                <div class="layui-input-block">
                    <input type="text" name="start1" id="start1" style="width: 200px" required lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">结束日期</label>
                <div class="layui-input-block">
                    <input type="text" name="end1" id="end1" style="width: 200px" required lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">可见性</label>
                <div class="layui-input-block">
                    <input type="radio" id="kejain" name="classify" value="可见" title="可见">
                    <input type="radio" id="bukejian" name="classify" value="不可见" title="不可见">
                    <input id="visible1" name="visible1" value="" style="display: none">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">轮播图</label>
                <div class="layui-input-block">
                    <button type="button" class="layui-btn" id="uploadIcon1">
                        <i class="layui-icon">&#xe67c;</i>上传图片
                    </button>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">预览</label>
                <div class="layui-input-block">
                    <img style="" src="" id="priviewIcon1">
                </div>
            </div>
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
