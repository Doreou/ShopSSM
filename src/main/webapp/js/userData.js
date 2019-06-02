layui.use(['element','form'], function () {
    var element = layui.element;
    var form=layui.form;
});
var myBarChart = echarts.init(document.getElementById('chartbar'));
var myPieChart = echarts.init(document.getElementById('chartpie'));
var nums = [];
//初始化echarts实例
$(document).on('click','#searchBtn',function () {
    var type=$('#SearchType').val();
    if(type=="sex"){
        $.ajax({
            type: 'POST',
            url: '/Admin/getSexCount',
            success: function (msg) {
                myPieChart.setOption({
                    title: {
                        text: '全站男女用户图例--饼状图',
                        left: 'center',
                        textStyle: {
                            fontSize: '16'
                        }
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: "{a}{b} : {c}({d}%)"
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                        data: ['男', '女', '未填写'],
                    },
                    series: [{
                        type: 'pie',
                        radius: '50%',
                        center: ['50%', '50%'],
                        data: [{value: msg.man, name: '男'}, {value: msg.woman, name: '女'}, {value: msg.norecord, name: '未填写'}],
                    }],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0,0,0,0.5)'
                        }
                    }
                })


                myBarChart.setOption({
                    title: {
                        text: '全站男女用户图例--柱状图',
                        left: 'center',
                        textStyle: {
                            fontSize: '16'
                        }
                    },
                    legend: {
                        x: 'right',
                        y: 'top',
                        icon: 'circle',
                        data: ['数量'],
                    },
                    xAxis: {
                        data: ['男', '女', '未填写'],
                    },
                    yAxis: {},
                    series: [{
                        type: 'bar',
                        name: '数量',
                        barWidth: 80,
                        data: [msg.man, msg.woman, msg.norecord],
                        color: '#FF8000'
                    }],
                });
            }

        })
    }else{
        $.ajax({
            type: 'POST',
            url: '/Admin/getCertCount',
            success: function (msg) {
                myPieChart.setOption({
                    title: {
                        text: '全站认证用户图例--饼状图',
                        left: 'center',
                        textStyle: {
                            fontSize: '16'
                        }
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: "{a}{b} : {c}({d}%)"
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                        data: ['已认证', '未认证'],
                    },
                    series: [{
                        type: 'pie',
                        radius: '50%',
                        center: ['50%', '50%'],
                        data: [{value: msg.CertCount, name: '已认证'}, {value: msg.UnCertCount, name: '未认证'}, {value: msg.norecord, name: '未填写'}],
                    }],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0,0,0,0.5)'
                        }
                    }
                })


                myBarChart.setOption({
                    title: {
                        text: '全站认证用户图例--柱状图',
                        left: 'center',
                        textStyle: {
                            fontSize: '16'
                        }
                    },
                    legend: {
                        x: 'right',
                        y: 'top',
                        icon: 'circle',
                        data: ['数量'],
                    },
                    xAxis: {
                        data: ['已认证', '未认证'],
                    },
                    yAxis: {},
                    series: [{
                        type: 'bar',
                        name: '数量',
                        barWidth: 80,
                        data: [msg.CertCount, msg.UnCertCount],
                        color: '#FF8000'
                    }],
                });
            }

        })
    }
})

$(document).ready(function () {
    $('#searchBtn').click();
})