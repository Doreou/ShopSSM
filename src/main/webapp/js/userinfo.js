var permission = "";
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].user_permission;
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
        , url: '/Admin/getAllUserInfo'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'user_id', title: 'ID', width: 150, sort: true, fixed: 'left'}
            , {field: 'username', title: '姓名', width: 100}
            , {field: 'label', title: '签名', width: 100}
            , {field: 'sex', title: '性别', width: 100}
            , {field: 'age', title: '年龄', width: 100}
            , {field: 'join_time', title: '注册时间', width: 200,templet:function (d) {
                    var time=new Date(d.join_time);
                    return time.toLocaleDateString();
                }}
            , {field: 'icon', title: '头像', style:'height:38px',width: 150,templet:'<div><button onclick="Show(this);" class="layui-btn layui-btn-normal" id="table_button">点击查看<img style="display: none" src="{{d.icon}}"></button></div>'}
            , {field: 'member_status', title: '认证状态', width: 100,templet:function (d) {
                    if(d.member_status==1){
                        return "已认证";
                    }else{
                        return "未认证";
                    }
                }}
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'user_id'
            , type: 'asc'
        }
    });
    if(permission==1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                layer.msg('查看操作');
            } else if (layEvent === 'del') {
                layer.confirm('注销操作为重大安全操作，将提交给根管理员进一步审核。确定继续吗？', function (index) {
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
                location.href="/Page/admin_MessageToUser?userid="+data.user_id;
            }
        });
    }else {
        layer.msg("您仅有查看权限");
    }
})
function Show(param){
    var _this=$(param).find("img");
    imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
}
function imgShow(outerdiv, innerdiv, bigimg, _this){
    var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
    $('#big').attr("src", src);//设置#bigimg元素的src属性
    if(src==null||src=="undefined"){
        layer.alert("该用户未设置头像");
        return false;
    }

    /*获取当前点击图片的真实大小，并显示弹出层及大图*/
    $("<img/>").attr("src", src).load(function(){
        var windowW = $(window).width();//获取当前窗口宽度
        var windowH = $(window).height();//获取当前窗口高度
        var realWidth = this.width;//获取图片真实宽度
        var realHeight = this.height;//获取图片真实高度
        var imgWidth, imgHeight;
        var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放

        if(realHeight>windowH*scale) {//判断图片高度
            imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放
            imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度
            if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度
                imgWidth = windowW*scale;//再对宽度进行缩放
            }
        } else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度
            imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放
            imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度
        } else {//如果图片真实高度和宽度都符合要求，高宽不变
            imgWidth = realWidth;
            imgHeight = realHeight;
        }
        $('#big').css("width",imgWidth);//以最终的宽度对图片缩放

        var w = (windowW-imgWidth)/2;//计算图片与窗口左边距
        var h = (windowH-imgHeight)/2;//计算图片与窗口上边距
        $('#innerdiv').css({"top":h, "left":w});//设置#innerdiv的top和left属性
        $('#outerdiv').fadeIn("fast");//淡入显示#outerdiv及.pimg
    });

    $('#outerdiv').click(function(){//再次点击淡出消失弹出层
        $(this).fadeOut("fast");
    });
}