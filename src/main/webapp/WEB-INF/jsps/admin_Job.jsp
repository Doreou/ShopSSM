<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/20
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>兼职申请列表</title>
    <link rel="stylesheet" href="/css/layui.css">
    <link rel="stylesheet" href="/css/layer.css">
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
                        <dd class="layui-this"><a href="/Page/admin_Job">兼职申请列表</a></dd>
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
</script>
<script src="/js/jquery.js"></script>
<script src="/layui.js"></script>
<script src="/js/Job.js"></script>
<div class="layui-row" id="popApplyInfo" style="display:none;">
    <div class="layui-col-md10 layui-row">
        <form id="popform" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 800px;">
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">申请编号</label>
                <div class="layui-input-block">
                    <input type="text" name="apply_id" id="apply_id" style="width: 200px" required
                           lay-verify="required" readonly="readonly" autocomplete="off" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">用户ID</label>
                <div class="layui-input-block">
                    <input type="text" name="user_id" id="user_id" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">用户姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="user_name" id="user_name" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">专业</label>
                <div class="layui-input-block">
                    <input type="text" name="major" id="major" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label" style="width: 125px">申请职位</label>
                <div class="layui-input-block">
                    <input type="text" name="job" id="job" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item  layui-input-inline">
                <label class="layui-form-label" style="width: 125px">个人简介</label>
                <div class="layui-input-block">
                    <input type="text" name="info" id="info" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item  layui-input-inline">
                <label class="layui-form-label" style="width: 125px">联系方式及号码</label>
                <div class="layui-input-block">
                    <input type="text" name="conn_type" id="conn_type" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                    <input type="text" name="conn_num" id="conn_num" style="width: 200px;display: none" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item  layui-input-inline">
                <label class="layui-form-label" style="width: 125px">所在位置</label>
                <div class="layui-input-block">
                    <input type="text" name="location" id="location" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item  layui-input-inline">
                <label class="layui-form-label" style="width: 125px">申请时间</label>
                <div class="layui-input-block">
                    <input type="text" name="up—_time" id="up_time" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>

        </form>
    </div>
</div>

<div class="layui-row" id="popReplyInfo" style="display:none;">
    <div class="layui-col-md10">
        <form id="popform1" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 445px;">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">回复管理员ID</label>
                <div class="layui-input-block">
                    <input type="text" name="id" id="id" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">标题</label>
                <div class="layui-input-block">
                    <input type="text" name="reply_title" id="reply_title" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">内容</label>
                <div class="layui-input-block">
                    <input type="text" name="content" id="content" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">回复时间</label>
                <div class="layui-input-block">
                    <input type="text" name="reply_time" id="reply_time" style="width: 200px" required lay-verify="required"
                           autocomplete="off" readonly="readonly" placeholder="" class="layui-input">
                </div>
            </div>

        </form>
    </div>
</div>

<div class="layui-row" id="popMessage" style="display:none;">
    <div class="layui-col-md10">
        <form id="popform2" class="layui-form layui-from-pane" action="" style="margin-top:20px; width: 445px;">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">消息标题</label>
                <div class="layui-input-block">
                    <input type="text" name="message_title" id="message_title" style="width: 200px" required lay-verify="required"
                           autocomplete="off"  placeholder="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">消息内容</label>
                <div class="layui-input-block">
                    <textarea type="text" name="message_content" id="message_content" style="width: 200px" required lay-verify="required"
                              autocomplete="off"  placeholder="" class="layui-input"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 125px">备注</label>
                <div class="layui-input-block">
                    <textarea type="text" name="message_tip" id="message_tip" style="width: 200px" required lay-verify="required"
                               autocomplete="off" placeholder="" class="layui-input"></textarea>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>
