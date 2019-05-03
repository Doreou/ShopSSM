var alert="";
layui.use('element', function () {
    var element = layui.element;
});
layui.use('form', function () {
    var form = layui.form;
    form.on('radio',function (data) {
        $('#people').val(data.value);
    })
    form.on('checkbox',function (data) {
        $('#ischeck').val(data.elem.checked);
    })

});
layui.use('laydate', function () {
    var laydate = layui.laydate;
    laydate.render({
        elem: '#sendTime', //指定元素
        trigger:'click',
        min:0,//可选中的最早日期限制为今日
    });
});
function getUserName() {
    $.ajax({
        type:'POST',
        url:'/User/getById',
        data:{id:$('#reciever').val()},
        success:function (msg) {
            if(msg!="未找到!") {
                $('#warn').html("找到用户！请确认昵称");
                $('#username').val(msg);
            }else{
                $('#warn').html("未找到该用户！请检查用户ID");
                $('#warn').attr("style","color:red !important");
            }
        }
    })
}
$('#readbtn').click(function () {

    $.ajax({
        type:'POST',
        url:'/Order/AlreadyRead?message_id='+$('#read').val()+'&status=1',
        success:function (msg) {
            layer.msg(msg,{
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
        type:'POST',
        url:'/Order/AlreadyRead?message_id='+$('#unread').val()+'&status=0',
        success:function (msg) {
            layer.msg(msg,{
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
            , {field: 'isRead', title: '已读状态', width: 100,templet:function (d) {
                    if(d.isRead==0)
                        return "未读";
                    else
                        return "已读";
                }}
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        ,initSort: {
            field: 'message_id'
            , type: 'asc'
        }

    });
    table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
            , layEvent = obj.event; //获得 lay-event 对应的值
        if(layEvent==='delete'){
            if(data.isRead=="已读"){
                //如果当前时间在发送时间后
                alert="用户已经查看此消息，您依旧要撤回吗？";
                deleteMessage(obj);
            }else{
                alert="确定要撤回消息吗?";
                deleteMessage(obj);
            }


        }
    })
})

function deleteMessage(obj) {
    layer.confirm(alert,function () {
        $.ajax({
            type:'POST',
            url:'/Message/deleteMessage?message_id='+obj.data.message_id,
            success:function (msg) {
                obj.del();
                layer.msg(msg);
            }
        })
    });
}

