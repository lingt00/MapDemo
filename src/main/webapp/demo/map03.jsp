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
            <div title="定位" iconCls="icon-ok" style="overflow:auto;padding:10px;">
                <a href="javascript:void(0);" onclick="javascript:geolocationControl.location();" class="easyui-linkbutton" iconCls="icon-add">定位</a>
                <%--<a href="javascript:void(0);" onclick="del_overlay()" class="easyui-linkbutton" iconCls="icon-remove">定位</a>--%>
            </div>
        </div>
        <div id="container" region="center" title="地图" style="padding:5px;">

        </div>
    </div>

    <script type="text/javascript">
        var map = new BMap.Map("container");          // 创建地图实例
       var point = new BMap.Point(116.331398,39.897445);  // 创建点坐标 北京
        map.centerAndZoom(point, 11);// 初始化地图，设置中心点坐标和地图级别
        map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
        map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用

        var top_right_navigation_address = new BMap.NavigationControl({
            //anchor: BMAP_ANCHOR_TOP_RIGHT,      // 靠右上角位置
            // type: BMAP_NAVIGATION_CONTROL_SMALL, // LARGE类型
//            enableGeolocation: true   // 启用显示定位
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
        });
        geolocationControl.addEventListener("locationError",function(e){
            // 定位失败事件
            console.log("定位失败!");
            console.log(e);
        });
        map.addControl(geolocationControl);





        function myFun(result){
            console.log(result);
//            map.setCenter(result.name);

//            map.centerAndZoom(new BMap.Point(result.center.lng , result.center.lat), result.level);
            map.centerAndZoom(result.center , result.level);
        }
        var myCity = new BMap.LocalCity();
        myCity.get(myFun);



//        var geolocation = new BMap.Geolocation();
//        geolocation.getCurrentPosition(function(r){
//            console.log(this.getStatus());
//            console.log(r);
//            if(this.getStatus() == BMAP_STATUS_SUCCESS){
//                var mk = new BMap.Marker(r.point);
//                map.addOverlay(mk);
//                map.panTo(r.point);
//            }else {
//                console.log('failed'+this.getStatus());
//            }
//        },{enableHighAccuracy: true})
        //关于状态码
        //BMAP_STATUS_SUCCESS	检索成功。对应数值“0”。
        //BMAP_STATUS_CITY_LIST	城市列表。对应数值“1”。
        //BMAP_STATUS_UNKNOWN_LOCATION	位置结果未知。对应数值“2”。
        //BMAP_STATUS_UNKNOWN_ROUTE	导航结果未知。对应数值“3”。
        //BMAP_STATUS_INVALID_KEY	非法密钥。对应数值“4”。
        //BMAP_STATUS_INVALID_REQUEST	非法请求。对应数值“5”。
        //BMAP_STATUS_PERMISSION_DENIED	没有权限。对应数值“6”。(自 1.1 新增)
        //BMAP_STATUS_SERVICE_UNAVAILABLE	服务不可用。对应数值“7”。(自 1.1 新增)
        //BMAP_STATUS_TIMEOUT	超时。对应数值“8”。(自 1.1 新增)


    </script>
</body>
</html>
