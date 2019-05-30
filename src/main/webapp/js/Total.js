$.ajax({
    type:'POST',
    url:'/Page/getTotal',
    success:function (msg) {
        $('#js-numberrock').html(msg);
    }
})