$.ajax({
    type:'POST',
    url:'/Page/getTotal',
    success:function (msg) {
        $('#js-numberrock').html(msg);
    }
})
if($('#user_id').val()!=""&&$('#user_id').val()!=null) {
    $.ajax({
        type: 'POST',
        url: '/Page/getMySaleCount?user_id='+$('#user_id').val(),
        success: function (msg) {
            $('#sell').html(msg);
        }
    })
    $.ajax({
        type: 'POST',
        url: '/Page/getMyBuyCount?user_id='+$('#user_id').val(),
        success: function (msg) {
            $('#buy').html(msg);
        }
    })
    $.ajax({
        type: 'POST',
        url: '/Page/getMyFinishedOrderCount?user_id='+$('#user_id').val(),
        success: function (msg) {
            $('#AlreadySold').html(msg);
        }
    })
}