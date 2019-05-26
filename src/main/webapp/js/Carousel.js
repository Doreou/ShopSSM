var permission = "";
$.ajax({
    type: 'POST',
    url: '/Admin/getPermission',
    success: function (msg) {
        permission = msg.data[0].carousel_permission;
    }
})
layui.use('form', function () {
    var form = layui.form;
    form.on('radio', function (data) {
        $('#visible1').val(data.value);
        $('#visible').val(data.value);
    })

});
layui.use('element', function () {
    var element = layui.element;
});
layui.use('laydate', function () {
    var laydate = layui.laydate;
    laydate.render({
        elem: '#start', //指定元素
        trigger:'click',
        min:0,//可选中的最早日期限制为今日
    });
    laydate.render({
        elem: '#end', //指定元素
        trigger:'click',
        min:0,//可选中的最早日期限制为今日
    });
    laydate.render({
        elem: '#start1', //指定元素
        trigger:'click',
        min:0,//可选中的最早日期限制为今日
    });
    laydate.render({
        elem: '#end1', //指定元素
        trigger:'click',
        min:0,//可选中的最早日期限制为今日
    });
    laydate.render({
        elem: '#SearchCarouselBegin', //指定元素
        trigger:'click',
    });
    laydate.render({
        elem: '#SearchCarouselEnd', //指定元素
        trigger:'click',
    });
});
layui.use('table', function () {
    var table = layui.table;

    //第一个实例
    table.render({
        elem: '#demo'
        , height: 520
        , url: '/Admin/getAllCarousel'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'carousel_id',style:'height:38px', title: 'ID', width: 80, sort: true}
            , {field: 'carousel_pic',style:'height:38px', title: '轮播图', width: 130,templet:'<div><button onclick="Show(this);" class="layui-btn layui-btn-normal" id="table_button">点击查看<img style="display: none" src="{{d.carousel_pic}}"></button></div>'}
            , {field: 'carousel_info', title: '轮播图描述', width: 100}
            , {field: 'carousel_start', title: '开始时间', width: 100,templet:function (d) {
                    var time=new Date(d.carousel_start);
                    return time.toLocaleDateString();
                }}
            , {field: 'carousel_end', title: '结束时间', width: 100,templet:function (d) {
                    var time=new Date(d.carousel_end);
                    return time.toLocaleDateString();
                }}
            , {field: 'carousel_visible', title: '当前是否可见', width: 150,templet:function (d) {
                    if(d.carousel_visible)
                        return "是";
                    else
                        return "否";
                }}
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'carousel_id'
            , type: 'asc'
        }
    });
    active={
        reload:function () {
            var Carousel=$('#SearchCarousel').val();
            var CarouselBegin=$('#SearchCarouselBegin').val();
            var CarouselEnd=$('#SearchCarouselEnd').val();
            table.reload('demo',{
                page:{
                    curr:1,
                },
                where:{
                    carousel_info:Carousel,
                    carousel_start:CarouselBegin,
                    carousel_end:CarouselEnd
                }
            })
        }
    };
    $('#searchBtn').on('click', function(){
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });
    if(permission==1) {
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                layer.msg('查看操作');
            } else if (layEvent === 'del') {
                layer.confirm('确定删除已轮播图？', function (index) {
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        type: 'post',
                        url: '/Admin/deleteCarousel?carousel_id=' + data.carousel_id,
                        success: function (msg) {
                            layer.msg(msg);
                        }

                    })
                });
            } else if (layEvent === 'edit') {
                //修改前显示旧信息
                $('#carousel_id').val(data.carousel_id);
                $('#carousel_info1').val(data.carousel_info);
                $('#start1').val(data.carousel_start);
                $('#end1').val(data.carousel_end);
                $('#priviewIcon1').attr('src',data.carousel_pic);
                $('#fileLocation1').val(data.carousel_pic);
                layui.use('form',function () {
                    var form = layui.form;
                    if(data.carousel_visible==1){
                        $("input[name='classify'][value='可见']").attr("checked",'true');
                        $('#visible1').val("可见");
                    }else {
                        $("input[name='classify'][value='不可见']").attr("checked",'true');
                        $('#visible1').val("不可见");
                    }
                    form.render();
                });
                layer.open({
                    type: 1,
                    title: "修改分类信息",
                    area: ['800px', '700px'],
                    content: $("#popUpdate"),
                    btn: ['确定', '重置'],
                    yes: function () {
                        //异步修改
                        $.ajax({
                            type: 'post',
                            url: '/Admin/updateCarousel',
                            data: $('#popform1').serialize(),
                            success: function (msg) {
                                layer.closeAll();
                                layer.msg(msg);
                                obj.update({});
                            }
                        })
                    },
                    btn2: function () {
                        $('#carousel_info').val("");
                        $('#start').val("");
                        $("#end").val("");
                        $("#fileLocation").val("");
                        $("#priviewIcon").attr("src", "");
                        //禁止图层关闭
                        return false;
                    }
                });

            }
        });
    }else {
        layer.msg('您仅有查看权限');

    }
})

function addNewCarousel() {
    if(permission==1) {
        layer.open({
            type: 1,
            title: '添加轮播图',
            area: ['450px', '330px'],
            content: $("#popInsert"),
            btn: ['确定', '重置'],
            yes: function () {
                $.ajax({
                    type: 'POST',
                    url: '/Admin/addNewCarousel',
                    data: 'info=' + $('#carousel_info').val() + "&start=" + $('#start').val() +
                    "&end=" + $('#end').val() +"&visible="+$('#visible').val()+ "&fileLocation=" + $('#fileLocation').val(),
                    success: function (msg) {
                        layer.closeAll();
                        layer.msg(msg + "请刷新后查看");
                    }
                })
            },
            btn2: function () {
                $('#carousel_info').val("");
                $('#start').val("");
                $("#end").val("");
                $("#fileLocation").val("");
                $("#priviewIcon").attr("src", "");
                return false;
            }

        })
    }else {
        layer.msg('您无权进行此操作');
    }
}
layui.use('upload', function(){
    var upload = layui.upload;

    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadIcon1' //绑定元素
        ,url: '/Admin/uploadCarousel' //上传接口
        ,done: function(res){
            //上传完毕回调
            $('#fileLocation1').val(res.data[0]);
            $('#priviewIcon1').attr('src',res.data[0]);
            $('#priviewIcon1').attr('style','display:block;background:#5A5A5A');
            layer.msg(res.msg);
        }
        ,error: function(){
            //请求异常回调
            layer.msg("上传失败，请稍后再试");
        }
    });
});

layui.use('upload', function(){
    var upload = layui.upload;

    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadIcon' //绑定元素
        ,url: '/Admin/uploadCarousel' //上传接口
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
function Show(param){
    var _this=$(param).find("img");
    imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
}
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