//上传控制图层js控制器
$("#change_ph").bind("click", function () {
    $('.tailoring-container').attr("style", "display:block");
});

$('#modal1').bind("click", function () {
    $('.tailoring-container').attr("style", "display:block");
});

$(".close-tailoring").bind("click", function () {
    $('.tailoring-container').attr("style", "display:none");
});
//结束

//提交身份验证界面
$('.webuploader-pick').bind("click", function () {
    $('.tailoring-container').attr("style", "display:block");
});

$(".close-tailoring").bind("click", function () {
    $('.tailoring-container').attr("style", "display:none");
});
$('.close').bind("click", function () {
    $('#closealert').attr("style", "display:none");
});
//用户头像覆盖与移出
$("#origin_ph").bind("mouseenter", function () {
    $('#change_ph').attr("style", "display:block");
});
$("#change_ph").bind("mouseleave", function () {
    $('#change_ph').attr("style", "display:none");
});

function selectImg(file) {
    var reader = new FileReader();
    reader.onload = function (evt) {
        var replaceSrc = evt.target.result;
        // 更换cropper的图片
        $('#tailoringImg').cropper('replace', replaceSrc);// 默认false，适应高度，不失真
    }
    reader.readAsDataURL(file.files[0]);
}

// cropper图片裁剪
$('#tailoringImg').cropper({
    aspectRatio: 1 / 1,// 默认比例
    preview: '.previewImg',// 预览视图
    guides: false, // 裁剪框的虚线(九宫格)
    autoCropArea: 0.5, // 0-1之间的数值，定义自动剪裁区域的大小，默认0.8
    movable: false, // 是否允许移动图片
    dragCrop: true, // 是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
    movable: true, // 是否允许移动剪裁框
    resizable: true, // 是否允许改变裁剪框的大小
    zoomable: true, // 是否允许缩放图片大小
    mouseWheelZoom: true, // 是否允许通过鼠标滚轮来缩放图片
    touchDragZoom: true, // 是否允许通过触摸移动来缩放图片
    rotatable: true, // 是否允许旋转图片
    crop: function (e) {
        // 输出结果数据裁剪图像。
    }
});
// 旋转
$(".cropper-rotate-btn").on("click", function () {
    $('#tailoringImg').cropper("rotate", 45);
});
// 复位
$(".cropper-reset-btn").on("click", function () {
    $('#tailoringImg').cropper("reset");
});
// 换向
var flagX = true;
$(".cropper-scaleX-btn").on("click", function () {
    if (flagX) {
        $('#tailoringImg').cropper("scaleX", -1);
        flagX = false;
    } else {
        $('#tailoringImg').cropper("scaleX", 1);
        flagX = true;
    }
    flagX != flagX;
});