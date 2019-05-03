layui.use('element', function () {
    var element = layui.element;
});
layui.use('table', function () {
    var table = layui.table;

    //第一个实例
    table.render({
        elem: '#demo'
        , height: 520
        , url: '/Cert/getAllCert'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'cert_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
            , {field: 'user_id', title: '用户ID', width: 100}
            , {
                field: 'up_time', title: '用户提交日期', width: 100, templet: function (d) {
                    var time = new Date(d.up_time);
                    return time.toLocaleDateString();
                }
            }
            , {field: 'user_name', title: '用户姓名', width: 100}
            , {
                field: 'cert_pic',
                title: '证件信息',
                width: 130,
                templet: '<div><button onclick="Show(this);" class="layui-btn layui-btn-normal" id="table_button">点击查看<img style="display: none" src="{{d.cert_pic}}"></button></div>',
                align: 'center'
            }
            , {field: 'adm_id', title: '审核管理员ID', width: 100}
            , {field: 'adm_time', title: '审核时间', width: 100,templet:function (d) {
                if(d.adm_time!=null){
                    var time=new Date(d.adm_time);
                    return time.toLocaleDateString();
                }else
                    return "暂未回复";

                }}
            , {
                field: 'status', title: '认证状态', width: 100, templet: function (d) {
                    if (d.status == 0)
                        return "未认证";
                    else
                        return "已通过";
                }
            }
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        ,initSort: {
            field: 'cert_id'
            , type: 'asc'
        }

    });
    table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
            , layEvent = obj.event; //获得 lay-event 对应的值
        if (layEvent === 'detail') {
            var certid=data.cert_id;
            $.ajax({
                type:'POST',
                url:'/Cert/getOneCert?certid='+certid,
                success:function (msg) {
                    $('#cert_id').val(certid);
                    $('#user_id').val(msg.data[0].user_id);
                    $('#user_name').val(msg.data[0].user_name);
                    $('#certPreview').attr('src',msg.data[0].cert_pic);
                    var time=new Date(msg.data[0].up_time);
                    $('#time').val(time.toLocaleDateString());
                }
            })
            layer.open({
                type: 1,
                title: "查看用户证明",
                area: ['470px', '470px'],
                content: $("#popCertInfo"),
                btn: ['通过', '拒绝','暂不回复'],
                yes:function () {
                    if(data.adm_id!=null){
                        layer.msg("已回复");
                        return false;
                    }
                    layer.open({
                        type:1,
                        title:'提醒',
                        content:'通过后，系统将自动向该用户发送通知，您也可以选择自定义通知',
                        btn:['发送默认通知','自定义通知'],
                        yes:function () {
                            layer.confirm('您将通过该用户的认证请求，请务必确认用户资料!', function (index) {
                                layer.close(index);
                                //向服务端发送删除指令
                                $.ajax({
                                    type: 'post',
                                    url: '/Cert/updateCertStatus?certid=' + certid,
                                    data:'reciever='+data.user_id,
                                    success: function (msg) {
                                        obj.update({
                                            status:1,
                                        });
                                        layer.closeAll();
                                        layer.msg(msg);
                                    }
                                })
                            });
                        },
                        btn2:function () {
                            layer.open({
                                async:false,
                                type:1,
                                title:'自定义通知',
                                content:$('#popMessage'),
                                area:['455px','360px'],
                                btn:["确定","取消"],
                                yes:function () {
                                    layer.confirm('您将通过该用户的认证请求，请务必确认用户资料!', function (index) {
                                        layer.close(index);
                                        //向服务端发送删除指令
                                        $.ajax({
                                            type: 'post',
                                            url: '/Cert/updateCertStatus?certid=' + certid,
                                            data:"message_title="+$('#message_title').val()+"&message_content="+$('#message_content').val()+"&message_tip="+$('#message_tip').val()+"&reciever="+data.user_id,
                                            success: function (msg) {
                                                obj.update({
                                                    status:1,
                                                });
                                                layer.closeAll();
                                                layer.msg(msg);
                                            }
                                        })
                                    });
                                }
                            })
                        }
                    })
                },
                btn2:function () {
                    if(data.adm_id!=null){
                        layer.msg("已回复");
                        return false;
                    }
                    layer.open({
                        type:1,
                        title:'提醒',
                        content:'拒绝后，系统将自动向该用户发送通知，您也可以选择自定义通知',
                        btn:['发送默认通知','自定义通知'],
                        yes:function () {
                            layer.confirm('您将拒绝该用户的认证请求，确定吗？', function (index) {
                                obj.del(); //删除对应行（tr）的DOM结构
                                layer.close(index);
                                //向服务端发送删除指令
                                $.ajax({
                                    type: 'post',
                                    url: '/Cert/deleteCert?certid=' + certid,
                                    data:'reciever='+data.user_id,
                                    success: function (msg) {
                                        layer.msg(msg);
                                    }
                                })
                            });
                        },
                        btn2:function () {
                            layer.open({
                                async:false,
                                type:1,
                                title:'自定义通知',
                                content:$('#popMessage'),
                                area:['455px','360px'],
                                btn:["确定","取消"],
                                yes:function () {
                                    layer.confirm('您将拒绝该用户的认证请求，确定吗？', function (index) {
                                        obj.del(); //删除对应行（tr）的DOM结构
                                        layer.close(index);
                                        //向服务端发送删除指令
                                        $.ajax({
                                            type: 'post',
                                            url: '/Cert/deleteCert?certid=' + certid,
                                            data:"message_title="+$('#message_title').val()+"&message_content="+$('#message_content').val()+"&message_tip="+$('#message_tip').val()+"&reciever="+data.user_id,
                                            success: function (msg) {
                                                layer.msg(msg);
                                            }
                                        })
                                    });
                                }
                            })
                        }
                    })
                },
                btn3:function () {
                    if(data.adm_id!=null){
                        layer.msg("已回复");
                        return false;
                    }
                    layer.msg("请在24小时内给予答复!");
                }
            })
        }
    });
});
function Show(param){
    var _this=$(param).find("img");
    imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
}
$(function() {
    $(".pimg").click(function() {
        var _this = $(this); //将当前的pimg元素作为_this传入函数
        imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
    });
});
function imgShow(outerdiv, innerdiv, bigimg, _this){
    var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
    $('#big').attr("src", src);//设置#bigimg元素的src属性

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