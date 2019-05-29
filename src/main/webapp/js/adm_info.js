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
    $.ajax({
        type:'POST',
        url:'/Admin/getAllAdminType',
        success:function (msg) {
            $.ajax({
                type:'POST',
                url:'/Admin/getAdmin',
                success:function (result) {
                    $('#admin_type').text(result.type);
                    $('#admin_id').val(result.id);
                    $('#admin_name').val(result.username);
                    $('#wechat').val(result.wechat);
                    $('#email').val(result.email);
                    $('#admin_phone').val(result.phone);
                    $('#admin_location').val(result.location);
                    if(result.icon!=""||result.icon!=null) {
                        $('#priviewIcon').attr('src', result.icon);
                        $('#priviewIcon').attr('style','display:block;background:#5A5A5A');
                        $('#fileLocation').val(result.icon);
                    }
                    layui.use('form',function () {
                        var form=layui.form;
                        if(result.sex=="男"){
                            $("input:radio[name='classify'][value='男']").attr("checked",'true');
                            $('#people').val("男");
                        }else{
                            $("input:radio[name='classify'][value='女']").attr("checked",'true');
                            $('#people').val("女");
                        }
                        form.render();
                    })
                    for(var i=0;i<msg.data.length;i++) {
                        if(result.type==msg.data[i].type) {
                            $("#admin_type").append(new Option(msg.data[i].type, msg.data[i].type));
                        }
                    }
                    form.render("select");
                }
            })

        }
    })

});
layui.use('upload', function(){
    var upload = layui.upload;

    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadIcon' //绑定元素
        ,url: '/Admin/uploadHeadPic' //上传接口
        ,done: function(res){
            //上传完毕回调
            $('#fileLocation').val(res.data[0]);
            $('#priviewIcon').attr('src',res.data[0]);
            $('#priviewIcon').attr('style','display:block;background:#5A5A5A');
            layer.msg(res.msg);
        }
        ,error: function(){
            //请求异常回调
            layer.msg("上传失败，请稍后再试");
        }
    });
});
function GoUpdate() {
    layer.confirm('确定修改吗?',function () {
        $.ajax({
            type:'POST',
            url:'/Admin/updateAdminInfo',
            data:{fileLocation:$('#fileLocation').val(),email:$('#email').val(),wechat:$('#wechat').val(),phone:$('#admin_phone').val(),
                sex:$('#people').val(),location:$('#admin_location').val()},
            success:function (msg) {
                if(msg=="修改成功"){
                    setTimeout(function () {
                        layer.msg(msg);
                    },2000)
                }else {
                    layer.msg("系统错误，修改失败！请稍后再试");
                }
            }
        })
    })
}