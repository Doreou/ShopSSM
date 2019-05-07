var permission = "";
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].job_permission;
    }
})
layui.use('element', function () {
    var element = layui.element;
});
layui.use('table', function () {
    var table = layui.table;

    //第一个实例
    table.render({
        elem: '#demo'
        , height: 520
        , url: '/Admin/getAllApply'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'apply_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
            , {field: 'user_id', title: '用户ID', width: 100}
            , {field: 'name', title: '用户姓名', width: 100}
            , {field:'major',title:'专业',width:100}
            , {field:'job',title:'申请职位',width:100}
            , {field:'info',title:'个人简介',width:100}
            , {field:'conn_type',title:'联系方式',width:100}
            , {field:'conn_way',title:'联系号码',width:100}
            , {field:'location',title:'所在位置',width:100}
            , {field: 'apply_adm', title: '审核管理员ID', width: 100}
            , {field:'reply_title',title:'回复标题',width:100}
            , {field:'reply',title:'回复内容',width:100}
            , {field:'up_time',title:'申请时间',width:100,templet:function (d) {
                    var time=new Date(d.up_time);
                    return time.toLocaleDateString();
                }}
            , {field: 'check_time', title: '审核时间', width: 100,templet:function (d) {
                console.log(d.check_time);
                if(d.check_time!=null) {
                    var time = new Date(d.check_time);
                    return time.toLocaleDateString();
                }else{
                    return "暂未回复";
                }
                }}
            , {
                field: 'status', title: '认证状态', width: 100, templet: function (d) {
                    if (d.status == 0)
                        return "未回复";
                    else if(d.status==1)
                        return "已通过";
                    else
                        return "已拒绝";
                }
            }
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        ,initSort: {
            field: 'apply_id'
            , type: 'asc'
        }

    });
    if(permission==1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                var id = data.apply_id;
                $.ajax({
                    type: 'POST',
                    url: '/Admin/getOneApply?apply_id=' + id,
                    success: function (msg) {
                        $('#apply_id').val(id);
                        $('#user_id').val(msg.data[0].user_id);
                        $('#user_name').val(msg.data[0].name);
                        $('#major').val(msg.data[0].major);
                        $('#job').val(msg.data[0].job);
                        $('#info').val(msg.data[0].info);
                        $('#reply_title').val(msg.data[0].reply_title);
                        $('#conn_num').val(msg.data[0].conn_way);
                        $('#conn_type').val(msg.data[0].conn_type + "  |  " + msg.data[0].conn_way);
                        $('#location').val(msg.data[0].location);
                        var time = new Date(msg.data[0].up_time);
                        $('#up_time').val(time.toLocaleDateString());
                    }
                })
                layer.open({
                    type: 1,
                    title: "查看用户资料",
                    area: ['800px', '470px'],
                    content: $("#popApplyInfo"),
                    btn: ['查看回复信息', '通过', '拒绝', '暂不回复'],
                    yes: function () {
                        if (data.apply_adm == "" || data.reply == "") {
                            layer.msg("暂时没有回复信息");
                        } else {
                            var check_time = new Date(data.check_time);
                            $("#id").val(data.apply_adm);
                            $('#content').val(data.reply);
                            $('#reply_time').val(check_time.toLocaleDateString());
                            layer.open({
                                type: 1,
                                title: '回复信息',
                                area: ['470px', '470px'],
                                content: $('#popReplyInfo'),
                                btn: ['确定'],
                                yes: function (index) {
                                    layer.close(index);
                                }
                            });
                        }
                    },
                    btn2: function () {
                        if (data.apply_adm != null) {
                            layer.msg("已回复!");
                            return false;
                        }
                        layer.open({
                            async: false,
                            type: 1,
                            title: '提醒',
                            content: '通过后，系统将自动向该用户发送通知，您也可以选择自定义通知',
                            btn: ['发送默认通知', '自定义通知'],
                            yes: function () {
                                layer.confirm('确定通过吗？', function (index) {
                                    $.ajax({
                                        type: 'POST',
                                        url: '/Admin/ApplyPass',
                                        data: {apply_id: data.apply_id, reciever: data.user_id},
                                        success: function (msg) {
                                            layer.closeAll();
                                            layer.msg(msg);
                                        }
                                    })
                                })
                            },
                            btn2: function () {
                                layer.open({
                                    async: false,
                                    type: 1,
                                    title: '自定义通知',
                                    content: $('#popMessage'),
                                    area: ['455px', '360px'],
                                    btn: ["确定", "取消"],
                                    yes: function () {
                                        layer.confirm('确定通过吗？', function (index) {
                                            $.ajax({
                                                type: 'POST',
                                                url: '/Admin/ApplyPass',
                                                data: 'apply_id=' + data.apply_id + "&reciever=" + data.user_id + "&message_title=" + $('#message_title').val() + "&message_content=" + $('#message_content').val() + "&message_tip=" + $('#message_tip').val(),
                                                success: function (msg) {
                                                    layer.closeAll();
                                                    layer.msg(msg);
                                                }
                                            })
                                        })
                                    }

                                })

                            }
                        })
                    },
                    btn3: function () {
                        if (data.apply_adm != null) {
                            layer.msg("已回复!");
                            return false;
                        }
                        layer.open({
                            async: false,
                            type: 1,
                            title: '提醒',
                            content: '拒绝后，系统将自动向该用户发送通知，您也可以选择自定义通知',
                            btn: ['发送默认通知', '自定义通知'],
                            yes: function () {
                                layer.confirm('确定拒绝吗？', function (index) {
                                    $.ajax({
                                        type: 'POST',
                                        url: '/Admin/ApplyRefused',
                                        data: {apply_id: data.apply_id, reciever: data.user_id},
                                        success: function (msg) {
                                            layer.closeAll();
                                            layer.msg(msg);
                                        }
                                    })
                                })
                            },
                            btn2: function () {
                                layer.open({
                                    async: false,
                                    type: 1,
                                    title: '自定义通知',
                                    content: $('#popMessage'),
                                    area: ['455px', '360px'],
                                    btn: ["确定", "取消"],
                                    yes: function () {
                                        layer.confirm('确定拒绝吗？', function (index) {
                                            $.ajax({
                                                type: 'POST',
                                                url: '/Admin/ApplyRefused',
                                                data: 'apply_id=' + data.apply_id + "&reciever=" + data.user_id + "&message_title=" + $('#message_title').val() + "&message_content=" + $('#message_content').val() + "&message_tip=" + $('#message_tip').val(),
                                                success: function (msg) {
                                                    layer.closeAll();
                                                    layer.msg(msg);
                                                }
                                            })
                                        })
                                    }

                                })

                            }
                        })
                    },
                    btn4: function () {

                        layer.msg("请在24小时内给予答复!");
                    }
                })
            }
        });
    }else
        layer.msg("您仅有查看权限");
});