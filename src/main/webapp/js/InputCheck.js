function check(){
    //登陆页面
    if ($('#userid').val() == "") {
        layer.msg("请检查用户名");
        return false;
    } else if ($('#password').val() == "") {
        layer.msg("请检查密码");
        return false
    }else if ($('#passcode').val() == "") {
        layer.msg("请输入验证码");
        return false;
    }

    //注册页面
    if ($('#username').val() == "") {
        layer.msg("请检查用户名");
        return false;
    } else if ($('#password').val() == "") {
        layer.msg("请检查密码");
        return false;
    } else if ($('#stuid').val() == "") {
        layer.msg("请检查id");
        return false;
    } else if ($('email').val() == "") {
        layer.msg("请检查邮箱格式");
        return false;
    } else if ($('passcode').val() == "") {
        layer.msg("请输入验证码");
        return false;
    }

    //用户申请加入页面
    if($('#username').val()==""){
        layer.msg("请完善您的用户名");
        return false;
    }else if($('#school').val()==""){
        layer.msg("请检查您的学校信息");
        return false;
    }else if($('#major').val()==""){
        layer.msg("请完善您的专业信息");
        return false;
    }else if($('#info').val()==""){
        layer.msg("请完善您的个人简介");
        return false;
    }else if($('#description').val()==""){
        layer.msg("请完善您的特长信息");
        return false;
    }else if($('#contactnum').val()==""){
        layer.msg("请完善您的联系方式");
        return false;
    }

    return true;
}