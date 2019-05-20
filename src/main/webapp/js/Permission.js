var permission = "";
var num=0;
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].permission;
    }
})
function trans(data){
    if(data.elem.value=='关闭'){
        num=0;
    }else {
        num=1;
    }
}
layui.use(['element','form'], function () {
    var element = layui.element;
    var form=layui.form;
    form.on('radio(user)',function (data) {
        trans(data);
        $('#userstatus').val(num);
    })
    form.on('radio(carousel)',function (data) {
        trans(data);
        $('#carouselstatus').val(num);
    })
    form.on('radio(subject)',function (data) {
        trans(data);
        $('#subjectstatus').val(num);
    })
    form.on('radio(message)',function (data) {
        trans(data);
        $('#sendmsgstatus').val(num);
    })
    form.on('radio(cert)',function (data) {
        trans(data);
        $('#certstatus').val(num);
    })
    form.on('radio(job)',function (data) {
        trans(data);
        $('#jobstatus').val(num);
    })
    form.on('radio(adm)',function (data) {
        trans(data);
        $('#admstatus').val(num);
    })
    form.on('radio(permission)',function (data) {
        trans(data);
        $('#permissionstatus').val(num);
    })
    form.on('radio(report)',function (data) {
        trans(data);
        $('#reportstatus').val(num);
    })
    form.on('radio(goods)',function (data) {
        trans(data);
        $('#goodsstatus').val(num);
    })
});


layui.use('table', function () {
    var table = layui.table;

    //第一个实例
    table.render({
        elem: '#demo'
        , height: 520
        , url: '/Admin/getAllAdminTypePage'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'type_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
            , {field: 'type', title: '类型', width: 100}
            , {field: 'user_permission', title: '用户管理权', width: 100,align:'center',templet:function (d) {
                    if(d.user_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'carousel_permission', title: '轮播图管理权', width: 100,align:'center',templet:function (d) {
                        if(d.carousel_permission==1){
                            return "√";
                        }else {
                            return "×";
                        }
                    }}
            , {field: 'subject_permission', title: '科目管理权', width: 100,align:'center',templet:function (d) {
                    if(d.subject_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'message_permission', title: '消息管理权', width: 100,align:'center',templet:function (d) {
                    if(d.message_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'sendmsg_permission', title: '发送消息权', width: 100,align:'center',templet:function (d) {
                    if(d.sendmsg_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'cert_permission', title: '认证权', width: 100,align:'center',templet:function (d) {
                    if(d.cert_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'job_permission', title: '兼职管理权', width: 100,align:'center',templet:function (d) {
                    if(d.job_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'adm_permission', title: '管理员管理权', width: 120,align:'center',templet:function (d) {
                    if(d.adm_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'report_permission', title: '举报管理权', width: 100,align:'center',templet:function (d) {
                    if(d.report_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'permission', title: '权限管理权', width: 100,align:'center',templet:function (d) {
                    if(d.permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {field: 'goods_permission', title: '商品管理权', width: 100,align:'center',templet:function (d) {
                    if(d.goods_permission==1){
                        return "√";
                    }else {
                        return "×";
                    }
                }}
            , {fixed: 'right', width: 100, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'type_id'
            , type: 'asc'
        }
    });
    if (permission == 1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                layer.msg('查看操作');
            } else if (layEvent === 'edit') {
                $('#id').val(data.type_id);
                $('#type').val(data.type);
                layui.use('form',function () {
                    var form=layui.form;
                    if(data.user_permission==1){
                        $("input:radio[name='user'][value='开启']").attr("checked",'true');
                        $('#userstatus').val(1);
                    }else{
                        $("input:radio[name='user'][value='关闭']").attr("checked",'true');
                        $('#userstatus').val(0);
                    }
                    if(data.carousel_permission){
                        $("input:radio[name='carousel'][value='开启']").attr("checked",'true');
                        $('#carouselstatus').val(1);
                    }else{
                        $("input:radio[name='carousel'][value='关闭']").attr("checked",'true');
                        $('#carouselstatus').val(0);
                    }
                    if(data.subject_permission){
                        $("input:radio[name='subject'][value='开启']").attr("checked",'true');
                        $('#subjectstatus').val(1);
                    }else{
                        $("input:radio[name='subject'][value='关闭']").attr("checked",'true');
                        $('#subjectstatus').val(0);
                    }
                    if(data.message_permission){
                        $("input:radio[name='message'][value='开启']").attr("checked",'true');
                        $('#messagestatus').val(1);
                    }else{
                        $("input:radio[name='message'][value='关闭']").attr("checked",'true');
                        $('#messagestatus').val(0);
                    }
                    if(data.sendmsg_permission){
                        $("input:radio[name='sendmsg'][value='开启']").attr("checked",'true');
                        $('#sendmsgstatus').val(1);
                    }else{
                        $("input:radio[name='sendmsg'][value='关闭']").attr("checked",'true');
                        $('#sendmsgstatus').val(0);
                    }
                    if(data.cert_permission){
                        $("input:radio[name='cert'][value='开启']").attr("checked",'true');
                        $('#certstatus').val(1);
                    }else{
                        $("input:radio[name='cert'][value='关闭']").attr("checked",'true');
                        $('#certstatus').val(0);
                    }
                    if(data.job_permission){
                        $("input:radio[name='job'][value='开启']").attr("checked",'true');
                        $('#jobstatus').val(1);
                    }else{
                        $("input:radio[name='job'][value='关闭']").attr("checked",'true');
                        $('#jobstatus').val(0);
                    }
                    if(data.adm_permission){
                        $("input:radio[name='adm'][value='开启']").attr("checked",'true');
                        $('#admstatus').val(1);
                    }else{
                        $("input:radio[name='adm'][value='关闭']").attr("checked",'true');
                        $('#admstatus').val(0);
                    }
                    if(data.report_permission){
                        $("input:radio[name='report'][value='开启']").attr("checked",'true');
                        $('#reportstatus').val(1);
                    }else{
                        $("input:radio[name='report'][value='关闭']").attr("checked",'true');
                        $('#reportstatus').val(0);
                    }
                    if(data.permission){
                        $("input:radio[name='permission'][value='开启']").attr("checked",'true');
                        $('#permissionstatus').val(1);
                    }else{
                        $("input:radio[name='permission'][value='关闭']").attr("checked",'true');
                        $('#permissionstatus').val(0);
                    }
                    if(data.goods_permission){
                        $("input:radio[name='goods'][value='开启']").attr("checked",'true');
                        $('#goodsstatus').val(1);
                    }else{
                        $("input:radio[name='goods'][value='关闭']").attr("checked",'true');
                        $('#goodsstatus').val(0);
                    }
                    form.render();
                })
                layer.open({
                    type: 1,
                    title: "修改权限信息",
                    area: ['450px', '650px'],
                    content: $("#popUpdate"),
                    btn: ['确定', '取消'],
                    yes: function () {
                        //异步修改
                        $.ajax({
                            type:'POST',
                            url:'/Admin/updatePermission',
                            data:$('#popform').serialize(),
                            success:function (msg) {
                                layer.msg(msg);
                                setTimeout(function () {
                                    location.reload();
                                },2000);
                            }
                        })

                    },
                    btn2: function () {
                        layer.close();
                    }
                });

            }
        });
    } else {
        layer.msg("您仅有查看权限");
    }
})
