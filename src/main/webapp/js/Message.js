var permission = "";
if (location.href != "http://localhost:8080/Order/getMyNews") {
    $.ajax({
        type: 'POST',
        url: '/Admin/getPermission',
        success: function (msg) {
            permission = msg.data[0].sendmsg_permission;
        }
    })
}

var url = location.search; //获取url中"?"符后的字串
if (url.indexOf("?") != -1) {    //判断是否有参数
    var str = url.substr(1); //从第一个字符开始 因为第0个是?号 获取所有除问号的所有符串
    strs = str.split("=");   //用等号进行分隔 （因为知道只有一个参数 所以直接用等号进分隔 如果有多个参数 要用&号分隔 再用等号进行分隔）
    $('#reciever').val(strs[1]);
    $('#reciever').focus();
    $('#reciever').blur();
    $('#messageTitle').focus();
}

layui.use('element', function () {
    var element = layui.element;
});
layui.use('form', function () {
    var form = layui.form;
    form.on('radio', function (data) {
        $('#people').val(data.value);
    })
    form.on('checkbox', function (data) {
        $('#ischeck').val(data.elem.checked);
    })
    $.ajax({
        type: 'POST',
        url: '/Message/getMessageType',
        success: function (msg) {
            for (var i = 0; i < msg.data.length; i++) {
                $("#SearchMessage_type").append(new Option(msg.data[i].message_type, msg.data[i].message_type));
            }
            form.render("select");
        }
    })

});
layui.use('laydate', function () {
    var laydate = layui.laydate;
    laydate.render({
        elem: '#sendTime', //指定元素
        trigger: 'click',
        min: 0,//可选中的最早日期限制为今日
    });
});

function getUserName() {
    $.ajax({
        type: 'POST',
        url: '/User/getById',
        data: {id: $('#reciever').val()},
        success: function (msg) {
            if (msg != "未找到!") {
                $('#warn').html("找到用户！请确认昵称");
                $('#username').val(msg);
            } else {
                $('#warn').html("未找到该用户！请检查用户ID");
                $('#warn').attr("style", "color:red !important");
            }
        }
    })
}

$('#agreebtn').click(function () {
    var message_id = $('#agree').val();
    layer.confirm('同意交易后买家将收到提醒，请按照约定见面交易，请注意安全。', function () {
        $.ajax({
            type: 'POST',
            url: '/Order/agree?message_id=' + message_id,
            success: function (msg) {
                layer.msg(msg);
                setTimeout(function () {
                    location.reload();
                }, 2000);
            }
        })
    })
})
$('#disagreebtn').click(function () {
    var message_id = $('#agree').val();
    layer.open({
        type: 1,
        content: $('#popRefused'),
        area: ["500px", "300px"],
        btn: ['确定', '取消'],
        yes: function () {
            layer.confirm('确定拒绝吗？', function () {
                $.ajax({
                    type: 'POST',
                    url: '/Order/disagree?message_id=' + message_id,
                    data: $('#popform').serialize(),
                    success: function (msg) {
                        layer.msg(msg);
                        setTimeout(function () {
                            location.reload();
                        }, 2000);
                    }
                })
            })
        },
        btn2: function () {
            layer.closeAll();
        }

    })
})

$('#readbtn').click(function () {

    $.ajax({
        type: 'POST',
        url: '/Order/AlreadyRead?message_id=' + $('#read').val() + '&status=1',
        success: function (msg) {
            layer.msg(msg, {
                icon: 1,
                time: 1000
            }, function () {
                location.reload();
            });

        }
    })
})
$('#unreadbtn').click(function () {
    $.ajax({
        type: 'POST',
        url: '/Order/AlreadyRead?message_id=' + $('#unread').val() + '&status=0',
        success: function (msg) {
            layer.msg(msg, {
                icon: 1,
                time: 1000
            }, function () {
                location.reload();
            });
        }
    })
})

