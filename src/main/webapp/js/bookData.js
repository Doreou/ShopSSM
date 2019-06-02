layui.use(['element', 'form'], function () {
    var element = layui.element;
    var form = layui.form;
});
var myLineChart = echarts.init(document.getElementById('chartline'));
var myPieChart = echarts.init(document.getElementById('chartpie'));



var classify = [];
var nums = [];
var seriesData = [];


$(document).on('click', '#searchBtn', function () {
    var type = $("#SearchType").val();
    classify = [];
    nums = [];
    seriesData = [];
//初始化echarts实例
    $.ajax({
        type: 'POST',
        url: '/Admin/getSubjectAnalysis?type=' + type,
        success: function (msg) {
            for (var i = 0; i < msg.subject.length; i++) {
                classify.push(msg.subject[i]);
                nums.push(msg.count[i]);
            }
            for (var i = 0; i < classify.length; i++) {
                var obj = new Object();
                obj.name = classify[i];
                obj.value = nums[i];
                seriesData[i] = obj;
            }

            myPieChart.setOption({
                title: {
                    text: '各分类图书数量--饼状图',
                    left: 'center',
                    textStyle:{
                        fontSize:'16'
                    }
                },
                tooltip : {
                    trigger : 'item',
                    formatter: "{a}{b} : {c} ({d}%)",
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: classify
                },
                series: [{
                    type: 'pie',
                    radius: '50%',
                    center: ['50%', '50%'],
                    data: seriesData,
                }],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0,0,0,0.5)'
                    }
                }
            })


            myLineChart.setOption({
                title: {
                    text: '各分类图书数量--柱状图',
                    left:'center',
                    textStyle:{
                        fontSize:'16'
                    }
                },
                legend:{
                    data:['数量'],
                    x:'right',
                    y:'top',
                    icon:'circle'
                },
                tooltip : {
                    trigger : 'axis',
                    showDelay : 0, // 显示延迟，添加显示延迟可以避免频繁切换，单位ms
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : 'shadow',        // 默认为直线，可选为：'line' | 'shadow'
                        barWidth:20
                    }
                },
                xAxis: {
                    type : 'category',
                    data: classify,
                    barCategoryGap:'20',
                    axisLabel:{
                        interval:0,
                        rotate:45,
                        textStyle:{
                            color:"black"
                        }
                    }
                },
                yAxis: {

                },
                series: [{
                    type: 'bar',
                    name:'数量',
                    data: nums,
                    barWidth:30,
                    color:'#FF8000'
                }],
                // grid: {
                //     top: 50,
                //     x: 20,
                //     //距离div右侧距离
                //     x2: 0,
                //     y2: 20
                // }
            });
        }

    })
})


//默认点击一次
$(document).ready(function () {
    $('#searchBtn').click();
})
