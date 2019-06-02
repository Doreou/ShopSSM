var permission = "";
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].adm_permission;
    }
})
layui.use('element', function () {
    var element = layui.element;
});
layui.use('form', function () {
    var form = layui.form;
    form.on('checkbox',function (data) {
        if($('#admin_id').val()==""){
            layer.msg("请先输入ID");
        }else {
            if(data.elem.checked.toString()=="true") {
                $('#admin_pwd').val("a" + $('#admin_id').val());
                $('#admin_pwd_again').val("a" + $('#admin_id').val());
            }
            else {
                $('#admin_pwd').val("");
                $('#admin_pwd_again').val("");
            }
        }
    })
        $.ajax({
            type:'POST',
            url:'/Admin/getAllAdminType',
            success:function (msg) {
                for(var i=0;i<msg.data.length;i++) {
                    $("#admin_type").append(new Option(msg.data[i].type, msg.data[i].type));
                    $("#SearchType").append(new Option(msg.data[i].type, msg.data[i].type));
                }
                form.render("select");
            }
        })
});
layui.use('table', function () {
    var table = layui.table;

    //第一个实例
    table.render({
        elem: '#demo'
        , height: 520
        , url: '/Admin/getAllAdmin'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'admin_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
            , {field: 'admin_name', title: '姓名', width: 100}
            , {field: 'admin_type', title: '管理员类型', width: 100}
            , {field: 'admin_sex', title: '性别', width: 100}
            , {field: 'admin_location', title: '所在地', width: 100}
            , {field: 'admin_phone', title: '联系电话', width: 150}
            , {field: 'admin_wechat', title: '微信', width: 100}
            , {field: 'admin_email', title: '邮箱', width: 200}
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'admin_id'
            , type: 'asc'
        }
    });
    active={
        reload:function () {
            var ID=$('#SearchID').val();
            var Name=$('#SearchName').val();
            var Type=$('#SearchType').val();
            table.reload('demo',{
                page:{
                    curr:1,
                },
                where:{
                    admin_id:ID,
                    admin_type:Type,
                    admin_name:Name
                }
            })
        }
    };
    $('#searchBtn').on('click', function(){
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });
    if(permission==1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'del') {
                layer.confirm('确定要注销此管理员？', function () {
                    $.ajax({
                        type: 'POST',
                        url: '/Admin/deleteAdmin?admin_id=' + data.admin_id,
                        success: function (msg) {
                            obj.del();
                            layer.msg(msg);
                        }
                    })
                })
            }
        });
    }else {
        layer.msg('您仅有查看权限');
    }
})

function  GoRegister() {
    if(permission==1) {
        if($('#admin_id').val()==""){
            layer.msg("请填写ID");
            return false;
        }else if($('#admin_id').val().length>8){
            layer.msg("ID过长");
            return false;
        }else if($('#admin_name').val()==""){
            layer.msg("请填写管理员真实姓名");
            return false;
        }else if($('#admin_pwd').val()==""||$('#admin_pwd_again').val()==""){
            layer.msg("请检查密码");
            return false;
        }else if($('#admin_type').val()==""){
            layer.msg("请选择管理员级别");
            return false;
        }else {
            if (isSame()) {
                $.ajax({
                    type: 'POST',
                    url: '/Admin/RegisterAdmin',
                    data: {
                        admin_id: $('#admin_id').val(), admin_name: $('#admin_name').val(),
                        admin_pwd: $('#admin_pwd').val(), admin_type: $('#admin_type').val()
                    },
                    success: function (msg) {
                        layer.msg(msg);
                        setTimeout(function () {
                            location.href = "/Page/admin_AdmList";
                        }, 2000)
                    }
                })
            }else {
                layer.msg('两次输入的密码不一致!');
            }
        }
    }else
        layer.msg('您无权进行此操作');
}
function isSame() {
    if($('#admin_pwd').val()==$('#admin_pwd_again').val()){
        $('#msg').attr('style','color:red');
        $('#msg').html("请再次输入密码");
        return true;
    }else {
        $('#msg').attr('style','color:red!important');
        $('#msg').html("两次输入的密码不一致");
        return false;
    }
}

