$('#btn').on('click',function () {
    if($('#loginName').val()==""){
        layer.msg("请输入ID");
        return false;
    }else if($('#passWord').val()==""){
        layer.msg("请输入密码");
        return false;
    }else if($('#vercode').val()==""){
        layer.msg("请输入验证码");
        return false;
    }else {
        $.ajax({
            type: 'POST',
            url: '/Admin/adminLogin',
            data: {admin_id: $('#loginName').val(), admin_pwd: $('#passWord').val(), code: $('#vercode').val()},
            success: function (msg) {
                if (msg == 'success') {
                    layer.msg("登陆成功");
                    setTimeout(function () {
                        location.href = '/Page/admin_Subject';
                    }, 2000)
                } else {
                    layer.msg(msg);
                }
            }
        })
    }
})
function changeImage(){
    $('#verifycode').attr('src', '/User/getVerifyCode?t='+(new Date()).valueOf());
}