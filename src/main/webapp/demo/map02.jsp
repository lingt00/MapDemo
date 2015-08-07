<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglibs.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>明日博·地图</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="Keywords" content="职业学校管理软件,职业学校管理系统,学历教育管理系统,自考学校管理系统,学历教育管理软件,职业教育管理系统,自考助学机构管理软件"/>
    <meta name="Description" content="明日职业学校管理软件基于科学管理思想设计。全面实现了学员档案管理、出勤管理、收费管理、物资管理、财务管理等软件功能，提升职业学校效率，优化管理。"/>

    <link type="text/css" rel="stylesheet" href="<c:url value="/jQuery/easyui/themes/default/easyui.css"/>"/>
    <%--<link type="text/css" rel="stylesheet" href="<c:url value="/jQuery/easyui/themes/mobile.css"/>"/>--%>
    <link type="text/css" rel="stylesheet" href="<c:url value="/jQuery/easyui/themes/icon.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/demo/map.css"/>"/>

    <script type="text/javascript" src="<c:url value="/jQuery/commontool/jquery-1.8.3.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/jQuery/easyui/jquery.easyui.min.js"/>"></script>
    <%--<script type="text/javascript" src="<c:url value="/jQuery/easyui/jquery.easyui.mobile.js"/>"></script>--%>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=owM2EeseBOT355Dgwu0QMNqK"></script>
    <script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>

    <style>
    </style>
</head>
<body>
    <div class="easyui-layout" fit="true" style="width:100%;height:100%;">
        <div region="west" split="true" title="地图按钮" class="easyui-accordion" style="width:400px;height: auto;">
            <div title="覆盖物" iconCls="icon-ok" style="overflow:auto;padding:10px;">
                <a href="javascript:void(0);" onclick="add_overlay()" class="easyui-linkbutton" iconCls="icon-add">覆盖物</a>
                <a href="javascript:void(0);" onclick="del_overlay()" class="easyui-linkbutton" iconCls="icon-remove">覆盖物</a>
            </div>
        </div>
        <div id="container" region="center" title="地图" style="padding:5px;">

        </div>
    </div>

    <script type="text/javascript">
        var map = new BMap.Map("container");          // 创建地图实例
        var point = new BMap.Point(116.404, 39.915);  // 创建点坐标 北京
        map.centerAndZoom("北京", 11);// 初始化地图，设置中心点坐标和地图级别
        map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
        map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用

        var top_right_navigation_address = new BMap.NavigationControl({
            //anchor: BMAP_ANCHOR_TOP_RIGHT,      // 靠右上角位置
            // type: BMAP_NAVIGATION_CONTROL_SMALL, // LARGE类型
            enableGeolocation: true   // 启用显示定位
        });
        map.addControl(top_right_navigation_address);

        // 添加定位控件
        var geolocationControl = new BMap.GeolocationControl();
        geolocationControl.addEventListener("locationSuccess", function(e){
            // 定位成功事件
            console.log("定位成功!");
            console.log(e);
            var address = '';
            address += e.addressComponent.province;
            address += e.addressComponent.city;
            address += e.addressComponent.district;
            address += e.addressComponent.street;
            address += e.addressComponent.streetNumber;
            console.log("当前定位地址为：" + address);
            console.log(BMap.Convertor);
            BMap.Convertor.translate(e.point,0,makePoint);
        });
        geolocationControl.addEventListener("locationError",function(e){
            // 定位失败事件
            console.log("定位失败!");
            console.log(e);
        });
        map.addControl(geolocationControl);


        var marker = new BMap.Marker(new BMap.Point(116.404, 39.915)); // 创建点
        //marker.enableDragging();  //可拖拽
        //marker.disableDragging();           // 不可拖拽

        var polyline = new BMap.Polyline([
            new BMap.Point(116.399, 39.910),
            new BMap.Point(116.405, 39.920),
            new BMap.Point(116.425, 39.900)
        ], {strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});   //创建折线

        var circle = new BMap.Circle(point,500,{strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5}); //创建圆

        var polygon = new BMap.Polygon([
            new BMap.Point(116.387112,39.920977),
            new BMap.Point(116.385243,39.913063),
            new BMap.Point(116.394226,39.917988),
            new BMap.Point(116.401772,39.921364),
            new BMap.Point(116.41248,39.927893)
        ], {strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});  //创建多边形

        var pStart = new BMap.Point(116.392214,39.918985);
        var pEnd = new BMap.Point(116.41478,39.911901);
        var rectangle = new BMap.Polygon([
            new BMap.Point(pStart.lng,pStart.lat),
            new BMap.Point(pEnd.lng,pStart.lat),
            new BMap.Point(pEnd.lng,pEnd.lat),
            new BMap.Point(pStart.lng,pEnd.lat)
        ], {strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});  //创建矩形

        function add_overlay(){
            map.addOverlay(marker);            //增加点
            map.addOverlay(circle);            //增加圆
        }
        function del_overlay(){
//            map.clearOverlays();
            map.removeOverlay(marker);
            map.removeOverlay(circle);
        }


        function makePoint(point){
            var marker = new BMap.Marker(point);
            map.addOverlay(marker);
            var label = new BMap.Label("我在这里!",{offset:new BMap.Size(20,-10)});
            marker.setLabel(label); //添加百度label
        }
    </script>
</body>
</html>
