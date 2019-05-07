layui.use('element', function () {
    var element = layui.element;
});
var myLineChart = echarts.init(document.getElementById('chartline'));
var myPieChart = echarts.init(document.getElementById('chartpie'));
var option = {
    title:{
        text:'各分类图书数量'
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
var classify=[];
var nums=[];
var seriesData=[];
//初始化echarts实例
$.ajax({
    type:'POST',
    url:'/Admin/getSubjectAnalysis',
    success:function (msg) {
        for(var i=0;i<msg.subject.length;i++){
            classify.push(msg.subject[i]);
            nums.push(msg.count[i]);
        }
        for(var i=0;i<classify.length;i++){
            var obj=new Object();
            obj.name=classify[i];
            obj.value=nums[i];
            seriesData[i]=obj;
        }
        myPieChart.setOption({
            title:{
                text:'各分类图书数量--饼状图',
                left:'20%',
                top:'10%'
            },
            tooltip:{trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"  },
            legend:{
                orient:'vertical',
                left:'center',
                bottom:'bottom',
                data:classify
            },
            series:[{
                type:'pie',
                radius:'50%',
                center:['50%','50%'],
                data:seriesData,
            }],
            itemStyle:{
                emphasis:{
                    shadowBlur:10,
                    shadowOffsetX:0,
                    shadowColor:'rgba(0,0,0,0.5)'
                }
            }
        })



        myLineChart.setOption({
            title:{
                text:'各分类图书数量--折线图'
            },
            xAxis: {
                data: classify,
            },
            yAxis:{

            },
            series:[{
                type:'line',
                data:nums
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
