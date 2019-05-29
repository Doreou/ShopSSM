function check(){
    var myReg=/^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;

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

    //出售二手 求购
    if($('#title').val()==""){
        layer.msg("请输入标题");
        return false;
    }else if($('#detail').val()==""){
        layer.msg("请输入介绍");
        return false;
    }
    else if($('#count').val()==""){
        layer.msg("请填写数量");
        return false;
    }else if($('#pricost').val()==""){
        layer.msg("请填写购买价格");
        return false;
    }else if($('#status').val()==""){
        layer.msg("请选择磨损程度");
        return false;
    }else if($('#price').val()==""){
        layer.msg("请输入价格");
        return false;
    }else if($('#address').val()==""){
        layer.msg("请输入交易地址");
        return false;
    }else if($('#type').val()==""){
        layer.msg("请选择科目");
        return false;
    }

    return true;
}

