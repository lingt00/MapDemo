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
</head>
<body>
    <div class="easyui-layout" fit="true" style="width:100%;height:100%;">
        <div region="west" split="true" title="导航" class="easyui-accordion" style="width:400px;height: auto;">
            <ul class="easyui-tree">
                <li>
                    <span>百度地图</span>
                    <ul>
                        <li>
                            <span>基础案例</span>
                            <ul>
                                <li><span><a href="<c:url value="/demo/map01.jsp"/>">案例01</a></span></li>
                                <li><span><a href="<c:url value="/demo/map02.jsp"/>">案例02</a></span></li>
                                <li><span><a href="<c:url value="/demo/map03.jsp"/>">案例03-地图定位到IP所在城市</a></span></li>
                            </ul>
                        </li>
                        <li><span>File 2</span></li>
                        <li><span>File 3</span></li>
                    </ul>
                </li>
                <li>
                    <span>大转盘抽奖</span>
                    <ul>
                        <li>
                            <span>基础案例</span>
                            <ul>
                                <li><span><a href="<c:url value="/demo/map01.jsp"/>">案例01</a></span></li>
                                <li><span><a href="<c:url value="/demo/map02.jsp"/>">案例02</a></span></li>
                                <li><span><a href="<c:url value="/demo/map03.jsp"/>">案例03-地图定位到IP所在城市</a></span></li>
                            </ul>
                        </li>
                        <li><span>File 2</span></li>
                        <li><span>File 3</span></li>
                    </ul>

                </li>
            </ul>
        </div>
        <div region="center" title="body" style="padding:5px;">

        </div>
    </div>
</body>
</html>
