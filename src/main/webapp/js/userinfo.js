var permission = "";
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].user_permission;
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
        , url: '/Admin/getAllUserInfo'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'user_id', title: 'ID', width: 150, sort: true, fixed: 'left'}
            , {field: 'username', title: '姓名', width: 100}
            , {field: 'label', title: '签名', width: 100}
            , {field: 'sex', title: '性别', width: 100}
            , {field: 'age', title: '年龄', width: 100}
            , {field: 'join_time', title: '注册时间', width: 200}
            , {field: 'icon', title: '头像', width: 150,templet:'<div><img src="{{d.icon}}"></div>'}
            , {field: 'member_status', title: '认证状态', width: 100,templet:function (d) {
                    if(d.member_status==1){
                        return "已认证";
                    }else{
                        return "未认证";
                    }
                }}
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'user_id'
            , type: 'asc'
        }
    });
    if(permission==1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                layer.msg('查看操作');
            } else if (layEvent === 'del') {
                layer.confirm('确定要注销该用户账户？', function (index) {
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        type: 'post',
                        url: '/Admin/deleteSubject?subject=' + data.subject,
                        success: function (msg) {
                            layer.msg(msg);
                        }

                    })
                });
            } else if (layEvent === 'edit') {
                location.href="/Page/admin_MessageToUser?userid="+data.user_id;
            }
        });
    }else {
        layer.msg("您仅有查看权限");
    }
})