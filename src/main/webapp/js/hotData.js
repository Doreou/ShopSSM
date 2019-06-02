layui.use('element', function () {
    var element = layui.element;
});
var myLineChart = echarts.init(document.getElementById('chartline'));
var myPieChart = echarts.init(document.getElementById('chartpie'));

var classify=[];
var nums=[];
var seriesData=[];
//初始化echarts实例
$.ajax({
    type:'POST',
    url:'/Admin/getHotAnalysis',
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
                text:'各科目图书热度--饼状图',
                left:'center',
                textStyle:{
                    fontSize:'16'
                }
            },
            tooltip:{trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"  },
            legend:{
                orient:'vertical',
                left:'left',
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
                text:'各科目图书热度--柱状图',
                left:'center',
                textStyle:{
                    fontSize:'16'
                }
            },
            legend:{
                icon:'circle',
                x:'right',
                y:'top',
                data:['点击次数']
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
            yAxis:{

            },
            series:[{
                type: 'bar',
                name:'点击次数',
                data: nums,
                barWidth:30,
                color:'#FF8000'
            }],
        });
    }

})

//使用制定的配置项和数据显示图表
