function deleteGoods(id) {
    $(document).on("click", '.deleteGoods', function () {
        var url = "/Order/deletegoods?goods_id=" + id;
        layer.confirm('商品删除后无法恢复且将从商城下架，确定删除吗？', {btn: ['确定', '取消'], title: "提示"}, function () {
            $.ajax({
                type: "post",
                url: url,
                success: function (data) {
                    if (data == "true") {
                        layer.msg("开票成功!", {
                            icon: 6,
                            time: 1000
                        }, function () {
                            location.reload();
                        });
                    } else {
                        layer.msg("失败！请重试");
                    }
                }
            });
        });

    });

}

function undercarriage(id, choice) {
    $(document).on("click", '.undercarriage', function () {
        var url = "/Order/undercarriage?goods_id=" + id + "&choice=" + choice;
        if (choice == 0) {
            layer.confirm('下架后仅您可查看您的发布记录中查看，确定下架吗？(您随时可以再次上架)', {btn: ['确定', '取消'], title: "提示"}, function () {
                $.ajax({
                    type: "post",
                    url: url,
                    success: function (data) {
                        if (data == "true") {
                            layer.msg("下架成功!", {
                                icon: 1,
                                time: 1000
                            }, function () {
                                location.reload();
                            });
                        } else {
                            layer.msg("失败！请重试");
                        }
                    }
                });
            });
        } else {
            layer.confirm('您将再次上架商品，确定继续吗？', {btn: ['确定', '取消'], title: "提示"}, function () {
                $.ajax({
                    type: "post",
                    url: url,
                    success: function (data) {
                        if (data == "true") {
                            layer.msg("上架成功!", {
                                icon: 1,
                                time: 1000
                            }, function () {
                                location.reload();
                            });
                        } else {
                            layer.msg("失败！请重试");
                        }
                    }
                });
            });
        }

    });

}