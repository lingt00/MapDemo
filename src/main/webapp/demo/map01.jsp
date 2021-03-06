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

    <style>
    </style>
</head>
<body>
    <div class="easyui-layout" fit="true" style="width:100%;height:100%;">
        <div region="west" split="true" title="地图按钮" class="easyui-accordion" style="width:400px;height: auto;">
            <div title="比例尺" iconCls="icon-ok" style="overflow:auto;padding:10px;">
                <a href="javascript:void(0);" onclick="add_scale_control()" class="easyui-linkbutton" iconCls="icon-add">比例尺</a>
                <a href="javascript:void(0);" onclick="del_scale_control()" class="easyui-linkbutton" iconCls="icon-remove">比例尺</a>
            </div>
            <div title="缩放平移" iconCls="icon-ok" style="overflow:auto;padding:10px;">
                <a href="javascript:void(0);" onclick="add_control()" class="easyui-linkbutton" iconCls="icon-add">缩放平移</a>
                <a href="javascript:void(0);" onclick="del_control()" class="easyui-linkbutton" iconCls="icon-remove">缩放平移</a>
            </div>
            <div title="定位" iconCls="icon-ok" style="overflow:auto;padding:10px;">
                <a href="javascript:void(0);" onclick="add_control_address()" class="easyui-linkbutton" iconCls="icon-add">定位</a>
                <a href="javascript:void(0);" onclick="del_control_address()" class="easyui-linkbutton" iconCls="icon-remove">定位</a>
            </div>
        </div>
        <div id="container" region="center" title="地图" style="padding:5px;">

        </div>
    </div>

    <script type="text/javascript">
        var map = new BMap.Map("container");          // 创建地图实例
       var point = new BMap.Point(116.404, 39.915);  // 创建点坐标 北京
        map.centerAndZoom("南京", 11);// 初始化地图，设置中心点坐标和地图级别
        map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

//        map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
//        map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的


        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺

        var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
        var top_right_navigation_address = new BMap.NavigationControl({
            //anchor: BMAP_ANCHOR_TOP_RIGHT,      // 靠右上角位置
            // type: BMAP_NAVIGATION_CONTROL_SMALL, // LARGE类型
            enableGeolocation: true   // 启用显示定位
        });
        /*缩放控件type有四种类型:
         BMAP_NAVIGATION_CONTROL_SMALL：仅包含平移和缩放按钮；
         BMAP_NAVIGATION_CONTROL_PAN:仅包含平移按钮；
         BMAP_NAVIGATION_CONTROL_ZOOM：仅包含缩放按钮*/


        // 添加定位控件
        var geolocationControl = new BMap.GeolocationControl();
        geolocationControl.addEventListener("locationSuccess", function(e){
            // 定位成功事件
            console.log("定位成功!");
            var address = '';
            address += e.addressComponent.province;
            address += e.addressComponent.city;
            address += e.addressComponent.district;
            address += e.addressComponent.street;
            address += e.addressComponent.streetNumber;
            console.log("当前定位地址为：" + address);
        });
        geolocationControl.addEventListener("locationError",function(e){
            // 定位失败事件
            console.log("定位失败!");
            console.log(e);
        });
        map.addControl(geolocationControl);


        //添加控件比例尺
        function add_scale_control(){
            map.addControl(top_left_control);
        }
        function del_scale_control(){
            map.removeControl(top_left_control);
        }

        //添加控件缩放
        function add_control(){
            map.addControl(top_left_navigation);
        }
        function del_control(){
            map.removeControl(top_left_navigation);
        }

        function add_control_address(){
            map.addControl(top_right_navigation_address);
        }
        function del_control_address(){
            map.removeControl(top_right_navigation_address);
        }


    </script>
</body>
</html>
