var permission = "";
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].goods_permission;
    }
})
layui.use('form', function () {
    var form = layui.form;
    $.ajax({
        type: 'POST',
        url: '/Admin/getSubject',
        success: function (msg) {
            for (var i = 0; i < msg.data.length; i++) {
                $('#subject').append(new Option(msg.data[i].subject, msg.data[i].subject));
            }
            form.render('select');
        }
    })
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
        , url: '/Admin/getAllGoods'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'goods_id', title: 'ID', width: 80, sort: true, fixed: 'left'}
            , {field: 'goods_title', title: '标题', width: 100}
            , {field: 'introduce', title: '介绍', width: 100}
            , {field: 'subject', title: '科目', width: 100}
            , {field: 'pri_cost', title: '原价', width: 100}
            , {field: 'expt_price', title: '价格', width: 100}
            , {field: 'owner_id', title: '持有人', width: 100}
            , {field: 'status', title: '磨损', width: 100}
            , {field: 'number', title: '数量', width: 100}
            , {
                field: 'time', title: '上架时间', width: 100, templet: function (d) {
                    var time = new Date(d.time);
                    return time.toLocaleDateString();
                }
            }
            , {
                field: 'cover',
                title: '封面',
                width: 130,
                templet: '<div><button onclick="Show(this);" class="layui-btn layui-btn-normal" id="table_button">点击查看<img style="display: none" src="{{d.cover}}"></button></div>'
            }
            , {
                field: 'isundercarriage', title: '在架', width: 100, templet: function (d) {
                    if (d.isundercarriage == 1)
                        return "是";
                    else
                        return "否";
                }
            }
            , {field: 'clickcount', title: '点击次数', width: 100}
            , {field: 'collectcount', title: '收藏量', width: 100}
            , {field: 'type', title: '类型', width: 100}
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'goods_id'
            , type: 'asc'
        }
    });
    if (permission == 1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event;
            if (layEvent === "edit") {
                layer.open({
                    type: 1,
                    title: '图书信息',
                    content: '请选择您的操作：',
                    btn: ['下架商品', '修改商品信息'],
                    yes: function () {
                        layer.confirm('确认要下架该商品吗？', function (index) {
                            layer.open({
                                type: 1,
                                title: '请填写下架理由',
                                content: $('#underCarriage_Reason'),
                                area: ['300px', '300px'],
                                btn: ['确认下架', '取消'],
                                yes: function () {
                                    if ($('#underCarriage_Reason').val() == "") {
                                        layer.msg("请填写下架理由");
                                    } else {
                                        layer.close(index);
                                        //向服务端发送删除指令
                                        $.ajax({
                                            type: 'post',
                                            url: '/Admin/underCarriage?goods_id=' + data.goods_id,
                                            data: 'reason=' + $('#underCarriage_Reason').val(),
                                            success: function (msg) {
                                                obj.update({
                                                    isundercarriage: 0,
                                                });
                                                layer.closeAll();
                                                layer.msg(msg);
                                            }
                                        })
                                    }
                                },
                                btn2: function (index) {
                                    layer.close(index);
                                }
                            })
                        });
                    },
                    btn2: function () {
                        $('#goods_id').val(data.goods_id);
                        $('#cover').val(data.cover);
                        $('#goods_title').val(data.goods_title);
                        $('#introduce').val(data.introduce);
                        $('#goods_pic').attr('src', data.cover);
                        layui.use('form', function () {
                            var form = layui.form;
                            $('#subject').val(data.subject);
                            form.render('select');
                        })
                        layer.open({
                            type: 1,
                            title: '商品信息',
                            area: ['800px', '470px'],
                            content: $('#popGoodsInfo'),
                            btn: ['确认修改', '取消'],
                            yes: function () {
                                layer.open({
                                    type: 1,
                                    title: '请填写修改原因',
                                    content: $('#underCarriage_Reason'),
                                    area: ['300px', '300px'],
                                    btn: ['确认修改', '取消'],
                                    yes: function () {
                                        if ($('#underCarriage_Reason').val() == "") {
                                            layer.msg("请填写修改原因");
                                        } else {
                                            //向服务端发送删除指令
                                            $.ajax({
                                                type: 'POST',
                                                url: '/Admin/updateGoodsInfo',
                                                data: $('#popform').serialize()+'&reason='+$('#underCarriage_Reason').val(),
                                                success: function (msg) {
                                                    layer.closeAll();
                                                    layer.msg(msg);
                                                }
                                            })
                                        }
                                    },
                                    btn2: function (index) {
                                        layer.close(index);
                                    }
                                })
                            },
                            btn2: function () {
                                layer.close();
                            }
                        })
                    }
                })
            } else if (layEvent === "del") {
                layer.confirm('确认要删除该商品吗？', function (index) {
                    layer.open({
                        type: 1,
                        title: '请填写删除理由',
                        content: $('#underCarriage_Reason'),
                        area: ['300px', '300px'],
                        btn: ['确认删除', '取消'],
                        yes: function () {
                            if ($('#underCarriage_Reason').val() == "") {
                                layer.msg("请填写删除理由");
                            } else {
                                layer.close(index);
                                obj.del();
                                //向服务端发送删除指令
                                $.ajax({
                                    type: 'post',
                                    url: '/Admin/deleteGoods?goods_id=' + data.goods_id,
                                    data: 'reason=' + $('#underCarriage_Reason').val(),
                                    success: function (msg) {
                                        layer.closeAll();
                                        layer.msg(msg);
                                    }
                                })
                            }
                        }
                    })
                });
            }

        })
    }
})