layui.use('table', function () {
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            , height: 520
            , url: '/Message/getAllMessage'//数据接口
            , toolbar: '#bardemo'
            , page: true
            , request: {
                pageName: 'curr' //页码的参数名称，默认：page
                , limitName: 'nums' //每页数据量的参数名，默认：limit
            }
            , cols: [[ //表头
                {field: 'message_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
                , {field: 'message_title', title: '标题', width: 150}
                , {field: 'message_content', title: '内容', width: 200}
                , {field: 'message_type', title: '消息类型', width: 100}
                , {
                    field: 'send_time', title: '发送日期', width: 100, templet: function (d) {
                        var time = new Date(d.send_time);
                        return time.toLocaleDateString();
                    }
                }
                , {field: 'sender', title: '发送人', width: 100}
                , {field: 'reciever', title: '接收人', width: 100}
                , {
                    field: 'isRead', title: '已读状态', width: 100, templet: function (d) {
                        if (d.isRead == 0)
                            return "未读";
                        else
                            return "已读";
                    }
                }
                , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
            ]]
            , initSort: {
                field: 'message_id'
                , type: 'asc'
            }

        });
        active = {
            reload: function () {
                var Title = $('#SearchTitle').val();
                var Content=$('#SearchContent').val();
                var Sender=$('#SearchSender').val();
                var Reciever=$('#SearchReciever').val();
                var Message_type=$('#SearchMessage_type').val();
                var SendTime=$('#SearchSend_time').val();
                var Status=$('#SearchStatus').val();
                table.reload('demo', {
                    page: {
                        curr: 1,
                    },
                    where: {
                        message_title:Title,
                        message_content:Content,
                        message_type:Message_type,
                        send_time:SendTime,
                        isRead:Status,
                        sender:Sender,
                        reciever:Reciever,
                    }
                })
            }
        };
        $('#searchBtn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        if (permission == 1) {
            table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    , layEvent = obj.event; //获得 lay-event 对应的值
                if (layEvent === 'delete') {
                    if (data.isRead == "已读") {
                        //如果当前时间在发送时间后
                        alert = "用户已经查看此消息，您依旧要撤回吗？";
                        deleteMessage(obj);
                    } else {
                        alert = "确定要撤回消息吗?";
                        deleteMessage(obj);
                    }


                }
            })
        } else {
            if (location.href != "http://localhost:8080/Order/getMyNews") {
                layer.msg("您仅有查看权限");
            }
        }
    }
)

function deleteMessage(obj) {
    layer.confirm(alert, function () {
        $.ajax({
            type: 'POST',
            url: '/Message/deleteMessage?message_id=' + obj.data.message_id,
            success: function (msg) {
                obj.del();
                layer.msg(msg);
            }
        })
    });
}

$('#sendMessage').on('click', function () {
    if (permission == 1) {
        $.ajax({
            type: 'POST',
            url: '/Message/sendMessageToOne',
            data: 'messageTitle=' + $('#messageTitle').val().toString() + "&messageContent=" + $('#messageContent').val() + "&reciever=" + $('#reciever').val() + "&sendTime=" + $('#sendTime').val(),
            success: function (msg) {
                if (msg == '发送成功') {
                    layer.msg(msg);
                } else {
                    layer.msg("发送未完成");
                }
            }
        })
    } else {
        layer.msg('您无权进行此操作');
    }
})

$('#sendMessageToAll').on('click', function () {
    if (permission == 1) {
        $.ajax({
            type: 'POST',
            url: '/Message/sendMessageToAll',
            data: 'messageTitle=' + $('#messageTitle').val().toString() + "&messageContent=" + $('#messageContent').val() + "&reciever=" + $('#people').val().toString() + "&sendTime=" + $('#sendTime').val() + "&ischeck=" + $("#ischeck").val(),
            success: function (msg) {
                if (msg == '发送成功') {
                    layer.msg(msg);
                } else {
                    layer.msg("发送未完成");
                }
            }
        })
    } else {
        layer.msg('您无权进行此操作');
    }
})

