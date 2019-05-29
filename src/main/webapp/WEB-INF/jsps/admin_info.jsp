<%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/5/4
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>个人资料</title>
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
    <!-- 内容主体区域 -->
    <div class="layui-body">
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header"><span>管理员</span>&nbsp;/&nbsp;<span
                                style="color: #8c8c8c">个人资料</span></div>
                        <div class="layui-card-body">

                            <div class="layui-form" wid100="">
                                <input style="display: none;" name="fileLocation" id="fileLocation" value="">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">管理员级别</label>
                                    <div class="layui-input-inline">
                                        <select name="admin_type" id="admin_type">
                                            <option value="">请选择一个级别</option>
                                        </select>
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">此项不可修改</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">ID</label>
                                    <div class="layui-input-inline">
                                        <input type="text" readonly="readonly" name="admin_id" id="admin_id" value="" placeholder="请输入ID"
                                               class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">此项不可修改</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">真实姓名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" maxlength="140" readonly="readonly" placeholder="请输入真实姓名" name="admin_name"
                                               id="admin_name" value="" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">此项不可修改</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">头像</label>
                                    <div class="layui-input-inline">
                                        <button type="button" class="layui-btn" id="uploadIcon">
                                            <i class="layui-icon">&#xe67c;</i>上传图片
                                        </button>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">预览</label>
                                    <div class="layui-input-inline">
                                        <img style="display: none" src="" id="priviewIcon">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">所在地</label>
                                    <div class="layui-input-inline">
                                        <input type="text" maxlength="140" placeholder="请输入所在地" name="admin_location"
                                               id="admin_location" value="" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请输入所在地</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">性别</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="classify" value="男" title="男">
                                        <input type="radio" name="classify" value="女" title="女">
                                        <input id="people" value="" style="display: none">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">联系电话</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="admin_phone" id="admin_phone" value=""
                                               placeholder="请输入联系电话" autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请输入联系电话</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">电子邮箱</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="email" name="email" placeholder="请输入电子邮箱"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请输入电子邮箱</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">微信</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="wechat" name="wechat" placeholder="请输入微信号"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">请输入微信号</div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit onclick="GoUpdate()">确认修改</button>
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
<script src="/js/adm_info.js"></script>
</body>
</html>
