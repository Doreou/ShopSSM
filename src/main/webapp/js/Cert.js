layui.use('element', function () {
    var element = layui.element;
});
layui.use('table', function () {
    var table = layui.table;

    //第一个实例
    table.render({
        elem: '#demo'
        , height: 520
        , url: '/Cert/getAllCert'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'cert_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
            , {field: 'user_id', title: '用户ID', width: 100}
            , {
                field: 'up_time', title: '用户提交日期', width: 100, templet: function (d) {
                    var time = new Date(d.up_time);
                    return time.toLocaleDateString();
                }
            }
            , {field: 'user_name', title: '用户姓名', width: 100}
            , {
                field: 'cert_pic',
                title: '证件信息',
                width: 120,
                templet: '<div><img src="{{d.cert_pic}}"></div>',
                align: 'center'
            }
            , {field: 'adm_id', title: ' 审核管理员ID', width: 100}
            , {field: 'adm_time', title: '审核时间', width: 100,templet:function (d) {
                    var time=new Date(d.adm_time);
                    return time.toLocaleDateString();
                }}
            , {
                field: 'status', title: '认证状态', width: 100, templet: function (d) {
                    if (d.status == 0)
                        return "未认证";
                    else
                        return "已通过";
                }
            }
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        ,initSort: {
            field: 'cert_id'
            , type: 'asc'
        }

    });
    table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
            , layEvent = obj.event; //获得 lay-event 对应的值
        if (layEvent === 'detail') {
            var certid=data.cert_id;
            $.ajax({
                type:'POST',
                url:'/Cert/getOneCert?certid='+certid,
                success:function (msg) {
                    $('#cert_id').val(certid);
                    $('#user_id').val(msg.data[0].user_id);
                    $('#user_name').val(msg.data[0].user_name);
                    $('#certPreview').attr('src',msg.data[0].cert_pic);
                    var time=new Date(msg.data[0].up_time);
                    $('#time').val(time.toLocaleDateString());
                }
            })
            layer.open({
                type: 1,
                title: "查看用户证明",
                area: ['470px', '470px'],
                content: $("#popCertInfo"),
                btn: ['通过', '拒绝','暂不回复'],
                yes:function () {
                    layer.confirm('您将通过该用户的认证请求，请务必确认用户资料!', function (index) {
                        layer.close(index);
                        //向服务端发送删除指令
                        $.ajax({
                            type: 'post',
                            url: '/Cert/updateCertStatus?certid=' + certid,
                            success: function (msg) {
                                obj.update({
                                    status:1,
                                });
                                layer.closeAll();
                                layer.msg(msg);
                            }
                        })
                    });
                },
                btn2:function () {
                    layer.confirm('您将拒绝该用户的认证请求，确定吗？', function (index) {
                        obj.del(); //删除对应行（tr）的DOM结构
                        layer.close(index);
                        //向服务端发送删除指令
                        $.ajax({
                            type: 'post',
                            url: '/Cert/deleteCert?certid=' + certid,
                            success: function (msg) {
                                layer.msg(msg);
                            }
                        })
                    });
                },
                btn3:function () {
                    layer.msg("请在24小时内给予答复!");
                }
            })
        }
    });
});