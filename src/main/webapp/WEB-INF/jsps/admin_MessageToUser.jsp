<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/23
  Time: 16:53
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
                        <dd><a href="/Page/admin_userinfo">用户信息列表</a></dd>
                        <dd><a href="/Page/admin_Report">被举报列表</a></dd>
                        <dd class="layui-nav-itemed"><a href="javascript:;">消息中心</a>
                            <dl class="layui-nav-child">
                                <dd class="layui-this"><a href="/Page/admin_MessageToUser">&ensp;&ensp;向个人用户发送</a></dd>
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
                        <dd><a href="javascript:;">注册管理员</a></dd>
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
                        <div class="layui-card-header"><span>消息中心</span>&nbsp;/&nbsp;<span style="color: #8c8c8c">向用户发送消息</span></div>
                        <div class="layui-card-body">

                            <div class="layui-form" wid100="" lay-filter="">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">消息标题</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="messageTitle" id="messageTitle" value="" placeholder="请输入标题" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">10字以内</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">消息内容</label>
                                    <div class="layui-input-inline" style="height: 105px;width: 420px">
                                        <textarea type="text" maxlength="140" style="resize: none; height: 105px;width: 420px" name="messageContent" id="messageContent" value="" class="layui-input"></textarea>
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">140字以内</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">收件人ID</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="reciever" onblur="getUserName()" id="reciever" value="" autocomplete="off" class="layui-input">
                                    </div>
                                    <div id="warn" class="layui-form-mid layui-word-aux">输入ID后请确认用户信息</div>
                                </div>
                                <div class="layui-form-item" id="usernamebox">
                                    <label class="layui-form-label">用户姓名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" readonly="readonly" name="username" id="username" value="" placeholder="此项自动填充" autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请确认用户姓名</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">送达时间</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="sendTime" name="sendTime" autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">今日以前的日期您将无法选中</div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit id="sendMessage">确认发送</button>
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
<script src="/js/Message.js"></script>
<script>

</script>
</body>
</html>
