layui.use(['element', 'form'], function () {
    var element = layui.element;
    var form = layui.form;
    $.ajax({
        type: 'POST',
        url: '/Report/getAllReportType',
        success: function (msg) {
            for (var i = 0; i < msg.data.length; i++) {
                $("#SearchMessage_type").append(new Option(msg.data[i].report_type, msg.data[i].report_type));
            }
            form.render("select");
        }
    })
});
layui.use('laydate', function () {
    var laydate = layui.laydate;
    laydate.render({
        elem: '#SearchReport_time', //指定元素
        trigger: 'click',
    });
});
layui.use('table', function () {
    var table = layui.table;

    //第一个实例
    table.render({
        elem: '#demo'
        , height: 520
        , url: '/Report/getAllReport'//数据接口
        , toolbar: '#bardemo'
        , page: true
        , request: {
            pageName: 'curr' //页码的参数名称，默认：page
            , limitName: 'nums' //每页数据量的参数名，默认：limit
        }
        , cols: [[ //表头
            {field: 'report_id', style: 'height:38px', title: 'ID', width: 80, sort: true}
            , {field: 'report_userid', title: '举报人', width: 100}
            , {field: 'report_content', title: '举报理由', width: 200}
            , {field: 'report_type', title: '举报类型', width: 100}
            , {field: 'bereported_goodsid', title: '被举报商品', width: 100}
            , {
                field: 'report_pic',
                style: 'height:38px',
                title: '证明',
                width: 150,
                templet: '<div><button onclick="Show(this);" class="layui-btn layui-btn-normal" id="table_button">点击查看<img style="display: none" src="{{d.report_pic}}"></button></div>',
                align: 'center'
            }
            , {field: 'bereported_userid', title: '被举报人', width: 100}
            , {
                field: 'report_time', title: '举报时间', width: 100, templet: function (d) {
                    var time = new Date(d.report_time);
                    return time.toLocaleDateString();
                }
            }
            , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
        ]]
        , initSort: {
            field: 'report_id'
            , type: 'asc'
        }
    });
    active = {
        reload: function () {
            var ID = $('#SearchID').val();
            var ID1 = $('#SearchID').val();
            var report_time = $('#SearchReport_time').val();
            var report_type = $('#SearchReport_type').val();
            table.reload('demo', {
                page: {
                    curr: 1,
                },
                where: {
                    report_userid: ID1,
                    bereported_userid: ID,
                    report_type: report_type,
                    report_time: report_time
                }
            })
        }
    };
    $('#searchBtn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        var data = obj.data //获得当前行数据
            , layEvent = obj.event; //获得 lay-event 对应的值
        var time = new Date(data.report_time);
        if (layEvent === 'detail') {
            $('#report_id').val(data.report_id);
            $('#report_content').val(data.report_content);
            $('#report_type').val(data.report_type);
            $('#report_time').val(time.toLocaleDateString());
            $('#bereported_goodsid').val(data.bereported_goodsid);
            $('#report_userid').val(data.report_userid);
            $('#bereported_userid').val(data.bereported_userid);
            $('#report_pic').attr('src', data.report_pic);
            layer.open({
                type: 1,
                title: '举报信息',
                area: ['800px', '500px'],
                content: $('#popReportInfo'),
                btn: ['处理', '忽略'],
                yes: function () {

                },
                btn2: function () {

                }

            })
        }
        else if (layEvent === "bereported_goods") {
            var goods_id = data.bereported_goodsid;
            window.open('http://localhost:8080/Order/getgoodsinfo?id=' + goods_id);
        }
    })
})

function Show(param) {
    var _this = $(param).find("img");
    imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
}

$(function () {
    $(".pimg").click(function () {
        var _this = $(this); //将当前的pimg元素作为_this传入函数
        imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
    });
});

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