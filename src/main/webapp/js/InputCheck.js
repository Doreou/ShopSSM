function check() {
    //正则表达式
    //邮箱测试
    var myEmail = /^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;
    var myPhone = /^[1][3,4,5,7,8][0-9]{9}$/;


    if (location.href == "http://localhost:8080/Page/login") {
        //登陆页面
        if ($('#userid').val() == "") {
            layer.msg("请检查用户名");
            return false;
        } else if ($('#password').val() == "" || $('#password').val().length < 5 || $('#password').val().length > 16) {
            layer.msg("密码不能为空且长度在5-16位之间");
            return false
        } else if ($('#passcode').val() == "") {
            layer.msg("请输入验证码");
            return false;
        }
        return true;
    }
    if (location.href == "http://localhost:8080/Page/register") {
        //注册页面
        if ($('#username').val() == "") {
            layer.msg("用户名不能为空");
            return false;
        } else if ($('#password').val() == "" || $('#password').val().length < 5 || $('#password').val().length > 16) {
            layer.msg("密码不能为空且长度在5-16位之间");
            return false;
        } else if ($('#stuid').val() != null) {
            if ($('#stuid').val() == "" || $('#stuid').val().length != 8) {
                layer.msg("ID不能为空且为纯数字且长度必须为8");
                return false;
            }
        } else if ($('email').val() == "" || !myEmail.test($('email').val())) {
            layer.msg("请检查邮箱格式");
            return false;
        } else if ($('passcode').val() == "") {
            layer.msg("请输入验证码");
            return false;
        }
        return true;
    }
    if (location.href == "http://localhost:8080/Page/apply") {
        //用户申请加入页面
        if ($('#username').val() == "") {
            layer.msg("请完善您的用户名");
            return false;
        } else if ($('#school').val() == "") {
            layer.msg("请检查您的学校信息");
            return false;
        } else if ($('#major').val() == "") {
            layer.msg("请完善您的专业信息");
            return false;
        } else if ($('#info').val() == "") {
            layer.msg("请完善您的个人简介");
            return false;
        } else if ($('#description').val() == "") {
            layer.msg("请完善您的特长信息");
            return false;
        } else if ($('#contactnum').val() == "") {
            layer.msg("请完善您的联系方式");
            return false;
        }
        return true;
    }

    if (location.href == "http://localhost:8080/Page/salegoods" || location.href == "http://localhost:8080/Page/buygoods"||location.href=="http://localhost:8080/Order/upload") {
        //出售二手 求购
        if ($('#title').val() == "") {
            layer.msg("请输入标题");
            return false;
        } else if ($('#detail').val() == "") {
            layer.msg("请输入介绍");
            return false;
        }
        else if ($('#count').val() == "") {
            layer.msg("请填写数量");
            return false;
        } else if ($('#pricost').val() == "") {
            layer.msg("请填写购买价格");
            return false;
        } else if ($('#status').val() == "") {
            layer.msg("请选择磨损程度");
            return false;
        } else if ($('#price').val() == "") {
            layer.msg("请输入价格");
            return false;
        } else if ($('#address').val() == "") {
            layer.msg("请输入交易地址");
            return false;
        } else if ($('#type').val() == "") {
            layer.msg("请选择科目");
            return false;
        }
        return true;
    }
    if (location.href == "http://localhost:8080/Page/info") {
        if($('#nickname').val()==""){
            layer.msg("用户名不可为空");
            return false;
        }else if($('#age').val()!=""&&($('#age').val()<15||$('#age').val()>35)){
            layer.msg("年龄应介于15-35岁之间");
            return false;
        }else if($('#sex').val()!=""&&($('#sex').val()!="男"&&$('#sex').val()!="女")){
            layer.msg("请在性别栏填写男/女");
            return false;
        }else if($('#phone').val()!=""&&!myPhone.test($('#phone').val())){
            layer.msg("请检查手机号码格式");
            return false;
        }else if($('#email').val()!=""&&!myEmail.test($('#email').val())){
            layer.msg("请检查邮箱格式");
            return false;
        }
        return true;
    }
    return true;

}

