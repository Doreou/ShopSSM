$('#btn').on('click',function () {
    $.ajax({
        type:'POST',
        url:'/Admin/adminLogin',
        data:{admin_id:$('#loginName').val(),admin_pwd:$('#passWord').val(),code:$('#vercode').val()},
        success:function (msg) {
            if(msg=='success'){
                layer.msg("登陆成功");
                setTimeout(function () {
                    location.href='/Page/admin_Subject';
                },2000)
            }else{
                layer.msg(msg);
            }
        }
    })
})
function changeImage(){
    $('#verifycode').attr('src', '/User/getVerifyCode?t='+(new Date()).valueOf());
}