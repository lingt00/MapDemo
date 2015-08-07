/**
 * Created by IntelliJ IDEA
 * User: lingTao on 2015/6/24 14:57.
 * function:
 */

var myScroll ;
/**
 * 下拉刷新 （自定义实现此方法）
 * myScroll.refresh();		// 数据加载完成后，调用界面更新方法
 */
function pullDownAction () {
    console.log("下拉刷新");
    setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
        $("#thelist>li").remove();

        var el , i;
        el = $("#thelist");
        for (i=0; i<3; i++) {
            var li = $("<li><a data-ajax=\"true\" data-transition=\"slide\"  class=\"ui-btn ui-icon-bullets ui-btn-icon-right\" href=\"/hsc/stujb/hssmsg\">为什么小鑫的名字里有三个金呢?"+new Date().getTime()+"</a></li>");
            el.append(li);
        }
        $("#thelist").listview('refresh');
        myScroll.refresh();		//数据加载完成后，调用界面更新方法   Remember to refresh when contents are loaded (ie: on ajax completion)
    }, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
}

/**
 * 滚动翻页 （自定义实现此方法）
 * myScroll.refresh();		数据加载完成后，调用界面更新方法
 */
function pullUpAction () {
    console.log("上拉翻页");
    setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
        var el , i;
        el = $("#thelist");
        for (i=0; i<3; i++) {
            var li = $("<li><a data-ajax=\"true\" data-transition=\"slide\"  class=\"ui-btn ui-icon-bullets ui-btn-icon-right\" href=\"/hsc/stujb/hssmsg\">为什么小鑫的名字里有三个金呢?"+new Date().getTime()+"</a></li>");
            el.append(li);
        }
        $("#thelist").listview('refresh');
        myScroll.refresh();	// 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
    }, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
}
/**
 * 初始化iScroll控件
 */
function loadedStuMsgList(){
    myScroll = loadedIscroll(myScroll,"wrapper","pullDown","pullUp", pullDownAction,pullUpAction );
//    console.log(myScroll);
}

document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded',loadedStuMsgList, false);