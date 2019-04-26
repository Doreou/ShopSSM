layui.use('element', function () {
    var element = layui.element;
});
layui.use('form', function () {
    var form = layui.form;
    form.on('radio',function (data) {
        $('#people').val(data.value);
    })
    form.on('checkbox',function (data) {
        $('#ischeck').val(data.elem.checked);
    })

});
layui.use('laydate', function () {
    var laydate = layui.laydate;
    laydate.render({
        elem: '#sendTime', //指定元素
        trigger:'click',
        min:0,//可选中的最早日期限制为今日
    });
});
function getUserName() {
    $.ajax({
        type:'POST',
        url:'/User/getById',
        data:{id:$('#reciever').val()},
        success:function (msg) {
            if(msg!="未找到!") {
                $('#warn').html("找到用户！请确认昵称");
                $('#username').val(msg);
            }else{
                $('#warn').html("未找到该用户！请检查用户ID");
                $('#warn').attr("style","color:red !important");
            }
        }
    })
}
$('#readbtn').click(function () {

    $.ajax({
        type:'POST',
        url:'/Order/AlreadyRead?message_id='+$('#read').val()+'&status=1',
        success:function (msg) {
            layer.msg(msg,{
                icon: 1,
                time: 1000
            }, function () {
                location.reload();
            });

        }
    })
})
$('#unreadbtn').click(function () {
    $.ajax({
        type:'POST',
        url:'/Order/AlreadyRead?message_id='+$('#unread').val()+'&status=0',
        success:function (msg) {
            layer.msg(msg,{
                icon: 1,
                time: 1000
            }, function () {
                location.reload();
            });
        }
    })
})


