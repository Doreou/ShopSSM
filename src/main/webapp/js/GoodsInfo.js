layui.use(['carousel', 'form'], function () {
    var carousel = layui.carousel
        , form = layui.form;

    //常规轮播
    carousel.render({
        elem: '#test1'
        , arrow: 'always'
    });
    $.ajax({
        type: 'POST',
        url: '/Report/getAllReportType',
        success: function (msg) {
            for (var i = 0; i < msg.data.length; i++) {
                $("#report_type").append(new Option(msg.data[i].report_type, msg.data[i].report_type));
            }
            form.render("select");
        }
    })
});
layui.use('upload', function(){
    var upload = layui.upload;

    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadIcon' //绑定元素
        ,url: '/Report/uploadIcon' //上传接口
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
function SaleReport(goods_id) {
    $.ajax({
        type:'POST',
        url:'/Report/isLogin',
        success:function (msg) {
            if(msg=="success"){
                layer.open({
                    type:1,
                    title:"举报该商品",
                    area:['470px','470px'],
                    content:$('#popReport'),
                    btn:['举报','取消'],
                    yes:function () {
                        $.ajax({
                            type:'POST',
                            url:'/Report/SaleReport',
                            data:{fileLocation:$('#fileLocation').val(),report_type:$('#report_type').val(),
                                report_content:$('#report_content').val(),goods_id:goods_id},
                            success:function (msg) {
                                layer.closeAll();
                                layer.msg(msg);
                            }
                        })
                    }
                })
            }
            else {
                layer.msg(msg);
            }
        }
    })
}