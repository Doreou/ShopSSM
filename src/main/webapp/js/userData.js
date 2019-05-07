layui.use('element', function () {
    var element = layui.element;
});
var myBarChart = echarts.init(document.getElementById('chartbar'));
var myPieChart = echarts.init(document.getElementById('chartpie'));
var option = {
    title:{
        text:'全站男女用户图例'
    },
    tooltip:{},
    legend:{
        data:['用户来源']
    },
    xAxis:{

    },
    yAxis:{

    },
    series:[{
        name:'访问量',
        type:'line',
        data:[]
    }],
};
var nums=[];
//初始化echarts实例
$.ajax({
    type:'POST',
    url:'/Admin/getSexCount',
    success:function (msg) {
        myPieChart.setOption({
            title:{
                text:'全站男女用户图例--饼状图',
            },
            tooltip:{trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"  },
            legend:{
                orient:'vertical',
                left:'center',
                bottom:'bottom',
                data: ['男','女','未填写'],
            },
            series:[{
                type:'pie',
                radius:'50%',
                center:['50%','50%'],
                data:[{value:msg.man,name:'男'},{value:msg.woman,name:'女'},{value:msg.norecord,name:'未填写'}],
            }],
            itemStyle:{
                emphasis:{
                    shadowBlur:10,
                    shadowOffsetX:0,
                    shadowColor:'rgba(0,0,0,0.5)'
                }
            }
        })



        myBarChart.setOption({
            title:{
                text:'全站男女用户图例--条形图'
            },
            xAxis: {
                data: ['男','女','未填写'],
            },
            yAxis:{

            },
            series:[{
                type:'bar',
                data:[msg.man,msg.woman,msg.norecord]
            }],
            grid:{
                top:50,
                x:20,
                //距离div右侧距离
                x2:0,
                y2:20
            }
        });
    }

})

//使用制定的配置项和数据显示图表
