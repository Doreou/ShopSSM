var permission = "";
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].subject_permission;
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
        , url: '/Admin/getAllSubject'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'subject_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
            , {field: 'subject', title: '科目名称', width: 100}
            , {
                field: 'icon',
                title: '科目标识图',
                width: 150,
                style: 'background:#5A5A5A',
                templet: '<div><img src="{{d.icon}}"></div>',
                align: 'center'
            }
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'subject_id'
            , type: 'asc'
        }
    });
    if (permission == 1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                layer.msg('查看操作');
            } else if (layEvent === 'del') {
                layer.confirm('真的删除行么', function (index) {
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
                $('#subject_id').val(data.subject_id);
                layer.open({
                    type: 1,
                    title: "修改分类信息",
                    area: ['450px', '330px'],
                    content: $("#popUpdate"),
                    btn: ['确定', '重置'],
                    yes: function () {
                        //异步修改
                        var tempSubject = $('#subject').val();
                        var tempIcon = $('#fileLocation1').val();
                        $.ajax({
                            type: 'post',
                            url: '/Admin/updateSubject',
                            data: $('#popform').serialize(),
                            success: function (msg) {
                                layer.closeAll();
                                layer.msg(msg);
                                obj.update({
                                    subject: tempSubject,
                                    icon: tempIcon,
                                });
                            }
                        })
                    },
                    btn2: function () {
                        $('#icon').val("");
                        $('#subject').val("");
                        //禁止图层关闭
                        return false;
                    }
                });

            }
        });
    } else {
        layer.msg("您仅有查看权限");
    }

});

layui.use('upload', function () {
    var upload = layui.upload;

    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadIcon' //绑定元素
        , url: '/Admin/uploadIcon' //上传接口
        , done: function (res) {
            //上传完毕回调
            $('#fileLocation').val(res.data[0]);
            $('#priviewIcon').attr('src', res.data[0]);
            $('#priviewIcon').attr('style', 'display:block;background:#5A5A5A');
            layer.msg(res.msg);
        }
        , error: function () {
            //请求异常回调
            layer.msg("上传失败，请稍后再试");
        }
    });
});

layui.use('upload', function () {
    var upload = layui.upload;

    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadIcon1' //绑定元素
        , url: '/Admin/uploadIcon' //上传接口
        , done: function (res) {
            //上传完毕回调
            $('#fileLocation1').val(res.data[0]);
            $('#priviewIcon1').attr('src', res.data[0]);
            $('#priviewIcon1').attr('style', 'display:block;background:#5A5A5A');
            layer.msg(res.msg);
        }
        , error: function () {
            //请求异常回调
            layer.msg("上传失败，请稍后再试");
        }
    });
});

function addNewSubject() {
    if(permission==1) {
        $('#priviewIcon').attr("src", "");
        $('#newsubject').val("");
        layer.open({
            type: 1,
            title: "修改分类信息",
            area: ['450px', '330px'],
            content: $("#popInsert"),
            btn: ['确定', '重置'],
            yes: function () {
                $.ajax({
                    type: 'POST',
                    url: '/Admin/addNewSubject',
                    data: $('#addNewSbjform').serialize(),
                    success: function (msg) {
                        layer.closeAll();
                        layer.msg(msg + ",请刷新后查看");
                    }
                })
            },
            btn2: function () {
                $('#icon').val("");
                $('#subject').val("");
                //禁止图层关闭
                return false;
            }

        })
    }else {
        layer.msg('您无权进行此操作');
    }


}