function Show(param) {
    var _this = $(param).find("img");
    imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
}

function imgShow(outerdiv, innerdiv, bigimg, _this) {
    var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
    $('#big').attr("src", src);//设置#bigimg元素的src属性

    /*获取当前点击图片的真实大小，并显示弹出层及大图*/
    $("<img/>").attr("src", src).load(function () {
        var windowW = $(window).width();//获取当前窗口宽度
        var windowH = $(window).height();//获取当前窗口高度
        var realWidth = this.width;//获取图片真实宽度
        var realHeight = this.height;//获取图片真实高度
        var imgWidth, imgHeight;
        var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放

        if (realHeight > windowH * scale) {//判断图片高度
            imgHeight = windowH * scale;//如大于窗口高度，图片高度进行缩放
            imgWidth = imgHeight / realHeight * realWidth;//等比例缩放宽度
            if (imgWidth > windowW * scale) {//如宽度扔大于窗口宽度
                imgWidth = windowW * scale;//再对宽度进行缩放
            }
        } else if (realWidth > windowW * scale) {//如图片高度合适，判断图片宽度
            imgWidth = windowW * scale;//如大于窗口宽度，图片宽度进行缩放
            imgHeight = imgWidth / realWidth * realHeight;//等比例缩放高度
        } else {//如果图片真实高度和宽度都符合要求，高宽不变
            imgWidth = realWidth;
            imgHeight = realHeight;
        }
        $('#big').css("width", imgWidth);//以最终的宽度对图片缩放

        var w = (windowW - imgWidth) / 2;//计算图片与窗口左边距
        var h = (windowH - imgHeight) / 2;//计算图片与窗口上边距
        $('#innerdiv').css({"top": h, "left": w});//设置#innerdiv的top和left属性
        $('#outerdiv').fadeIn("fast");//淡入显示#outerdiv及.pimg
    });

    $('#outerdiv').click(function () {//再次点击淡出消失弹出层
        $(this).fadeOut("fast");
    });
}

layui.use('upload', function () {
    var upload = layui.upload;

    //执行实例
    var uploadInst = upload.render({
        elem: '#updateCover' //绑定元素
        , url: '/Admin/updateGoodsCover' //上传接口
        , done: function (res) {
            //上传完毕回调
            $('#cover').val(res.data[0]);
            $('#goods_pic').attr('src', res.data[0]);
            $('#goods_pic').attr('style', 'display:block;background:#5A5A5A');
            layer.msg(res.msg);
        }
        , error: function () {
            //请求异常回调
            layer.msg("上传失败，请稍后再试");
        }
    });
});
