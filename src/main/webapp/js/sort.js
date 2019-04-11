var type=$('#hiddentype').val();
$('.icon-px-').on('click',function () {
    //取消选中
    $('.icon-px-').attr('style','font-size: 12px;color:#8C8C8C');
    //更新被选中
    $(this).attr('style','font-size: 12px;color: #F10');
})

function orderByTime(way) {
    var url='/Order/orderbytime?way='+way+'&type='+type;
    $.ajax({
        type:'post',
        url:url,
        success:function (msg) {
            $('#dataform').html(msg);
            if(way=="desc") {
                $('#way').val("asc");
            }else{
                $('#way').val("desc");
            }
        }
    })

}
function orderByHot(way) {
    var url='/Order/orderbyhot?way='+way+'&type='+type;
    $.ajax({
        type:'post',
        url:url,
        success:function (msg) {
            $('#dataform').html(msg);
            if($('#way').val()=="desc") {
                $('#way').val("asc");
            }else{
                $('#way').val("desc");
            }
        }
    })


}
function orderByPrice(way) {
    var url='/Order/orderbyprice?way='+way+'&type='+type;
    $.ajax({
        type:'post',
        url:url,
        success:function (msg) {
            $('#dataform').html(msg);
            if($('#way').val()=="desc") {
                $('#way').val("asc");
            }else{
                $('#way').val("desc");
            }
        }
    })


}