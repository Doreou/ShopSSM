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
})

function  GoRegister() {
    if(permission==1) {
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
        layer.msg('您无权进行此操作');
    }
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
